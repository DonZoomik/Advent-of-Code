[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\6\input.txt"

foreach ($line in $inputdata) {
    $chars = $line.ToCharArray()
    $notfound = $true
    $i=3
    while($notfound){
        $selectedchars = $chars[($i-3)..$i]
        if (($selectedchars|select -unique|measure).count -eq 4) {
            $i+1
            $selectedchars -join ''|write-host
            $notfound=$false
        }
        $i++
    }
}


[char[]]$line = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\6\input.txt"
for ($i=3;$i -lt $line.count;$i++){
    if (($line[($i-3)..$i]|select -unique|measure).count -eq 4) {
        $i+1
        exit
    }
}