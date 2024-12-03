[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\12\input1.txt"
#[string[]]$inputdata = Get-Content "C:\Users\Mihkel\OneDrive\AoC\2022\12\input2.txt"

$xlimit = $inputdata[0].ToCharArray().Count
$ylimit = $inputdata.Count

$map = New-Object 'char[,]' $xlimit,$ylimit

for ($y=0;$y -lt $inputdata.count;$y++){
    $line = $inputdata[$y].ToCharArray()
    for ($x=0;$x -lt $line.Count;$x++) {
        $map[$x,$y] = $line[$x]
        if ($line[$x] -ceq 'S') {
            $start = @{
                X=$x
                Y=$y
            }
        }
        if ($line[$x] -ceq 'E') {
            $end = @{
                X=$x
                Y=$y
            }
        }
    }
}
function draw {
    for ($y=0;$y -lt $ylimit;$y++){
        $(for ($x=0;$x -lt $xlimit;$x++) {
            $map[$x,$y]
        }) -join ''
    }
}

function distancetoend {
    param (
        $curX,
        $curY,
        $endX,
        $endY
    )

}
function testelevation {
    $curX,
    $curY,
    $endX,
    $endY
}
function selectdirection {

}

$currentpath = New-Object System.Collections.Stack

$currentpos = $start
draw
$start
$end

while ($true){
    #measure distance
    #select best direction where notinmoved
    #test direction
    #move
    #savestep
    #if nostep, backtrace

}