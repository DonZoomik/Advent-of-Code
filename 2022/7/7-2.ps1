[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\7\input.txt"
#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\7\inputsample.txt"
$currentpath = New-Object System.Collections.Generic.Stack[String]
$filelist = @()

#$diractive=$false
[string[]]$folderlist = @()
$filelist  = foreach ($line in $inputdata) {
    $tokens = $line.trim('$').trim() -split ' ' 
    write-host $line
    switch ($tokens[0]) {
        {$tokens[0] -eq "cd"} {
            Write-Host ('cd', $tokens[0], $tokens[1] ,$currentpath.Peek())
            #if ($diractive){$currentpath.Pop();$diractive=$false}
            switch ($tokens[1]) {
                {$tokens[1] -eq "/"}{
                    $currentpath.push('/')
                    $folderlist += $currentpath.Peek()
                }
                {$tokens[1] -eq ".."}{
                    $currentpath.pop()
                    $folderlist += $currentpath.Peek()
                }
                default {
                    $currentpath.push(($currentpath.Peek(), $tokens[1] -join '/'))
                    $folderlist += $currentpath.Peek()
                }
            }
            #pause
        }
        {$tokens[0] -eq "ls"} {}
        {$tokens[0] -eq "dir"} {
            $folderlist += ($currentpath.Peek(), $tokens[1] -join '/')
        }
        default {
            Write-Host ('file', $tokens[0], $tokens[1] ,$currentpath.Peek())
            [PSCustomObject]@{
                path = $currentpath.peek()
                size = [int]$tokens[0]
                name = $tokens[1]
            }
            #pause
        }

    }
}
$allmatches= foreach ($fol in $folderlist|select -unique){
    $matches = $filelist|Where-Object {$_.path -match "^$fol"}
    [PSCustomObject]@{
        motherpath = $fol
        matches = $matches
    }
}


$allsums= foreach ($allmatch in $allmatches){
    [PSCustomObject]@{
        motherpath = $allmatch.motherpath
        size = ($allmatch.matches.size|measure -sum).sum
    }
}
$usedspace = ($filelist|measure -sum size).sum
$freespace = 70000000 - $usedspace
$neededspace = 30000000 - $freespace

$allsums|sort size|? size -ge $neededspace