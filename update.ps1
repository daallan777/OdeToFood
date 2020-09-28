write-host "`n----------------------------"
write-host " Stop existing process, if any "
write-host "----------------------------`n"

$p = Get-Process -Name "dotnet"

if ($p) {

    $p | Stop-Process -Force

}

write-host "`n----------------------------"
write-host " Updating app"
write-host "----------------------------`n"

Set-Location -Path 'C:\Apps\OdeToFood\OdeToFood\OdeToFood\'


git pull


write-host "`n----------------------------"
write-host " npm packages installation  "
write-host "----------------------------`n"




npm install

write-host "`n----------------------------"
write-host " Building application "
write-host "----------------------------`n"

dotnet build


write-host "`n----------------------------"
write-host " Starting web application"
write-host "----------------------------`n"

$env:ASPNETCORE_URLS="http://*:80"

Start-Process -FilePath 'dotnet' -ArgumentList 'run --debug'

exit