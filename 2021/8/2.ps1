$data = (gc C:\aoc\2021\8\input.txt)
$uniquenums=@(2,3,4,7)
$totalsum = @()
foreach ($line in $data) {
    $tokens = $line.Split('|')
    $input = $tokens[0].trim().split(' ')
    $output = $tokens[1].trim().split(' ')
    $alltokens = $input + $output

    $tokenmapping = @{
        a = $nul
        b = $nul
        c = $nul
        d = $nul
        e = $nul
        f = $nul
        g = $nul
    }
    $decodednums = @{
        0 = $nul
        1 = $nul
        2 = $nul
        3 = $nul
        4 = $nul
        5 = $nul
        6 = $nul
        7 = $nul
        8 = 'abcdefg'
        9 = $nul
    }
    foreach ($outputtoken in $alltokens| sort {$_.length}|select -Unique) {
        if ($outputtoken.tochararray().count -in $uniquenums){
            switch ($outputtoken.tochararray().count) {
                #1
                2 {
                    $chars=$outputtoken.tochararray()|sort
                    $tokenmapping.c = $chars[0]
                    $tokenmapping.f = $chars[1]
                    $decodednums.1 = $chars[0..$chars.Count] -join ''
                    #$tokenmapping
                    #write-host ' '
                }
                #7
                3 {
                    $chars=$outputtoken.tochararray()|sort
                    $newchars=$chars|sort|?{$_ -notin $tokenmapping.Values}
                    $tokenmapping.a = $newchars[0]
                    $decodednums.7 = $chars[0..$chars.Count] -join ''
                    #$tokenmapping
                    #write-host ' '
                }
                #4
                4 {
                    $chars=$outputtoken.tochararray()|sort
                    $newchars=$chars|sort|?{$_ -notin $tokenmapping.Values}
                    $tokenmapping.b = $newchars[0]
                    $tokenmapping.d = $newchars[1]
                    $decodednums.4 = $chars[0..$chars.Count] -join ''
                    #$tokenmapping
                    #write-host ' '
                }

            }
        }
    }
    #9
    $attemptedtokens = $alltokens| ? {$_.length -eq 6}|%{($_.tochararray()|sort) -join ''}|select -Unique
    foreach ($attemptedtoken in $attemptedtokens) {
        $unknowntokens=@()
        foreach ($char in $attemptedtoken.tochararray()){
            #write-host ($char, $attemptedtoken, ($tokenmapping.values -join ''))
            if ($char -notin $tokenmapping.values){
                #$char
                $unknowntokens+=$char
            }
        }
        #write-host ($attemptedtoken, ($unknowntokens -join ''),$unknowntokens.length)
        if ($unknowntokens.length -eq 1) {
            $tokenmapping.g=$unknowntokens -join ''
            $decodednums.9=$attemptedtoken
            break
        }
    }
    #6
    $attemptedtokens = $alltokens| ? {$_.length -eq 6}|%{($_.tochararray()|sort) -join ''}|select -Unique|? {$_ -notin $decodednums.values}
    #write-host ($attemptedtokens -join ' ')
    foreach ($attemptedtoken in $attemptedtokens) {
        $unknowntokens=@()
        $knowntokens=@()
        foreach ($char in $attemptedtoken.tochararray()){
            if ($char -notin $tokenmapping.values){
                $unknowntokens+=$char
            } else {
                $knowntokens+=$char
            }
        }
        #write-host ($unknowntokens -join '', $knowntokens -join '')
        if ($tokenmapping.c -in $knowntokens -and $tokenmapping.f -in $knowntokens) {
            #0
            #write-host ($char, $attemptedtoken, ($tokenmapping.values -join ''))
            $tokenmapping.e = $unknowntokens -join ''
            if ($tokenmapping.d -in $knowntokens){
                #reverse
                $temp=$tokenmapping.d
                $tokenmapping.d=$tokenmapping.b
                $tokenmapping.b=$temp
            }
            $decodednums.0=$attemptedtoken#>
        }
        if ($tokenmapping.b -in $knowntokens -and $tokenmapping.d -in $knowntokens) {
            if ($tokenmapping.c -in $knowntokens){
                #reverse
                $temp=$tokenmapping.c
                $tokenmapping.c=$tokenmapping.f
                $tokenmapping.f=$temp
            }            
            $decodednums.6=$attemptedtoken
        }#>
    }#>
    $decodednums.5 = ($tokenmapping.a,$tokenmapping.b,$tokenmapping.d,$tokenmapping.f,$tokenmapping.g|sort) -join ''
    $decodednums.3 = ($tokenmapping.a,$tokenmapping.c,$tokenmapping.d,$tokenmapping.f,$tokenmapping.g|sort) -join ''
    $decodednums.2 = ($tokenmapping.a,$tokenmapping.c,$tokenmapping.d,$tokenmapping.e,$tokenmapping.g|sort) -join ''
    <#write-host 'tokenmapping'
    $tokenmapping
    write-host 'decodenum'
    $decodednums
    write-host 'checknum'
    @{
    8= ('acedgfb'.ToCharArray()|sort) -join ''
    5= ('cdfbe'.ToCharArray()|sort) -join ''
    2= ('gcdfa'.ToCharArray()|sort) -join ''
    3= ('fbcad'.ToCharArray()|sort) -join ''
    7= ('dab'.ToCharArray()|sort) -join ''
    9= ('cefabd'.ToCharArray()|sort) -join ''
    6= ('cdfgeb'.ToCharArray()|sort) -join ''
    4= ('eafb'.ToCharArray()|sort) -join ''
    0= ('cagedb'.ToCharArray()|sort) -join ''
    1= ('ab'.ToCharArray()|sort) -join ''#>

    $outputnum=''
    $output|%{
        $outputitem = $_
        $outputitemsort = ($outputitem.tochararray()|sort) -join ''
        $outputnum += ($decodednums.GetEnumerator()|? {$_.value -eq $outputitemsort}).name
    }
    $outputnum
    $totalsum+=$outputnum
}

#$alltokens| ? {$_.length -eq 6}|%{($_.tochararray()|sort) -join ''}
$totalsum -join ','
$totalsum|measure -sum