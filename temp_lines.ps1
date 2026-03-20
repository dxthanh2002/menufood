$lines=Get-Content 'test\widget_test.dart'
for($i=1;$i -le 40;$i++){
  Write-Host ('{0}: {1}' -f $i, $lines[$i-1])
}
