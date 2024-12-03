[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\6\input.txt"

foreach ($line in $inputdata) {
    $chars = $line.ToCharArray()
    $notfound = $true
    $i=13
    while($notfound){
        $selectedchars = $chars[($i-13)..$i]
        if (($selectedchars|select -unique|measure).count -eq 14) {
            $i+1
            $selectedchars -join ''|write-host
            $notfound=$false
        }
        $i++
    }
}
