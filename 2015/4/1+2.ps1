$input = 'yzbqklnj'
[Reflection.Assembly]::LoadWithPartialName("System.Web")

$i=0
while ($true) {
    $test = $input + $i
    $hash = [System.Web.Security.FormsAuthentication]::HashPasswordForStoringInConfigFile($test, "MD5")
    if ($hash -match '^000000') {
        ($test, $hash, $i)
        pause
    }
    $i++ 
}
