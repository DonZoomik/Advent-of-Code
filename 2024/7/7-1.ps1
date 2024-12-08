#$data = gc "C:\aoc\Advent-of-Code\2024\7\test.txt"
$data = gc "C:\aoc\Advent-of-Code\2024\7\data.txt"

$sums = $data|sort {($_.split(' ')).count} -Descending|ForEach-Object -ThrottleLimit 8 -Parallel  {

    function reccalc {
        param (
            $digits,
            $sum
        )
        #write-host "$($digits.count) $sum"
        [int64]$sum1 = $digits[0] * $digits[1]
        #write-host "$($digits[0]) $($digits[1]) $sum1"
        [int64]$sum2 = $digits[0] + $digits[1]
        #write-host "$($digits[0]) $($digits[1]) $sum2"
        [int64]$sum3 = $digits[0],$digits[1] -join ''
        #write-host "$($digits[0]) $($digits[1]) $sum3"
        #pause
        if (($sum1 -eq $sum -or $sum2 -eq $sum -or $sum3 -eq $sum) -and $digits.Count -eq 2) {
            return $true
        } elseif ($digits.Count -ge 3) {
            $newdigits1 = $sum1,$digits[2..($digits.Length-1)]|%{$_}
            $newdigits2 = $sum2,$digits[2..($digits.Length-1)]|%{$_}
            $newdigits3 = $sum3,$digits[2..($digits.Length-1)]|%{$_}
            $res1 = reccalc $newdigits1 $sum
            $res2 = reccalc $newdigits2 $sum
            $res3 = reccalc $newdigits3 $sum
            if ($res1 -or $res2 -or $res3) {return $true} else {return $false}
        } else {
            return $false 
        }
    }


    $row = $_
    write-host "$(get-date) $row"
    $split = $row.split(':')
    $sum = $split[0]
    [int64[]]$digits = $split[1].trim().split(' ')
    if (reccalc -digits $digits -sum $sum) {
        $sum
    }
}
$sums|measure -sum