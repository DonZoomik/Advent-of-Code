$data = (gc C:\aoc\2021\12\input.txt)

$pathpairs = @()
foreach ($pair in $data){
    $tokens = $pair -split '-'
    #write-host ('tokens', $tokens[0], $tokens[1])
    $forward= [pscustomobject]@{
        src=$tokens[0]
        tgt=$tokens[1]
    }
    if ($tokens[1] -ne 'start' -and $tokens[0] -ne 'end') {
        $pathpairs += $forward
    }
    if ($tokens[0] -ne 'start' -and $tokens[1] -ne 'end') {
        $reverse= [pscustomobject]@{
            src=$tokens[1]
            tgt=$tokens[0]
        }
        $pathpairs += $reverse
    }
}
$global:stopwatch =  [system.diagnostics.stopwatch]::StartNew()

$global:completepathscount=0

function resolvepath {
    param(
        $currentpath
    )
    #write-host ('enter', ($currentpath -join '-'), 'last', $currentpath[-1])
    #$pathpairs.GetEnumerator() | ? {$_.src -eq $currentpath[-1]}|write-host
    $possiblenextnodes = $pathpairs.GetEnumerator() | ? {$_.src -eq $currentpath[-1]}
    #$possiblenextnodes|%{$_ -join '>'|write-host}
    if ($currentpath|group|?{$_.name -cmatch “^[a-z]*$” -and $_.name -ne 'start' -and $_.count -eq 2}){
        $chance2rdy=$false
    } else {$chance2rdy=$true}
    #$chance2rdy
    #pause
    foreach ($possiblenextnode in $possiblenextnodes) {
        switch ($possiblenextnode.tgt) {
            'end' {
                #write-host ('end')
                $global:completepathscount++
                if ($global:stopwatch.elapsedmilliseconds -gt 10000){
                    write-host $global:completepathscount
                    $global:stopwatch =  [system.diagnostics.stopwatch]::StartNew()
                }
            }
            {($_ -cmatch “^[A-Z]*$”) -or ($_ -notin $currentpath -and $_ -cmatch “^[a-z]*$”) -or ($_ -cmatch “^[a-z]*$” -and $chance2rdy)} {
                #write-host ('newnode',$_)
                resolvepath (@($currentpath) + @($_))
            }
            default {
                #write-host ('error',$_,($currentpath -join '-'), 'last', $currentpath[-1])
                #pause
            }

        }
    }
}


$currentpath = @('start')
resolvepath $currentpath

#write-host 'completepaths'
#$completepaths|%{$_ -join '-'|write-host}
#global:completepaths.Count

$global:completepathscount