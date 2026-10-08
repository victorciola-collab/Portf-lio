param([int]$Port = 9245, [int]$HttpPort = 8771, [switch]$RealTag)
$ErrorActionPreference = 'Stop'
$projectRoot = Split-Path $PSScriptRoot -Parent
$auditProjectRoot = $projectRoot
$baseUrl = "http://127.0.0.1:$HttpPort/Portf-lio/"
$server = Start-Job -ArgumentList $projectRoot,$HttpPort -ScriptBlock {
  param($root,$port)
  $listener = [Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback,$port)
  $listener.Start()
  try {
    while ($true) {
      if (!$listener.Pending()) { Start-Sleep -Milliseconds 50; continue }
      $client = $listener.AcceptTcpClient(); $stream = $client.GetStream()
      $reader = [IO.StreamReader]::new($stream,[Text.Encoding]::ASCII,$false,1024,$true)
      $line = $reader.ReadLine(); while ($reader.ReadLine()) {}
      $path = ([Uri]('http://localhost'+$line.Split(' ')[1])).AbsolutePath
      $relative = [Uri]::UnescapeDataString($path).Replace('/Portf-lio/','')
      if (!$relative) { $relative = 'index.html' }
      $allowed = @('index.html','privacidade.html','assets/css/styles.css','assets/js/app.js','assets/js/analytics.js','assets/images/favicon.svg','assets/images/social-card.png')
      $status = '404 Not Found'; $mime = 'text/plain'; $body = [Text.Encoding]::UTF8.GetBytes('Not found')
      if ($path.StartsWith('/Portf-lio/') -and ($allowed -ccontains $relative)) {
        $status = '200 OK'; $body = [IO.File]::ReadAllBytes((Join-Path $root $relative))
        $mime = switch ([IO.Path]::GetExtension($relative)) {
          '.html' {'text/html; charset=utf-8'} '.css' {'text/css; charset=utf-8'}
          '.js' {'application/javascript; charset=utf-8'} '.svg' {'image/svg+xml'} '.png' {'image/png'}
        }
      }
      $header = [Text.Encoding]::ASCII.GetBytes("HTTP/1.1 $status"+[char]13+[char]10+"Content-Type: $mime"+[char]13+[char]10+"Content-Length: $($body.Length)"+[char]13+[char]10+"Connection: close"+[char]13+[char]10+[char]13+[char]10)
      $stream.Write($header,0,$header.Length); $stream.Write($body,0,$body.Length)
      $reader.Dispose(); $client.Dispose()
    }
  } finally { $listener.Stop() }
}
# Simulated transport: validates the integration without polluting the real GA4 property.
$mockTag = @'
(() => {
 const layer=window.dataLayer, originalPush=layer.push.bind(layer);
 window.__analyticsTest={commands:[],events:[]};
 function process(item) {
  const args=Array.from(item);window.__analyticsTest.commands.push(args);
  if(args[0]==='config') {
   const c=args[2];document.cookie='portfolio_ga=test; path='+c.cookie_path;
   document.cookie='portfolio_ga_TPV93SY9ZY=test; path='+c.cookie_path;
  }
  if(args[0]!=='event'||window['ga-disable-G-TPV93SY9ZY'])return;
  const [_,name,parameters]=args;window.__analyticsTest.events.push({name,parameters});
  const q=new URLSearchParams({en:name,tid:'G-TPV93SY9ZY'});
  fetch('https://www.google-analytics.com/g/collect?'+q,{mode:'no-cors'}).catch(()=>{});
 }
 layer.push=(...items)=>{const result=originalPush(...items);items.forEach(process);return result};
 Array.from(layer).forEach(process);
})();
'@
$script:tagBody = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($mockTag))
$script:networkRequests = [System.Collections.Generic.List[string]]::new()
$script:interceptedRequests = [System.Collections.Generic.List[string]]::new()
$script:holdTag = $false
$script:collectorEvents = [System.Collections.Generic.List[string]]::new()
function Reply-Fetch($parameters) {
  $script:messageId++
  $payload = @{id=$script:messageId;method='Fetch.fulfillRequest';params=$parameters}|ConvertTo-Json -Depth 8 -Compress
  $bytes = [Text.Encoding]::UTF8.GetBytes($payload)
  $socket.SendAsync([ArraySegment[byte]]::new($bytes),[Net.WebSockets.WebSocketMessageType]::Text,$true,[Threading.CancellationToken]::None).GetAwaiter().GetResult()|Out-Null
}
function Handle-Fetch($parameters) {
  $url = $parameters.request.url
  $script:interceptedRequests.Add($url)
  if ($url -match '/gtag/js') {
    if ($script:holdTag) { return }
    $body = $script:tagBody
    if ($RealTag) {
      $response = Invoke-WebRequest $url -UseBasicParsing -TimeoutSec 20
      $body = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($response.Content))
    }
    Reply-Fetch @{requestId=$parameters.requestId;responseCode=200;responseHeaders=@(@{name='Content-Type';value='application/javascript'});body=$body}
  } elseif ($RealTag -and $url -match '^https://www\.googletagmanager\.com/gtag/destination\?') {
    $response = Invoke-WebRequest $url -UseBasicParsing -TimeoutSec 20
    Reply-Fetch @{requestId=$parameters.requestId;responseCode=200;responseHeaders=@(@{name='Content-Type';value='application/javascript'});body=[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($response.Content))}
  } else {
    $payload = [Net.WebUtility]::UrlDecode($url + '&' + $parameters.request.postData)
    foreach ($match in [regex]::Matches($payload,'(?:[?&\r\n]|^)en=([^&\s]+)')) { $script:collectorEvents.Add($match.Groups[1].Value) }
    Reply-Fetch @{requestId=$parameters.requestId;responseCode=204;body=''}
  }
}
function Assert($condition,[string]$message) { if (!$condition) { throw $message } }
function Wait-Page {
  for ($i=0;$i -lt 30;$i++) {
    Start-Sleep -Milliseconds 100
    if (Evaluate "document.readyState==='complete' && !!document.querySelector('#analytics-consent')") { return }
  }
  throw 'Page load timeout'
}
function Settle { Evaluate 'new Promise(resolve=>setTimeout(resolve,250))'|Out-Null }
function Tag-Count { @($script:networkRequests|Where-Object {$_ -match '/gtag/js'}).Count }
function Google-Count { $script:networkRequests.Count }
function Open-Projects {
  foreach ($key in @('movimentacoes','smartworking','etl','indicadores','espaco')) {
    Evaluate "document.querySelector('[data-project=$key]').click();document.querySelector('[data-project=$key]').click();"|Out-Null
    Assert (Evaluate "document.querySelector('dialog').open") "Modal: $key"
    Evaluate "document.querySelector('dialog').close();"|Out-Null
    Start-Sleep -Milliseconds 60
  }
  Settle
}
$source = Get-Content -Raw -Encoding UTF8 (Join-Path $PSScriptRoot 'validate.ps1')
$helper = $source.Substring(0,([regex]::Match($source,'(?m)^try \{')).Index)
$helper = $helper.Replace('$projectRoot = Split-Path $PSScriptRoot -Parent', '$projectRoot = $auditProjectRoot')
$helper = [regex]::Replace($helper,'(?m)^\$profile = .*$',{ '$profile = Join-Path $projectRoot ''.local-preview/analytics''' })
$helper = [regex]::Replace($helper,'(?m)^\$outputDir = .*$',{ '$outputDir = Join-Path $projectRoot ''artifacts/analytics''' })
$marker = '    if ($message.method -eq ''Runtime.exceptionThrown'')'
$helper = $helper.Replace($marker,@'
    if ($message.method -eq 'Fetch.requestPaused') { Handle-Fetch $message.params }
    if ($message.method -eq 'Network.requestWillBeSent' -and $message.params.request.url -match 'https://[^/]*(googletagmanager\.com|google-analytics\.com|analytics\.google\.com|doubleclick\.net|googlesyndication\.com)/') { $script:networkRequests.Add($message.params.request.url) }
    if ($message.method -eq 'Runtime.exceptionThrown')
'@)
$report = @{transport='simulated; Google requests intercepted';viewports=@();passed=$false}
try {
  for ($i=0;$i -lt 20;$i++) { try { $ready=Invoke-WebRequest $baseUrl -UseBasicParsing -TimeoutSec 2;break } catch { Start-Sleep -Milliseconds 200 } }
  Assert ($ready.StatusCode -eq 200) 'HTTP server unavailable'
  . ([scriptblock]::Create($helper)) -Port $Port
  for ($i=0;$i -lt 30;$i++) { try { $targets=Invoke-RestMethod "http://localhost:$Port/json" -TimeoutSec 2;break } catch { Start-Sleep -Milliseconds 200 } }
  $target=$targets|Where-Object type -eq 'page'|Select-Object -First 1
  $socket.ConnectAsync([Uri]$target.webSocketDebuggerUrl,[Threading.CancellationToken]::None).GetAwaiter().GetResult()|Out-Null
  Send-CDP 'Page.enable'|Out-Null; Send-CDP 'Runtime.enable'|Out-Null; Send-CDP 'Network.enable'|Out-Null
  Send-CDP 'Fetch.enable' @{patterns=@(@{urlPattern='*googletagmanager.com/*'},@{urlPattern='*google-analytics.com/*'},@{urlPattern='*analytics.google.com/*'},@{urlPattern='*doubleclick.net/*'},@{urlPattern='*googlesyndication.com/*'})}|Out-Null
  if ($RealTag) { Send-CDP 'Fetch.enable' @{patterns=@(@{urlPattern='https://*'})}|Out-Null }
  foreach ($width in $(if ($RealTag) { @() } else { @(320,390,768,1024,1440,1920) })) {
    Send-CDP 'Page.navigate' @{url='about:blank'}|Out-Null
    Send-CDP 'Storage.clearDataForOrigin' @{origin="http://127.0.0.1:$HttpPort";storageTypes='all'}|Out-Null
    $script:networkRequests.Clear()
    Send-CDP 'Emulation.setDeviceMetricsOverride' @{width=$width;height=900;deviceScaleFactor=1;mobile=$false}|Out-Null
    Send-CDP 'Page.navigate' @{url=($baseUrl+'?email=visitor%40example.test#inicio')}|Out-Null; Wait-Page; Settle
    Assert ((Google-Count) -eq 0) "$width px: Google request before consent"
    Assert (Evaluate "!document.querySelector('#analytics-consent').hidden && !document.querySelector('#ga4-tag') && !window.dataLayer && document.documentElement.scrollWidth<=innerWidth") "$width px: first visit"
    Assert (Evaluate "[...document.querySelectorAll('[data-consent-choice]')].every(b=>!b.hasAttribute('aria-pressed')&&b.getBoundingClientRect().height>=44) && Math.abs(document.querySelector('[data-consent-choice=accepted]').offsetWidth-document.querySelector('[data-consent-choice=declined]').offsetWidth)<=1") "$width px: button balance"
    Screenshot "consent-$width"
    Open-Projects
    Assert ((Google-Count) -eq 0) "$width px: projects without consent"
    Evaluate "document.querySelector('[data-consent-choice=declined]').click();"|Out-Null
    Assert (Evaluate "localStorage.getItem('portfolio.analytics-consent.v1')==='declined' && document.querySelector('#analytics-consent').hidden") 'Decline persistence'
    Send-CDP 'Page.reload'|Out-Null; Wait-Page; Settle
    Assert ((Google-Count) -eq 0) "$width px: decline after reload"
    Evaluate "document.querySelector('[data-consent-review]').focus();"|Out-Null; Key 'Enter' 13
    Assert (Evaluate "document.activeElement.id==='analytics-consent'") 'Review focus'
    Key 'Tab' 9
    Assert (Evaluate "document.activeElement.hasAttribute('data-consent-close') && getComputedStyle(document.activeElement).outlineStyle==='solid'") 'Keyboard focus'
    Key 'Escape' 27
    Assert (Evaluate "document.querySelector('#analytics-consent').hidden && document.activeElement.hasAttribute('data-consent-review')") 'Escape and return focus'
    Evaluate "document.querySelector('[data-consent-review]').click();document.querySelector('[data-consent-choice=accepted]').click();document.querySelector('[data-consent-choice=accepted]').click();"|Out-Null; Settle
    Assert ((Tag-Count) -eq 1) "$width px: duplicate tag"
    Assert (Evaluate "localStorage.getItem('portfolio.analytics-consent.v1')==='accepted' && window.__analyticsTest.events.filter(e=>e.name==='page_view').length===1") "$width px: initial page_view"
    Open-Projects
    $events=(Evaluate "JSON.stringify(window.__analyticsTest.events)")|ConvertFrom-Json
    $projects=@($events|Where-Object name -eq 'project_view')
    Assert ($projects.Count -eq 5) "$width px: duplicate or missing project events"
    Assert (Evaluate "window.__analyticsTest.events.filter(e=>e.name==='project_view').every(e=>PROJECTS[e.parameters.project_id]?.title===e.parameters.project_name)") 'Project parameters'
    Evaluate @'
document.addEventListener('click',e=>{if(e.target.closest('a[data-contact]'))e.preventDefault()},true);
document.querySelectorAll('[data-contact]').forEach(e=>e.click());
document.querySelectorAll('nav a').forEach(e=>e.click());
'@|Out-Null; Settle
    Assert (Evaluate "window.__analyticsTest.events.filter(e=>e.name==='contact_click').length===4 && window.__analyticsTest.events.filter(e=>e.name==='contact_click').every(e=>['linkedin','email'].includes(e.parameters.contact_channel)) && window.__analyticsTest.events.filter(e=>e.name==='page_view').length===1") "$width px: contacts or page_view duplication"
    Assert (Evaluate "window.__analyticsTest.events.every(e=>!JSON.stringify(e.parameters).includes('visitor') && !JSON.stringify(e.parameters).includes('@') && !e.parameters.page_location.includes('?') && !e.parameters.page_location.includes('#'))") 'PII in parameters'
    Assert (Evaluate "window.__analyticsTest.commands.some(c=>c[0]==='config'&&c[2].send_page_view===false&&c[2].allow_google_signals===false&&c[2].allow_ad_personalization_signals===false&&c[2].cookie_path==='/Portf-lio/') && window.__analyticsTest.commands.filter(c=>c[0]==='consent').every(c=>!['ad_storage','ad_user_data','ad_personalization'].some(k=>c[2][k]==='granted'))") 'Advertising or configuration'
    Send-CDP 'Page.reload'|Out-Null; Wait-Page; Settle
    Assert ((Tag-Count) -eq 2 -and (Evaluate "window.__analyticsTest.events.filter(e=>e.name==='page_view').length===1 && document.querySelector('#analytics-consent').hidden")) "$width px: accepted reload"
    $beforeRevoke=Google-Count
    Evaluate "document.querySelector('[data-consent-review]').click();document.querySelector('[data-consent-choice=declined]').click();"|Out-Null; Wait-Page; Settle
    Assert (Evaluate "localStorage.getItem('portfolio.analytics-consent.v1')==='declined' && !document.querySelector('#ga4-tag') && !document.cookie.includes('portfolio_ga')") "$width px: revoke and cookies"
    Open-Projects
    Assert ((Google-Count) -eq $beforeRevoke) "$width px: requests after revoke"
    Evaluate "document.querySelector('[data-consent-review]').click();document.querySelector('[data-consent-choice=accepted]').click();"|Out-Null; Settle
    Assert ((Tag-Count) -eq 3) "$width px: reaccept"
    Send-CDP 'Page.navigate' @{url=($baseUrl+'privacidade.html')}|Out-Null; Wait-Page; Settle
    Assert (Evaluate "document.documentElement.scrollWidth<=innerWidth && document.querySelector('.privacy-document') && !!document.querySelector('[data-consent-review]') && window.__analyticsTest.events.filter(e=>e.name==='page_view').length===1") "$width px: privacy page"
    Screenshot "privacy-$width"
    Evaluate "document.querySelector('[data-consent-review]').click();document.querySelector('[data-consent-choice=declined]').click();"|Out-Null; Wait-Page; Settle
    $report.viewports+=@{width=$width;passed=$true;projectEvents=5;contactEvents=4;noRequestsBeforeConsent=$true;revocation=$true}
    Write-Output "Consent, events and privacy: $width px passed"
  }
  if ($RealTag) {
    Send-CDP 'Storage.clearDataForOrigin' @{origin="http://127.0.0.1:$HttpPort";storageTypes='all'}|Out-Null
    Send-CDP 'Page.navigate' @{url=$baseUrl}|Out-Null; Wait-Page; Settle
    Assert ((Google-Count) -eq 0) 'Real tag: request before consent'
    Evaluate "document.querySelector('[data-consent-choice=accepted]').click();"|Out-Null
    for ($attempt=0;$attempt -lt 20;$attempt++) {
      Evaluate 'new Promise(resolve=>setTimeout(resolve,500))'|Out-Null
      if ($script:collectorEvents -contains 'page_view') { break }
    }
    Assert ($script:collectorEvents -contains 'page_view') 'Real tag: no page_view collector request'
    Open-Projects
    Evaluate 'new Promise(resolve=>setTimeout(resolve,5000))'|Out-Null
    Assert (@($script:collectorEvents|Where-Object {$_ -eq 'project_view'}).Count -eq 5) ('Real tag: project event count; received: ' + ($script:collectorEvents -join ', '))
    $report.realTagCookieNames = (Evaluate "JSON.stringify(document.cookie.split(';').map(c=>c.split('=')[0].trim()).filter(Boolean))")|ConvertFrom-Json
    $beforeRevoke = Google-Count
    Evaluate "document.querySelector('[data-consent-review]').click();document.querySelector('[data-consent-choice=declined]').click();"|Out-Null; Wait-Page
    Evaluate 'new Promise(resolve=>setTimeout(resolve,1000))'|Out-Null
    Assert (Evaluate "!document.querySelector('#ga4-tag') && !document.cookie.includes('portfolio_ga')") 'Real tag: revoke/cookies'
    Assert ((Google-Count) -eq $beforeRevoke) 'Real tag: request after revoke'
    $report.transport = 'official Google tag executed; all collector requests intercepted'
    $report.realTagEvents = $script:collectorEvents
    $report.realTagRevocation = $true
    Write-Output 'Official tag, five project events and revocation: passed'
  }
  Send-CDP 'Storage.clearDataForOrigin' @{origin="http://127.0.0.1:$HttpPort";storageTypes='all'}|Out-Null
  Send-CDP 'Page.navigate' @{url=$baseUrl}|Out-Null; Wait-Page
  $script:holdTag=$true
  Evaluate "document.querySelector('[data-consent-choice=accepted]').click();"|Out-Null; Settle
  Evaluate "document.querySelector('[data-consent-review]').click();document.querySelector('[data-consent-choice=declined]').click();"|Out-Null; Wait-Page
  $script:holdTag=$false
  Assert (Evaluate "!document.querySelector('#ga4-tag') && !window.dataLayer") 'Revoke pending tag'
  $report.pendingTagRevocation=$true
  $override=Send-CDP 'Page.addScriptToEvaluateOnNewDocument' @{source="Storage.prototype.getItem=function(){throw new Error('blocked')};Storage.prototype.setItem=function(){throw new Error('blocked')};"}
  $beforeBlocked=Google-Count
  Send-CDP 'Page.reload'|Out-Null; Wait-Page; Settle
  Evaluate "document.querySelector('[data-consent-choice=declined]').click();"|Out-Null
  Assert (Evaluate "!document.querySelector('#ga4-tag') && !document.querySelector('#analytics-consent').hidden && document.querySelector('[data-consent-current]').textContent.includes('salvar')") 'Blocked storage'
  Assert ((Google-Count) -eq $beforeBlocked) 'Tracking inaccessible preference'
  Send-CDP 'Page.removeScriptToEvaluateOnNewDocument' @{identifier=$override.identifier}|Out-Null
  $report.blockedStorage=$true
  Assert ($script:browserErrors.Count -eq 0) 'JavaScript errors'
  $report.runtimeErrors=$script:browserErrors
  $report.passed=$true
} catch {
  $report.error=$_.Exception.Message
  throw
} finally {
  if ($outputDir) { $report|ConvertTo-Json -Depth 10|Set-Content -LiteralPath (Join-Path $outputDir 'validation.json') -Encoding UTF8 }
  if ($socket) { $socket.Dispose() }
  if ($browserProcess -and !$browserProcess.HasExited) { $browserProcess.Kill() }
  Stop-Job $server -ErrorAction SilentlyContinue; Remove-Job $server -Force -ErrorAction SilentlyContinue
}
