JULIA=/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
FILES_N=3
let error_counter=0

echo $($JULIA "topLevel.jl" $FILES_N)
for ((i=1; i<=FILES_N; i++)); do
    echo $i
    $JULIA "--optimize=0" "./test_files/FILE_$i.txt" 2>/dev/null
    let o0_return=$?
    $JULIA "--optimize=1" "./test_files/FILE_$i.txt" 2>/dev/null
    let o1_return=$?
    $JULIA "--optimize=2" "./test_files/FILE_$i.txt" 2>/dev/null
    let o2_return=$?
    $JULIA "--optimize=3" "./test_files/FILE_$i.txt" 2>/dev/null
    let o3_return=$?
    if [ $o0_return != 0 ]
    then
        error_counter=$((error_counter+1))
    fi
    if [ $o0_return != $o1_return ]
    then
        echo "bug found in File $i o0 code different to o1"
        echo "code ($o0_return != $o1_return)"
    elif [ $o1_return != $o2_return ]
    then
        echo "bug found in File $i o1 code different to o2"
        echo "code ($o0_return != $o1_return)"
    elif [ $o2_return != $o3_return ]
    then
        echo "bug found in File $i o2 code different to o3"
        echo "code ($o0_return != $o1_return)"
    else
        echo "Passed"
    fi
    echo "----"
done
echo "done with $error_counter file(s) throwing errors"