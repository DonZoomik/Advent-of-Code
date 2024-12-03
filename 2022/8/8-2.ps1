#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\8\inputsample.txt"
[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\8\input.txt"

$visible = @()
for ($y=1;$y -lt ($inputdata.Count -1);$y++){
    $trees = [int[]][string[]][char[]]$inputdata[$y]
    for ($x=1;$x -lt ($trees.Count -1);$x++) {
        $treesy = foreach ($line in $inputdata) {
            [int[]][string[]][char[]]$line[$x]
        }

        $lookleft = $lookright = $lookup = $lookdown = 0
        $highest = $trees[$x]
 
        foreach ($xcomp in (($x -1)..0)) {
            if ($trees[$xcomp] -lt $highest) {
                $lookleft++
            } else {
                $lookleft++
                break
            } 
        }

        foreach ($xcomp in (($x+1)..($trees.Count -1))) {
            if ($trees[$xcomp] -lt $highest) {
                $lookright++
            } else {
                $lookright++
                break
            } 
        }

        $highest = $treesy[$y]

        foreach ($ycomp in ($y-1)..0) {
            if ($treesy[$ycomp] -lt $highest) {
                $lookup++
            } else {
                $lookup++
                break
            } 
        }
        
        foreach ($ycomp in ($y+1)..($inputdata.Count -1)) {
            if ($treesy[$ycomp] -lt $highest) {
                $lookdown++
            } else {
                $lookdown++
                break
            }
        }

        $scenic = $lookleft * $lookright * $lookup * $lookdown
        $visible += $scenic
    }
}
($visible|sort -desc)[0]