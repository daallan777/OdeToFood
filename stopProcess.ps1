write-host "`n----------------------------"
write-host " Stop existing process, if any "
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