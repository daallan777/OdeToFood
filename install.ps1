write-host "`n----------------------------"
write-host " Stop existing process, if any - Ignore any exceptions if process is not running "
write-host "----------------------------`n"

$p = Get-Process -Name "dotnet"

if ($p) {
  # try gracefully first
  $p.CloseMainWindow()
  # kill after five seconds
  Sleep 5
  if (!$p.HasExited) {
    $p | Stop-Process -Force
  }
}

Set-Location -Path 'C:\Apps\OdeToFood\OdeToFood\OdeToFood\'

write-host "`n----------------------------"
write-host " npm packages installation  "
write-host "----------------------------`n"

npm install

write-host "`n----------------------------"
write-host " Building application "
write-host "----------------------------`n"

dotnet build

$env:ASPNETCORE_URLS="http://*:80"

Start-Process -FilePath 'dotnet' -ArgumentList 'run --debug'

exit