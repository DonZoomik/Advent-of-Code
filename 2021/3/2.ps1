[string[]]$data = gc C:\aoc\2021\3\input.txt
$size=$data[0].ToCharArray().Count

function getrows {
    param (
        $data,
        $criteria,
        [int]$pos
    )
    write-host ('enter', $data.Length, $criteria, $pos )
    [string[]]$c0 = @()
    [string[]]$c1 = @()
    foreach ($row in $data) {
        #write-host ('row', $row)
        [char[]]$chararray = $row.ToCharArray()
        if ($chararray[$pos] -eq '0') {
            $c0 += $row
            #write-host ('pos', $row, $pos, $chararray[$pos], '0', $c0.length )
        } else {
            $c1 += $row
            #write-host ('pos', $row, $pos, $chararray[$pos], '1', $c1.length)
        }
    }
    #write-host ('c1', $c0)
    #write-host ('c2', $c1)
    write-host ('cl', $c0.Length, $c1.Length )
    switch ($criteria) {
        'most' {
            if($c0.Length -gt $c1.Length) {
                $newdata = $c0
            } elseif ($c0.Length -eq $c1.Length) {
                write-host ($c0, $c1, $pos)
                $newdata = $c1
            } else {
                $newdata = $c1
            }
        }
        'least' {
            if($c0.Length -gt $c1.Length) {
                $newdata = $c1
            } elseif ($c0.Length -eq $c1.Length) {
                write-host ($c0, $c1, $pos)
                $newdata = $c0
            } else {
                $newdata = $c0
            }

        }
    }
    if ($newdata.Count -gt 1) {
        getrows $newdata $criteria ($pos+1)    
    } else {
        return $newdata
    }

}

$o2 = getrows $data 'most' '0'
$co2 = getrows $data 'least' '0'
$o2, $co2
[convert]::ToInt32($o2,2)* [convert]::ToInt32($co2,2)