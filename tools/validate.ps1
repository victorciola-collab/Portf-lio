param([int]$Port = 9228)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path $PSScriptRoot -Parent
$browser = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
if (!(Test-Path -LiteralPath $browser)) { $browser = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe' }
$profile = Join-Path $projectRoot '.local-preview'
$outputDir = Join-Path $projectRoot 'artifacts'
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
$browserProcess = Start-Process -FilePath $browser -WindowStyle Hidden -ArgumentList @('--headless=new', '--disable-gpu', '--disable-backgrounding-occluded-windows', '--disable-renderer-backgrounding', '--no-first-run', '--no-default-browser-check', '--allow-file-access-from-files', "--remote-debugging-port=$Port", "--user-data-dir=`"$profile`"", 'about:blank') -PassThru
$socket = [System.Net.WebSockets.ClientWebSocket]::new()
$script:messageId = 0
$script:browserErrors = [System.Collections.Generic.List[string]]::new()
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
    try { $targets = Invoke-RestMethod "http://localhost:$Port/json"; break } catch { Start-Sleep -Milliseconds 200 }
  }
  $target = $targets | Where-Object type -eq 'page' | Select-Object -First 1
  $socket.ConnectAsync([Uri]$target.webSocketDebuggerUrl, [Threading.CancellationToken]::None).GetAwaiter().GetResult() | Out-Null
  Send-CDP 'Page.enable' | Out-Null
  Send-CDP 'Runtime.enable' | Out-Null
  Send-CDP 'Page.bringToFront' | Out-Null
  $pageUrl = ([Uri](Join-Path $projectRoot 'index.html')).AbsoluteUri
  $results = [System.Collections.Generic.List[object]]::new()
  foreach ($size in @(@{name='desktop';width=1440;height=1000},@{name='tablet';width=768;height=1024},@{name='mobile';width=390;height=844},@{name='small-mobile';width=320;height=740})) {
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
 missingContacts:[...document.querySelectorAll('[data-contact]')].every(a=>!a.hasAttribute('href')&&a.getAttribute('aria-disabled')==='true'),
 duplicateIds:[...document.querySelectorAll('[id]')].map(e=>e.id).filter((id,i,all)=>all.indexOf(id)!==i)
})
'@
    $record = $base | ConvertFrom-Json
    $record | Add-Member name $size.name
    Evaluate "document.querySelectorAll('.reveal-ready').forEach(e=>e.classList.add('is-visible')); document.querySelectorAll('*').forEach(e=>e.style.transition='none');" | Out-Null
    Screenshot $size.name $true
    foreach ($projectKey in @('movimentacoes','espaco')) {
      Evaluate "document.querySelector('[data-project=$projectKey]').focus();" | Out-Null
      Key 'Enter' 13
      $modal = Evaluate @'
JSON.stringify({open:document.querySelector('dialog').open,focusInside:document.querySelector('dialog').contains(document.activeElement),locked:getComputedStyle(document.body).overflow==='hidden',overflow:document.querySelector('dialog').scrollWidth>document.querySelector('dialog').clientWidth,sections:document.querySelectorAll('.case-block').length})
'@
      $modalRecord = $modal | ConvertFrom-Json
      Key 'Tab' 9
      $modalRecord | Add-Member tabContained (Evaluate "document.querySelector('dialog').contains(document.activeElement)")
      Key 'Tab' 9 8
      $modalRecord | Add-Member shiftTabContained (Evaluate "document.querySelector('dialog').contains(document.activeElement)")
      if ($projectKey -eq 'movimentacoes' -and $size.name -in @('desktop','mobile')) { Screenshot "$($size.name)-modal" }
      Key 'Escape' 27
      Start-Sleep -Milliseconds 100
      $modalRecord | Add-Member escCloses (Evaluate "!document.querySelector('dialog').open")
      $modalRecord | Add-Member focusRestored (Evaluate "document.activeElement.dataset.project==='$projectKey'")
      $modalRecord | Add-Member scrollRestored (Evaluate "!document.body.classList.contains('modal-open')")
      Evaluate "document.querySelector('[data-project=$projectKey]').click();document.querySelector('.dialog-close').click();" | Out-Null
      Start-Sleep -Milliseconds 100
      $modalRecord | Add-Member buttonCloses (Evaluate "!document.querySelector('dialog').open")
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
    } else {
      $record | Add-Member desktopMenuVisible (Evaluate "getComputedStyle(document.querySelector('nav')).display==='flex'")
    }
    Evaluate 'document.querySelector("a[href=''#projetos''].button").click();' | Out-Null
    Start-Sleep -Milliseconds 900
    Screenshot "$($size.name)-scroll"
    $record | Add-Member scrollPosition (Evaluate "JSON.stringify({y:scrollY,top:document.querySelector('#projetos').getBoundingClientRect().top,padding:getComputedStyle(document.documentElement).scrollPaddingTop})")
    $record | Add-Member projectScroll (Evaluate "location.hash==='#projetos' && Math.abs(document.querySelector('#projetos').getBoundingClientRect().top-parseFloat(getComputedStyle(document.documentElement).scrollPaddingTop))<4")
    $record | Add-Member activeNav (Evaluate "document.querySelector('nav a[aria-current]').hash==='#projetos'")
    $record | Add-Member siteSections (Evaluate "[...document.querySelectorAll('main > section')].map(e=>e.id).join(',')==='inicio,sobre,solucoes,projetos,contato'")
    $record | Add-Member menuSections (Evaluate "[...document.querySelectorAll('nav a')].map(e=>e.textContent.trim().replace(' ↗','')).join(',')==='Início,Sobre,Soluções,Projetos,Contato'")
    $record | Add-Member sectionNumbers (Evaluate "[...document.querySelectorAll('main > section:not(#inicio)')].map(e=>e.querySelector('.eyebrow').textContent.trim().toUpperCase()).join(',')==='01 / SOBRE,02 / SOLUÇÕES,03 / PROJETOS,04 / CONTATO'")
    $record | Add-Member techIcons (Evaluate "document.querySelectorAll('.tech-icon svg').length===13 && !document.querySelector('.solution-technologies img') && [...document.querySelectorAll('.tech-icon svg')].every(icon=>getComputedStyle(icon).stroke==='rgb(36, 91, 219)' && icon.getBoundingClientRect().width===18 && icon.getBoundingClientRect().height===18)")
    $record | Add-Member technologyTags (Evaluate "[...document.querySelectorAll('.solution-technologies')].map(list=>[...list.querySelectorAll('.tech-tag > span:last-child')].map(e=>e.textContent).join(',')).join(';')==='Power BI,DAX,Excel;Power Query,SQL,Python;Power Apps,Power Automate,SharePoint,JavaScript,HTML / CSS,VBA,Git / GitHub' && document.querySelectorAll('.tech-tag').length===13 && [...document.querySelectorAll('.tech-tag')].every(e=>e.offsetHeight===32 && getComputedStyle(e).animationName==='none' && e.getBoundingClientRect().right<=e.parentElement.getBoundingClientRect().right+1)")
    $record | Add-Member solutionPillars (Evaluate "[...document.querySelectorAll('.solution h3')].map(e=>e.textContent).join(',')==='Analytics,Data Preparation & ETL,Automation & Applications' && document.querySelectorAll('.solution').length===3")
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
  $report = @{viewports=$results;reducedMotion=$reduced;runtimeErrors=$script:browserErrors}
  $failures = [System.Collections.Generic.List[string]]::new()
  foreach ($row in $results) {
    foreach ($check in @('linksValid','smooth','stylesLoaded','missingContacts','projectScroll','activeNav','skipLinkFocus','siteSections','menuSections','sectionNumbers','techIcons','technologyTags','solutionPillars','contactNavigation')) {
      if (!$row.$check) { $failures.Add("$($row.name): $check") }
    }
    if ($row.overflow -or $row.duplicateIds.Count -or $row.projectCount -ne 2) { $failures.Add("$($row.name): estrutura ou overflow") }
    if ($row.width -le 800) {
      foreach ($check in @('menuOpens','menuEscCloses','menuLinkCloses')) { if (!$row.$check) { $failures.Add("$($row.name): $check") } }
    } elseif (!$row.desktopMenuVisible) { $failures.Add('Menu desktop') }
    foreach ($projectKey in @('movimentacoes','espaco')) {
      $modal = $row.$projectKey
      foreach ($check in @('open','focusInside','locked','tabContained','shiftTabContained','escCloses','focusRestored','scrollRestored','buttonCloses')) {
        if (!$modal.$check) { $failures.Add("$($row.name), ${projectKey}: $check") }
      }
      if ($modal.overflow) { $failures.Add("$($row.name), ${projectKey}: overflow") }
    }
  }
  if (!$reduced) { $failures.Add('Redução de movimento') }
  if ($script:browserErrors.Count) { $failures.Add('Erros JavaScript') }
  $report.passed = $failures.Count -eq 0
  $report.failures = $failures
  $report | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath (Join-Path $outputDir 'validation.json') -Encoding UTF8
  $report | ConvertTo-Json -Depth 10
  if ($failures.Count) { throw ($failures -join '; ') }
} finally {
  if ($socket.State -eq [System.Net.WebSockets.WebSocketState]::Open) {
    try { Send-CDP 'Browser.close' | Out-Null } catch {}
  }
  $socket.Dispose()
}
