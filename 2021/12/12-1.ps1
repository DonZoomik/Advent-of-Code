$data = (gc C:\aoc\2021\12\input.txt)

$pathpairs = @()
foreach ($pair in $data){
    $tokens = $pair -split '-'
    #write-host ('tokens', $tokens[0], $tokens[1])
    $forward= [pscustomobject]@{
        src=$tokens[0]
        tgt=$tokens[1]
    }
    $pathpairs += $forward
    if ($tokens[0] -ne 'start' -and $tokens[1] -ne 'end') {
        $reverse= [pscustomobject]@{
            src=$tokens[1]
            tgt=$tokens[0]
        }
        $pathpairs += $reverse
    }
}

#$pathpairs|%{$_ -join ' '|write-host}


#$pathpairs[3]

$global:completepaths = @()

function resolvepath {
    param(
        $currentpath
    )
    #write-host ('enter', ($currentpath -join '-'), 'last', $currentpath[-1])
    #$pathpairs.GetEnumerator() | ? {$_.src -eq $currentpath[-1]}|write-host
    $possiblenextnodes = $pathpairs.GetEnumerator() | ? {$_.src -eq $currentpath[-1]}
    #$possiblenextnodes|%{$_ -join '>'|write-host}
    $nextpaths=@()
    foreach ($possiblenextnode in $possiblenextnodes) {
        if ($possiblenextnode.tgt -cmatch “^[A-Z]*$” -or ($possiblenextnode.tgt -notin $currentpath -and $possiblenextnode.tgt -cmatch “^[a-z]*$”)) {
            #write-host ('foundnext', ($possiblenextnode -join '-'))   
            $nextpaths+=$possiblenextnode.tgt
        }
    }
    #write-host ('nextpaths', $nextpaths)
    #pause
    if ($nextpaths) {
        foreach ($nextpath in $nextpaths) {
            #write-host ('path', $nextpath)
            if ($nextpath -eq 'end') {
                #write-host ('endpath', $nextpath)
                $finalpath=$currentpath
                $finalpath+='end'
                #write-host ('end', ($finalpath -join '-'))
                $global:completepaths+=@(,$finalpath)
                remove-variable finalpath
            } else {
                #write-host ('continuepath', $nextpath)
                $finalpath=$currentpath
                $finalpath+=$nextpath
                #write-host ('calling', ($finalpath -join '-'))
                resolvepath $finalpath
                remove-variable finalpath
            }
        }
    } else {
        #write-host ('nomorepaths', ($currentpath -join '-'))
    }
}


$currentpath = @('start')
resolvepath $currentpath

#write-host 'completepaths'
#$completepaths|%{$_ -join '-'|write-host}
$global:completepaths.Count