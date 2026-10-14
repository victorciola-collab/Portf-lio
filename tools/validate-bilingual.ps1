param([int]$Port=9270)
$ErrorActionPreference='Stop'
$projectRoot=Split-Path $PSScriptRoot -Parent
$outputDir=Join-Path $projectRoot 'artifacts/bilingual'
New-Item -ItemType Directory -Force -Path $outputDir|Out-Null
$profile=Join-Path $projectRoot ".local-preview/bilingual-$Port"
$browser='C:\Program Files\Google\Chrome\Application\chrome.exe'
if(!(Test-Path $browser)){$browser='C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'}
$browserProcess=Start-Process -FilePath $browser -WindowStyle Hidden -ArgumentList @('--headless=new','--disable-gpu','--disable-background-networking','--no-first-run','--no-default-browser-check','--allow-file-access-from-files',"--remote-debugging-port=$Port","--user-data-dir=`"$profile`"",'about:blank') -PassThru
$socket=[Net.WebSockets.ClientWebSocket]::new()
$script:messageId=0
$script:browserErrors=[Collections.Generic.List[string]]::new()
$helper=Get-Content (Join-Path $PSScriptRoot 'validate.ps1') -Raw -Encoding UTF8
$start=$helper.IndexOf('function Send-CDP')
$end=$helper.IndexOf('try {',$start)
Invoke-Expression $helper.Substring($start,$end-$start)
function Assert($v,$m){if(!$v){throw $m}}
function Wait-Ready {
 Start-Sleep -Milliseconds 150
 for($readyAttempt=0;$readyAttempt -lt 40;$readyAttempt++){
  if(Evaluate "document.readyState==='complete'&&!!window.PortfolioI18n&&!!window.PORTFOLIO_EN"){return}
  Start-Sleep -Milliseconds 100
 }
 throw 'Page initialization timed out'
}
$records=[Collections.Generic.List[object]]::new()
try {
 for($i=0;$i -lt 15;$i++){try{$targets=Invoke-RestMethod "http://127.0.0.1:$Port/json" -TimeoutSec 2;break}catch{Start-Sleep -Milliseconds 200}}
 $target=$targets|Where-Object type -eq 'page'|Select-Object -First 1
 $socket.ConnectAsync([Uri]$target.webSocketDebuggerUrl,[Threading.CancellationToken]::None).GetAwaiter().GetResult()|Out-Null
 Send-CDP 'Page.enable'|Out-Null
 Send-CDP 'Runtime.enable'|Out-Null
 Send-CDP 'Emulation.setEmulatedMedia' @{features=@(@{name='prefers-reduced-motion';value='reduce'})}|Out-Null
 foreach($lang in @('pt','en')){
  foreach($page in @('index.html','privacidade.html')){
   foreach($width in @(320,390,600,768,800,801,1024,1440,1920)){
    Send-CDP 'Emulation.setDeviceMetricsOverride' @{width=$width;height=900;deviceScaleFactor=1;mobile=$false}|Out-Null
    Send-CDP 'Page.navigate' @{url=([Uri](Join-Path $projectRoot $page)).AbsoluteUri+'?lang='+$lang}|Out-Null
    Wait-Ready
    $base=Evaluate @'
(() => {
 const h=document.querySelector('.header-inner'), b=document.querySelector('.brand'), s=document.querySelector('.language-switch'), m=document.querySelector('.menu-toggle'), n=document.querySelector('.main-nav');
 const boxes=[b,s,...(m&&getComputedStyle(m).display!=='none'?[m]:n?[n]:[])].map(e=>e.getBoundingClientRect());
 const map=Object.assign({},...Object.values(PORTFOLIO_EN)),walker=document.createTreeWalker(document.body,NodeFilter.SHOW_TEXT),residual=[];let node;
 while(node=walker.nextNode()){if(node.parentElement.closest('script,style,noscript,svg'))continue;const t=node.nodeValue.trim();if(map[t]&&map[t]!==t)residual.push(t);}
 const header=boxes.every(r=>r.left>=h.getBoundingClientRect().left-1&&r.right<=h.getBoundingClientRect().right+1)&&boxes.every((r,j)=>boxes.every((other,k)=>j===k||r.right<=other.left+1||other.right<=r.left+1||r.bottom<=other.top||other.bottom<=r.top));
 return JSON.stringify({language:PortfolioI18n.language,width:innerWidth,header,overflow:document.documentElement.scrollWidth>document.documentElement.clientWidth,residual:PortfolioI18n.language==='en'?residual:[],selected:document.querySelector('[data-language="'+PortfolioI18n.language+'"]').getAttribute('aria-pressed')==='true',tagAbsent:!document.querySelector('#ga4-tag')});
})()
'@ | ConvertFrom-Json
    Assert ($base.language -eq $lang -and $base.selected -and $base.header -and !$base.overflow -and !$base.residual.Count -and $base.tagAbsent) ($page+' '+$lang+' '+$width+': '+($base|ConvertTo-Json -Depth 4 -Compress))
    $base|Add-Member page $page
    if($page -eq 'index.html'){
     foreach($key in @('movimentacoes','smartworking','etl','indicadores','espaco')){
      Evaluate "document.querySelector('[data-project=$key]').focus();document.querySelector('[data-project=$key]').click();"|Out-Null
      $modal=Evaluate @'
(() => {
 const d=document.querySelector('dialog'),cards=[...d.querySelectorAll('.case-kpi')],id=[...document.querySelectorAll('[data-project]')].find(b=>PortfolioI18n.t(PROJECTS[b.dataset.project].title)===document.querySelector('#dialog-title').textContent).dataset.project;
 const p=PROJECTS[id],g=d.querySelector('.case-kpis'),r=g.getBoundingClientRect();
 return JSON.stringify({open:d.open,focus:d.contains(document.activeElement),cards:cards.length,values:cards.map(c=>c.querySelector('.case-kpi-value').textContent).join('|')===p.kpis.map(k=>PortfolioI18n.t(k.value)).join('|'),titles:cards.map(c=>c.querySelector('dt').textContent).join('|')===p.kpis.map(k=>PortfolioI18n.t(k.title)).join('|'),preview:d.querySelector('.project-preview').textContent===document.querySelector(p.preview).textContent,overflow:d.scrollWidth>d.clientWidth||cards.some(c=>c.scrollWidth>c.clientWidth||c.getBoundingClientRect().right>r.right+1||[...c.querySelectorAll('dt,dd')].some(t=>t.scrollWidth>t.clientWidth+1))});
})()
'@ | ConvertFrom-Json
      Assert ($modal.open -and $modal.focus -and $modal.cards -eq 4 -and $modal.values -and $modal.titles -and $modal.preview -and !$modal.overflow) ("Modal $key $lang ${width}: "+($modal|ConvertTo-Json -Compress))
      Key 'Tab' 9
      Assert (Evaluate "document.querySelector('dialog').contains(document.activeElement)") 'Tab contained'
      Key 'Tab' 9 8
      Assert (Evaluate "document.querySelector('dialog').contains(document.activeElement)") 'Shift Tab contained'
      Evaluate "(()=>{const title=document.querySelector('#dialog-title');PortfolioI18n.setLanguage(PortfolioI18n.language==='pt'?'en':'pt');window.__sameDialogNode=title===document.querySelector('#dialog-title');PortfolioI18n.setLanguage('$lang');})()"|Out-Null
      Assert (Evaluate "window.__sameDialogNode&&document.querySelector('dialog').open") 'In-place update'
      if($width -in @(390,1440) -and $key -eq 'smartworking'){Screenshot "$lang-$width-smartworking"}
      Key 'Escape' 27
      Start-Sleep -Milliseconds 100
      Assert (Evaluate "!document.querySelector('dialog').open&&document.activeElement.dataset.project==='$key'&&!document.body.classList.contains('modal-open')") 'Escape/focus'
      Evaluate "document.querySelector('[data-project=$key]').click();document.querySelector('.dialog-close').click();"|Out-Null
      Assert (Evaluate "!document.querySelector('dialog').open") 'Close button'
     }
     if($width -le 800){
      Evaluate "document.querySelector('.menu-toggle').click();"|Out-Null
      Assert (Evaluate "document.querySelector('.menu-toggle').getAttribute('aria-expanded')==='true'") 'Menu opens'
      Key 'Escape' 27
      Assert (Evaluate "document.querySelector('.menu-toggle').getAttribute('aria-expanded')==='false'") 'Menu Escape'
      Evaluate 'document.querySelector(".menu-toggle").click();document.querySelector("nav a[href=''#projetos'']").click();'|Out-Null
     }else{Evaluate 'document.querySelector("nav a[href=''#projetos'']").click();'|Out-Null}
     Assert (Evaluate "location.hash==='#projetos'&&new URL(location.href).searchParams.get('lang')==='$lang'") 'Anchor language'
     Evaluate "document.activeElement.blur();window.scrollTo({top:0,behavior:'instant'});"|Out-Null
    }
    if($width -in @(390,1440)){Evaluate "document.querySelector('[data-consent-close]').click();"|Out-Null;Screenshot "$lang-$width-$($page.Replace('.html',''))"}
    $records.Add($base)
   }
  }
 }
 $entry=([Uri](Join-Path $projectRoot 'index.html')).AbsoluteUri
 Evaluate "localStorage.setItem('portfolio.language.v1','pt');"|Out-Null
 Send-CDP 'Page.navigate' @{url=$entry+'?lang=en'}|Out-Null
 Wait-Ready
 Assert (Evaluate "PortfolioI18n.language==='en'") 'URL precedence'
 Evaluate "document.querySelector('[data-language=pt]').click();document.querySelector('[data-language=en]').click();"|Out-Null
 Send-CDP 'Page.reload'|Out-Null
 Wait-Ready
 Assert (Evaluate "PortfolioI18n.language==='en'") 'Refresh'
 Evaluate "document.querySelector('.footer a.privacy-link').click();"|Out-Null
 Wait-Ready
 Assert (Evaluate "!!document.querySelector('.privacy-document')&&PortfolioI18n.language==='en'") 'Privacy navigation'
 Evaluate "document.querySelector('.brand').click();"|Out-Null
 Wait-Ready
 Assert (Evaluate "!!document.querySelector('#inicio')&&PortfolioI18n.language==='en'") 'Return'
 $blocked=Send-CDP 'Page.addScriptToEvaluateOnNewDocument' @{source="Storage.prototype.getItem=function(){throw Error('blocked')};Storage.prototype.setItem=function(){throw Error('blocked')};"}
 Send-CDP 'Page.navigate' @{url=$entry+'?lang=en'}|Out-Null
 Wait-Ready
 Evaluate "document.querySelector('[data-language=pt]').click();document.querySelector('[data-language=en]').click();"|Out-Null
 Send-CDP 'Page.reload'|Out-Null
 Wait-Ready
 Assert (Evaluate "PortfolioI18n.language==='en'&&!document.querySelector('#ga4-tag')") 'Blocked storage'
 Send-CDP 'Page.navigate' @{url=$entry}|Out-Null
 Wait-Ready
 Assert (Evaluate "PortfolioI18n.language==='pt'") 'PT fallback'
 Send-CDP 'Page.removeScriptToEvaluateOnNewDocument' @{identifier=$blocked.identifier}|Out-Null
 Assert ($script:browserErrors.Count -eq 0) 'Runtime errors'
 @{passed=$true;viewports=$records;runtimeErrors=$script:browserErrors;urlPersistence=$true;blockedStorage=$true}|ConvertTo-Json -Depth 8|Set-Content (Join-Path $outputDir 'validation.json') -Encoding UTF8
 "Bilingual: $($records.Count) viewport/page/language combinations and 90 modal checks passed."
}finally{$socket.Dispose();if($browserProcess -and !$browserProcess.HasExited){$browserProcess.Kill()}}
