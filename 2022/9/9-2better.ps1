#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\9\inputsample.txt"
#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\9\inputsample2.txt"
[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\9\input.txt"

$numobjects=10
$innerlooplimit=$numobjects-1

$allpositions = @()
for ($i = 0; $i -lt $numobjects; $i++) { 
    $allpositions += @{
        X=[int]0
        Y=[int]0
    }
}

$tailpositions = foreach ($line in $inputdata) {
    $tokens = $line -split ' '
    [string]$direction = $tokens[0]
    [int]$distance = $tokens[1]
    for ($i=0;$i -lt $distance;$i++) {
        switch ($direction) {
            'U' {$allpositions[0]['Y']++}
            'D' {$allpositions[0]['Y']--}
            'R' {$allpositions[0]['X']++}
            'L' {$allpositions[0]['X']--}
        }
        for ($head=0;$head -lt $innerlooplimit;$head++) {
            $tail = $head+1
            $distanceX = $allpositions[$head]['X'] - $allpositions[$tail]['X']
            $distanceY = $allpositions[$head]['Y'] - $allpositions[$tail]['Y']
            $movec=-1
            switch ($distanceX) {
                -2 {
                    $movec++
                    $allpositions[$tail]['X']--
                    switch ($distanceY) {
                        {$_ -le -1} {$allpositions[$tail]['Y']--}
                        {$_ -ge 1} {$allpositions[$tail]['Y']++}
                    }
                }
                2 {
                    $movec++
                    $allpositions[$tail]['X']++
                    switch ($distanceY) {
                        {$_ -le -1} {$allpositions[$tail]['Y']--}
                        {$_ -ge 1} {$allpositions[$tail]['Y']++}
                    }
                }
            }
            if ($movec) {
                switch ($distanceY) {
                    -2 {
                        $allpositions[$tail]['Y']--
                        switch ($distanceX) {
                            {$_ -le -1} {$allpositions[$tail]['X']--}
                            {$_ -ge 1} {$allpositions[$tail]['X']++}
                        }
                    }
                    2 {
                        $allpositions[$tail]['Y']++
                        switch ($distanceX) {
                            {$_ -le -1} {$allpositions[$tail]['X']--}
                            {$_ -ge 1} {$allpositions[$tail]['X']++}
                        }
                    }
                }
            }
        }
        $allpositions[-1]['X'],$allpositions[-1]['Y'] -join ','
    }
}
$tailpositions += '0,0'
$tailpositions|select -unique|measure