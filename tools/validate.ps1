param([int]$Port = 9228, [string]$PageUrl = '')
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path $PSScriptRoot -Parent
$browser = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
if (!(Test-Path -LiteralPath $browser)) { $browser = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe' }
$profile = Join-Path $projectRoot ".local-preview/validation-$Port"
$outputDir = Join-Path $projectRoot 'artifacts'
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
$browserProcess = Start-Process -FilePath $browser -WindowStyle Hidden -ArgumentList @('--headless=new', '--disable-gpu', '--disable-backgrounding-occluded-windows', '--disable-renderer-backgrounding', '--no-first-run', '--no-default-browser-check', '--allow-file-access-from-files', "--remote-debugging-port=$Port", "--user-data-dir=`"$profile`"", 'about:blank') -PassThru
$socket = [System.Net.WebSockets.ClientWebSocket]::new()
$script:messageId = 0
$script:browserErrors = [System.Collections.Generic.List[string]]::new()
$projectKeys = @('movimentacoes','smartworking','etl','indicadores','espaco')
function Send-CDP([string]$method, $parameters = @{}) {
  $script:messageId++
  $id = $script:messageId
  $payload = @{ id = $id; method = $method; params = $parameters } | ConvertTo-Json -Depth 30 -Compress
  $bytes = [Text.Encoding]::UTF8.GetBytes($payload)
  $socket.SendAsync([ArraySegment[byte]]::new($bytes), [System.Net.WebSockets.WebSocketMessageType]::Text, $true, [Threading.CancellationToken]::None).GetAwaiter().GetResult() | Out-Null
  do {
    $stream = [IO.MemoryStream]::new()
    do {
      $buffer = New-Object byte[] 65536
      $received = $socket.ReceiveAsync([ArraySegment[byte]]::new($buffer), [Threading.CancellationToken]::None).GetAwaiter().GetResult()
      $stream.Write($buffer, 0, $received.Count)
    } while (!$received.EndOfMessage)
    $message = [Text.Encoding]::UTF8.GetString($stream.ToArray()) | ConvertFrom-Json
    $stream.Dispose()
    if ($message.method -eq 'Runtime.exceptionThrown') { $script:browserErrors.Add(($message.params | ConvertTo-Json -Depth 10 -Compress)) }
  } while ($message.id -ne $id)
  if ($message.error) { throw ($message.error | ConvertTo-Json -Compress) }
  return $message.result
}
function Evaluate([string]$expression) {
  $result = Send-CDP 'Runtime.evaluate' @{ expression = $expression; returnByValue = $true; awaitPromise = $true }
  if ($result.exceptionDetails) { throw ($result.exceptionDetails | ConvertTo-Json -Depth 10) }
  return $result.result.value
}
function Key([string]$key, [int]$code, [int]$modifiers = 0) {
  $parameters = @{type='keyDown';key=$key;code=$key;windowsVirtualKeyCode=$code;modifiers=$modifiers}
  if ($key -eq 'Enter') { $parameters.text = "`r" }
  Send-CDP 'Input.dispatchKeyEvent' $parameters | Out-Null
  Send-CDP 'Input.dispatchKeyEvent' @{type='keyUp';key=$key;code=$key;windowsVirtualKeyCode=$code;modifiers=$modifiers} | Out-Null
}
function Screenshot([string]$name, [bool]$full = $false) {
  if ($full) {
    $metrics = Send-CDP 'Page.getLayoutMetrics'
    $shot = Send-CDP 'Page.captureScreenshot' @{format='png';captureBeyondViewport=$true;clip=@{x=0;y=0;width=$metrics.cssContentSize.width;height=$metrics.cssContentSize.height;scale=1}}
  } else { $shot = Send-CDP 'Page.captureScreenshot' @{format='png'} }
  [IO.File]::WriteAllBytes((Join-Path $outputDir "$name.png"), [Convert]::FromBase64String($shot.data))
}
try {
  for ($attempt = 0; $attempt -lt 30; $attempt++) {
    try { $targets = Invoke-RestMethod "http://localhost:$Port/json" -TimeoutSec 2; break } catch { Start-Sleep -Milliseconds 200 }
  }
  $target = $targets | Where-Object type -eq 'page' | Select-Object -First 1
  $socket.ConnectAsync([Uri]$target.webSocketDebuggerUrl, [Threading.CancellationToken]::None).GetAwaiter().GetResult() | Out-Null
  Send-CDP 'Page.enable' | Out-Null
  Send-CDP 'Runtime.enable' | Out-Null
  Send-CDP 'Page.bringToFront' | Out-Null
  if (!$PageUrl) { $PageUrl = ([Uri](Join-Path $projectRoot 'index.html')).AbsoluteUri }
  $PageUrl = ($PageUrl -split '[?#]')[0] + '?lang=pt'
  Add-Type -AssemblyName System.Drawing
  $socialImage = [Drawing.Image]::FromFile((Join-Path $projectRoot 'assets/images/social-card.png'))
  try { $socialDimensions = $socialImage.Width -eq 1200 -and $socialImage.Height -eq 630 } finally { $socialImage.Dispose() }
  $results = [System.Collections.Generic.List[object]]::new()
  foreach ($size in @(@{name='wide-desktop';width=1920;height=1000},@{name='desktop';width=1440;height=1000},@{name='small-desktop';width=1024;height=900},@{name='tablet';width=768;height=1024},@{name='mobile';width=390;height=844},@{name='small-mobile';width=320;height=740})) {
    Send-CDP 'Emulation.setDeviceMetricsOverride' @{width=$size.width;height=$size.height;deviceScaleFactor=1;mobile=$false} | Out-Null
    Send-CDP 'Page.navigate' @{url=$pageUrl} | Out-Null
    Start-Sleep -Milliseconds 700
    $base = Evaluate @'
JSON.stringify({
 width:innerWidth,
 overflow:document.documentElement.scrollWidth>document.documentElement.clientWidth,
 overflowElements:[...document.querySelectorAll('body *')].filter(e=>e.getBoundingClientRect().right>document.documentElement.clientWidth+1).map(e=>e.className).slice(0,20),
 linksValid:[...document.querySelectorAll('a[href^="#"]')].every(a=>document.querySelector(a.getAttribute('href'))),
 projectCount:document.querySelectorAll('.project').length,
 desks:document.querySelectorAll('.desk').length,
 h1:document.querySelectorAll('h1').length,
 smooth:getComputedStyle(document.documentElement).scrollBehavior==='smooth',
 stylesLoaded:!!document.styleSheets[0]?.cssRules.length,
 contactsValid:document.querySelectorAll('[data-contact]').length===6 && [...document.querySelectorAll('[data-contact]')].every(e=>e.dataset.contact==='github'?e.tagName==='SPAN'&&!e.hasAttribute('href')&&!e.hasAttribute('target')&&e.tabIndex===-1&&e.getAttribute('aria-disabled')==='true':e.dataset.contact==='linkedin'?e.href==='https://www.linkedin.com/in/victorciolarinaldo'&&e.target==='_blank'&&e.rel==='noopener noreferrer':e.dataset.contact==='email'&&e.href==='mailto:victorciola@gmail.com'),
 metadata:[['canonical','https://victorciola-collab.github.io/Portf-lio/'],['og:url','https://victorciola-collab.github.io/Portf-lio/'],['og:type','website'],['og:image','https://victorciola-collab.github.io/Portf-lio/assets/images/social-card.png'],['twitter:image','https://victorciola-collab.github.io/Portf-lio/assets/images/social-card.png'],['twitter:card','summary_large_image']].every(([key,value])=>key==='canonical'?document.querySelector('link[rel=canonical]')?.href===value:document.querySelector('meta[property="'+key+'"],meta[name="'+key+'"]')?.content===value) && document.title==='Victor Ciola Rinaldo | Portfólio Profissional' && !!document.querySelector('meta[property="og:image:alt"]') && !!document.querySelector('meta[name="twitter:image:alt"]'),
 projectTags:document.querySelectorAll('.project .tags li').length===26 && [...document.querySelectorAll('.project')].every(e=>[...e.querySelectorAll('.tags li')].map(t=>t.textContent).join('|')===PROJECTS[e.querySelector('[data-project]').dataset.project].technologies.join('|')),
 microtextContrast:[...document.querySelectorAll('.workflow small,.mock-foot,.floor-legend')].every(e=>getComputedStyle(e).color==='rgb(93, 104, 120)'),
 duplicateIds:[...document.querySelectorAll('[id]')].map(e=>e.id).filter((id,i,all)=>all.indexOf(id)!==i)
})
'@
    $record = $base | ConvertFrom-Json
    $record | Add-Member name $size.name
    Evaluate "document.querySelectorAll('.reveal-ready').forEach(e=>e.classList.add('is-visible')); document.querySelectorAll('*').forEach(e=>e.style.transition='none');" | Out-Null
    Screenshot $size.name $true
    foreach ($projectKey in $projectKeys) {
      Evaluate "document.querySelector('[data-project=$projectKey]').focus();" | Out-Null
      Key 'Enter' 13
      $modal = Evaluate @'
JSON.stringify({open:document.querySelector('dialog').open,focusInside:document.querySelector('dialog').contains(document.activeElement),locked:getComputedStyle(document.body).overflow==='hidden',overflow:document.querySelector('dialog').scrollWidth>document.querySelector('dialog').clientWidth,sections:document.querySelectorAll('.case-block').length,tagsMatch:[...document.querySelectorAll('.project')].some(p=>p.querySelector('h3').textContent===document.querySelector('#dialog-title').textContent&&p.querySelector('.tags').innerHTML===document.querySelector('dialog .tags').innerHTML)})
'@
      $modalRecord = $modal | ConvertFrom-Json
      $modalRecord | Add-Member resultsValid (Evaluate @'
(() => {
  const movement = document.querySelector('#dialog-title').textContent === PROJECTS.movimentacoes.title;
  const smartworking = document.querySelector('#dialog-title').textContent === PROJECTS.smartworking.title;
  const etl = document.querySelector('#dialog-title').textContent === PROJECTS.etl.title;
  const indicators = document.querySelector('#dialog-title').textContent === PROJECTS.indicadores.title;
  const occupation = document.querySelector('#dialog-title').textContent === PROJECTS.espaco.title;
  const cards = [...document.querySelectorAll('.case-kpi')];
  const headings = [...document.querySelectorAll('.case-block h3')].map(e => e.textContent).join('|');
  const expectedHeadings = movement || smartworking || etl || indicators || occupation
    ? (etl ? 'Impacto e benefícios' : 'Resultados e benefícios') + '|Contexto / Problema|Solução|Como funciona|Principais funcionalidades|Screenshots / Preview conceitual'
    : 'Contexto / Problema|Solução|Como funciona|Principais funcionalidades|Resultados e benefícios|Screenshots / Preview conceitual';
  if (headings !== expectedHeadings) return false;
  if (!movement && !smartworking && !etl && !indicators && !occupation) return cards.length === 0;
  const grid = document.querySelector('.case-kpis');
  const rect = grid.getBoundingClientRect();
  return cards.length === 4 && document.querySelector('.case-results').contains(grid)
    && document.querySelector('.case-results').previousElementSibling === document.querySelector('#dialog-content > .tags')
    && cards.map(e => e.querySelector('dd').textContent).join('|') === (movement
      ? 'Desde 2022|Status por etapa|Aprovações organizadas|Histórico centralizado'
      : smartworking ? '13–22 h|~85%|Base centralizada|Aprovações rastreáveis'
      : etl ? '~7–8 h/mês|75%–85%|Tratamento automatizado|Dados padronizados'
      : indicators ? '7 dashboards|Consulta permanente|Exploração interativa|Acesso direto'
      : 'Múltiplos cenários|Déficits e capacidade|Impacto das mudanças|Visão executiva')
    && cards.every(e => e.scrollWidth <= e.clientWidth && e.getBoundingClientRect().right <= rect.right + 1
      && [...e.querySelectorAll('dt,dd')].every(text => text.scrollWidth <= text.clientWidth + 1 && getComputedStyle(text).overflowY === 'visible'))
    && cards.every(e => e.querySelector('svg[aria-hidden="true"][focusable="false"]'))
    && cards.every(e => e.querySelector('dt').textContent !== e.querySelector('.case-kpi-value').textContent)
    && (movement ? cards.map(e => e.querySelector('dt').textContent).join('|') === 'Operação contínua|Acompanhamento|Fluxo estruturado|Rastreabilidade'
      : smartworking ? cards.map(e => e.querySelector('dt').textContent).join('|') === 'Economia mensal|Redução de esforço|Centralização|Rastreabilidade'
      : !etl || cards.map(e => e.querySelector('dt').textContent).join('|') === 'Economia mensal|Redução de esforço|Automação|Padronização')
    && (innerWidth <= 560 ? cards[0].offsetTop < cards[1].offsetTop : cards[0].offsetTop === cards[1].offsetTop)
    && (!(indicators || occupation) || (cards.every(e => e.querySelector('dt').textContent !== e.querySelector('.case-kpi-value').textContent)
      && cards.map(e => e.querySelector('dt').textContent).join('|') === (indicators
        ? 'Abrangência|Disponibilidade|Experiência de análise|Acessibilidade'
        : 'Planejamento|Dimensionamento|Avaliação|Comunicação')
      && (innerWidth <= 560 || (cards[0].offsetHeight === cards[1].offsetHeight
        && cards[2].offsetHeight === cards[3].offsetHeight && cards[2].offsetTop === cards[3].offsetTop))))
    && document.querySelectorAll('.case-results > p').length === (etl || indicators || occupation ? 1 : 3)
    && (occupation ? grid.nextElementSibling === null
      && document.querySelector('.case-results > p').textContent === PROJECTS.espaco.result
      && cards.map(e => e.querySelector('.case-kpi-description').textContent).join('|') === 'Possibilidade de testar diferentes distribuições de equipes e espaços.|Identificação de vagas disponíveis, excedentes e necessidades de alocação.|Recálculo dos indicadores conforme as alocações são ajustadas.|Comparativos e relatórios estruturados para apresentação das propostas.'
      && !document.querySelector('.case-results-note')
      : indicators ? grid.nextElementSibling === null
      && document.querySelector('.case-results > p').textContent === PROJECTS.indicadores.result
      && cards.map(e => e.querySelector('.case-kpi-description').textContent).join('|') === 'Painéis que abrangem diferentes temas e processos de RH.|Indicadores disponíveis independentemente de apresentações pontuais.|Filtros e visualizações para consultar diferentes recortes dos dados.|Áreas de RH podem consultar os painéis sem solicitar relatórios específicos.'
      && !grid.textContent.includes('~12 temas')
      && !document.querySelector('.case-results-note')
      : movement ? cards[1].querySelector('.case-kpi-description').textContent === 'Visibilidade sobre o andamento das solicitações e suas etapas de aprovação.'
        && PROJECTS.movimentacoes.context === 'As solicitações eram registradas em um formulário SharePoint, enquanto as aprovações eram solicitadas por e-mail, sem um fluxo estruturado de aprovação.'
      : !document.querySelector('.case-results-note')
        && cards[0].querySelector('.case-kpi-description').textContent === (etl ? 'Economia mensal estimada de trabalho manual.' : 'Economia mensal estimada de trabalho operacional.')
        && cards[1].querySelector('.case-kpi-description').textContent === (etl ? 'Redução estimada do esforço manual por atualização.' : 'Redução estimada do esforço de preparação e consolidação.')
        && (etl ? grid.nextElementSibling === null
          && cards[2].querySelector('.case-kpi-description').textContent === 'Transformações e integrações executadas por fluxos reutilizáveis.'
          && cards[3].querySelector('.case-kpi-description').textContent === 'Regras consistentes para atualização dos relatórios de RH.'
          && document.querySelector('#dialog-summary').textContent === document.querySelector('[data-project=etl]').closest('.project-copy').querySelector(':scope > p:not(.project-category)').textContent
          && !PROJECTS.etl.summary.includes('extração')
          : grid.nextElementSibling?.tagName === 'P'
            && Math.abs(grid.nextElementSibling.getBoundingClientRect().top - rect.bottom - 20) <= 1));
})()
'@)
      Key 'Tab' 9
      $modalRecord | Add-Member tabContained (Evaluate "document.querySelector('dialog').contains(document.activeElement)")
      Key 'Tab' 9 8
      $modalRecord | Add-Member shiftTabContained (Evaluate "document.querySelector('dialog').contains(document.activeElement)")
      if ($projectKey -eq 'movimentacoes' -and $size.name -in @('desktop','mobile')) { Screenshot "$($size.name)-modal" }
      if ($projectKey -eq 'smartworking') { Screenshot "$($size.name)-smartworking-modal" }
      if ($projectKey -eq 'etl') { Screenshot "$($size.name)-etl-modal" }
      if ($projectKey -eq 'indicadores') { Screenshot "$($size.name)-indicadores-modal" }
      if ($projectKey -eq 'espaco') { Screenshot "$($size.name)-espaco-modal" }
      if ($projectKey -in @('movimentacoes','smartworking','etl','indicadores','espaco')) {
        Evaluate "(()=>{const resultsBlock=document.querySelector('.case-results');document.querySelector('dialog').scrollTop+=resultsBlock.getBoundingClientRect().top-document.querySelector('.dialog-header').getBoundingClientRect().bottom-20;})()" | Out-Null
        if ($projectKey -eq 'movimentacoes') { Screenshot "$($size.name)-modal-results" }
        else { Screenshot "$($size.name)-$projectKey-results" }
      }
      Key 'Escape' 27
      Start-Sleep -Milliseconds 100
      $modalRecord | Add-Member escCloses (Evaluate "!document.querySelector('dialog').open")
      $modalRecord | Add-Member focusRestored (Evaluate "document.activeElement.dataset.project==='$projectKey'")
      $modalRecord | Add-Member scrollRestored (Evaluate "!document.body.classList.contains('modal-open')")
      Evaluate "document.querySelector('[data-project=$projectKey]').click();document.querySelector('.dialog-close').click();" | Out-Null
      Start-Sleep -Milliseconds 100
      $modalRecord | Add-Member buttonCloses (Evaluate "!document.querySelector('dialog').open")
      Evaluate "document.querySelector('[data-project=$projectKey]').click();" | Out-Null
      Send-CDP 'Input.dispatchMouseEvent' @{type='mousePressed';x=2;y=2;button='left';clickCount=1} | Out-Null
      Send-CDP 'Input.dispatchMouseEvent' @{type='mouseReleased';x=2;y=2;button='left';clickCount=1} | Out-Null
      Start-Sleep -Milliseconds 100
      $modalRecord | Add-Member backdropCloses (Evaluate "!document.querySelector('dialog').open && document.activeElement.dataset.project==='$projectKey'")
      if (Evaluate "document.querySelector('dialog').open") { Evaluate "document.querySelector('dialog').close();" | Out-Null; Start-Sleep -Milliseconds 100 }
      if ($projectKey -eq 'movimentacoes') {
        $modalRecord | Add-Member noOperationalVolume (Evaluate "!(/11\s*mil|volume operacional|pending-public-validation/i.test(document.body.textContent + JSON.stringify(PROJECTS)))")
      }
      $record | Add-Member $projectKey $modalRecord
    }
    if ($size.width -le 800) {
      Evaluate "document.querySelector('.menu-toggle').focus();" | Out-Null
      Key 'Enter' 13
      Start-Sleep -Milliseconds 100
      $record | Add-Member menuOpens (Evaluate "document.querySelector('.menu-toggle').getAttribute('aria-expanded')==='true' && getComputedStyle(document.querySelector('nav')).display!=='none'")
      Screenshot "$($size.name)-menu"
      Key 'Escape' 27
      $record | Add-Member menuEscCloses (Evaluate "document.querySelector('.menu-toggle').getAttribute('aria-expanded')==='false'")
      Evaluate 'document.querySelector(".menu-toggle").click();document.querySelector("nav a[href=''#projetos'']").click();' | Out-Null
      $record | Add-Member menuLinkCloses (Evaluate "document.querySelector('.menu-toggle').getAttribute('aria-expanded')==='false'")
      # Aguarda a navegação do menu antes de iniciar outra rolagem suave.
      Start-Sleep -Milliseconds 1000
    } else {
      $record | Add-Member desktopMenuVisible (Evaluate "getComputedStyle(document.querySelector('nav')).display==='flex'")
    }
    Evaluate 'document.querySelector("a[href=''#projetos''].button").click();' | Out-Null
    for ($scrollAttempt = 0; $scrollAttempt -lt 40; $scrollAttempt++) {
      Start-Sleep -Milliseconds 100
      if (Evaluate "Math.abs(document.querySelector('#projetos').getBoundingClientRect().top-parseFloat(getComputedStyle(document.documentElement).scrollPaddingTop))<4") { break }
    }
    Screenshot "$($size.name)-scroll"
    $record | Add-Member scrollPosition (Evaluate "JSON.stringify({y:scrollY,top:document.querySelector('#projetos').getBoundingClientRect().top,padding:getComputedStyle(document.documentElement).scrollPaddingTop})")
    $record | Add-Member projectScroll (Evaluate "location.hash==='#projetos' && Math.abs(document.querySelector('#projetos').getBoundingClientRect().top-parseFloat(getComputedStyle(document.documentElement).scrollPaddingTop))<4")
    $record | Add-Member activeNav (Evaluate "document.querySelector('nav a[aria-current]').hash==='#projetos'")
    $record | Add-Member siteSections (Evaluate "[...document.querySelectorAll('main > section')].map(e=>e.id).join(',')==='inicio,sobre,solucoes,projetos,contato'")
    $record | Add-Member menuSections (Evaluate "[...document.querySelectorAll('nav a')].map(e=>e.textContent.trim().replace(' ↗','')).join(',')==='Início,Sobre,Soluções,Projetos,Contato'")
    $record | Add-Member sectionNumbers (Evaluate "[...document.querySelectorAll('main > section:not(#inicio)')].map(e=>e.querySelector('.eyebrow').textContent.trim().toUpperCase()).join(',')==='01 / SOBRE,02 / SOLUÇÕES,03 / PROJETOS,04 / CONTATO'")
    $record | Add-Member techIcons (Evaluate "document.querySelectorAll('.solution-technologies .tech-icon svg').length===13 && document.querySelectorAll('.project .tags .tech-icon svg').length===21 && !document.querySelector('.solution-technologies img') && [...document.querySelectorAll('main .tech-icon svg')].every(icon=>getComputedStyle(icon).stroke==='rgb(36, 91, 219)' && icon.getBoundingClientRect().width===18 && icon.getBoundingClientRect().height===18)")
    $record | Add-Member technologyTags (Evaluate "[...document.querySelectorAll('.solution-technologies')].map(list=>[...list.querySelectorAll('.tech-tag > span:last-child')].map(e=>e.textContent).join(',')).join(';')==='Power BI,DAX,Excel;Power Query,SQL,Python;Power Apps,Power Automate,SharePoint,JavaScript,HTML / CSS,VBA,Git / GitHub' && document.querySelectorAll('.tech-tag').length===13 && [...document.querySelectorAll('.tech-tag')].every(e=>e.offsetHeight===32 && getComputedStyle(e).animationName==='none' && e.getBoundingClientRect().right<=e.parentElement.getBoundingClientRect().right+1)")
    $record | Add-Member solutionPillars (Evaluate "[...document.querySelectorAll('.solution h3')].map(e=>e.textContent).join(',')==='Análise de Dados & BI,Preparação de Dados & ETL,Automação & Aplicações' && document.querySelectorAll('.solution').length===3")
    foreach ($sectionId in @('sobre','solucoes')) {
      Evaluate "document.activeElement.blur();document.querySelector('#$sectionId').scrollIntoView({behavior:'instant'});" | Out-Null
      Start-Sleep -Milliseconds 100
      $sectionRegion = Evaluate "JSON.stringify((()=>{const e=document.querySelector('#$sectionId');return {x:0,y:e.getBoundingClientRect().top+scrollY,width:document.documentElement.clientWidth,height:e.offsetHeight,scale:1}})())" | ConvertFrom-Json
      $sectionImage = Send-CDP 'Page.captureScreenshot' @{format='png';captureBeyondViewport=$true;clip=$sectionRegion}
      [IO.File]::WriteAllBytes((Join-Path $outputDir "$($size.name)-$sectionId.png"), [Convert]::FromBase64String($sectionImage.data))
    }
    if ($size.width -le 800) { Evaluate 'document.querySelector(".menu-toggle").click();' | Out-Null }
    Evaluate 'document.querySelector("nav a[href=''#contato'']").click();' | Out-Null
    for ($scrollAttempt = 0; $scrollAttempt -lt 30; $scrollAttempt++) {
      Start-Sleep -Milliseconds 100
      if (Evaluate "window.innerHeight + scrollY >= document.documentElement.scrollHeight - 4 && document.querySelector('nav a[aria-current]').hash==='#contato'") { break }
    }
    $record | Add-Member contactNavigation (Evaluate "location.hash==='#contato' && document.activeElement.id==='contato' && document.querySelector('nav a[aria-current]').hash==='#contato'")
    $record | Add-Member skipLinkFocus (Evaluate "document.querySelector('.skip-link').click();document.activeElement.id==='conteudo'")
    $results.Add($record)
  }
  Send-CDP 'Emulation.setEmulatedMedia' @{features=@(@{name='prefers-reduced-motion';value='reduce'})} | Out-Null
  $reduced = Evaluate "getComputedStyle(document.documentElement).scrollBehavior==='auto' && [...document.querySelectorAll('.reveal-ready')].every(e=>getComputedStyle(e).opacity==='1')"
  $report = @{pageUrl=$PageUrl;viewports=$results;socialDimensions=$socialDimensions;reducedMotion=$reduced;runtimeErrors=$script:browserErrors}
  $failures = [System.Collections.Generic.List[string]]::new()
  foreach ($row in $results) {
    foreach ($check in @('linksValid','smooth','stylesLoaded','contactsValid','metadata','projectTags','microtextContrast','projectScroll','activeNav','skipLinkFocus','siteSections','menuSections','sectionNumbers','techIcons','technologyTags','solutionPillars','contactNavigation')) {
      if (!$row.$check) { $failures.Add("$($row.name): $check") }
    }
    if ($row.overflow -or $row.duplicateIds.Count -or $row.projectCount -ne 5 -or $row.h1 -ne 1) { $failures.Add("$($row.name): estrutura ou overflow") }
    if ($row.width -le 800) {
      foreach ($check in @('menuOpens','menuEscCloses','menuLinkCloses')) { if (!$row.$check) { $failures.Add("$($row.name): $check") } }
    } elseif (!$row.desktopMenuVisible) { $failures.Add('Menu desktop') }
    foreach ($projectKey in $projectKeys) {
      $modal = $row.$projectKey
      foreach ($check in @('open','focusInside','locked','tabContained','shiftTabContained','escCloses','focusRestored','scrollRestored','buttonCloses','backdropCloses','tagsMatch','resultsValid')) {
        if (!$modal.$check) { $failures.Add("$($row.name), ${projectKey}: $check") }
      }
      if ($modal.overflow) { $failures.Add("$($row.name), ${projectKey}: overflow") }
      if ($projectKey -eq 'movimentacoes' -and !$modal.noOperationalVolume) { $failures.Add("$($row.name): volume operacional no conteúdo público") }
    }
  }
  if (!$socialDimensions) { $failures.Add('Imagem social: dimensões diferentes de 1200 x 630') }
  if (!$reduced) { $failures.Add('Redução de movimento') }
  if ($script:browserErrors.Count) { $failures.Add('Erros JavaScript') }
  $report.passed = $failures.Count -eq 0
  $report.failures = $failures
  $report | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath (Join-Path $outputDir 'validation.json') -Encoding UTF8
  $report | ConvertTo-Json -Depth 10
  if ($failures.Count) { throw ($failures -join '; ') }
} finally {
  $socket.Dispose()
  # Encerra somente o processo headless iniciado por este validador.
  if ($browserProcess -and !$browserProcess.HasExited) { $browserProcess.Kill() }
}
