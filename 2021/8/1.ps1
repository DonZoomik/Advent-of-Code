$data = (gc C:\aoc\2021\8\input.txt)
$uniquenums=@(2,3,4,7)
$uniquenumcount=0
foreach ($line in $data) {
    $tokens = $line.Split('|')
    $output = $tokens[1].trim().split(' ')
    foreach ($outputtoken in $output) {
        if ($outputtoken.tochararray().count -in $uniquenums){
            $uniquenumcount++
            #write-host ($outputtoken, $outputtoken.tochararray().count)
        }
    }
}
$uniquenumcount