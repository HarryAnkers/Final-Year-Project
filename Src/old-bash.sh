JULIA=/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
# Declares how many files are wanted
FILES_N=1000
# Counters for files that threw an exception and those that exposed bugs
let error_counter=0
let bug_counter=0

# Removes all old test files
rm -rfv ./test_files/*.jl 2>/dev/null

# Creates the files
$JULIA "topLevel.jl" $FILES_N
echo "Created Files"
echo "=================="
# Loop to test the files
for ((i=1; i<=FILES_N; i++)); do
    echo "---- Testing file $i ----"
    # Ran at each opt. level results are stored in variables e.g. o0_return
    $JULIA "--optimize=0" "./test_files/FILE_$i.jl" 0
    let o0_return=$?
    $JULIA "--optimize=1" "./test_files/FILE_$i.jl" 1 2>/dev/null
    let o1_return=$?
    $JULIA "--optimize=2" "./test_files/FILE_$i.jl" 2 2>/dev/null
    let o2_return=$?
    $JULIA "--optimize=3" "./test_files/FILE_$i.jl" 3 2>/dev/null
    let o3_return=$?

    let error=1

    # Checks if file threw an error and if it did inc. the count
    if [ $o0_return != 0 ]; then
        error_counter=$((error_counter+1))
    fi
    # All checks to see if opt. returned different things.
    # If they did inc. count and moves the file
    if [ $o0_return -ne $o1_return ]; then
        bug_counter=$((bug_counter+1))
        echo "error diff in File $i o0 / o1 ($o0_return-$o1_return)"
    elif [ $o1_return -ne $o2_return ]; then
        bug_counter=$((bug_counter+1))
        echo "error diff in File $i o1 / o2 ($o1_return-$o2_return)"
    elif [ $o2_return -ne $o3_return ]; then
        bug_counter=$((bug_counter+1))
        echo "error diff in File $i o2 / o3 ($o2_return-$o3_return)"
    elif [ $o0_return -eq 0 ]; then
        if ! cmp -s ./test_files/log_files/log0.txt ./test_files/log_files/log1.txt; then
            bug_counter=$((bug_counter+1))
            echo "log diff in File $i o0 / o1"
        elif ! cmp -s ./test_files/log_files/log1.txt ./test_files/log_files/log2.txt; then
            bug_counter=$((bug_counter+1))
            echo "log diff in File $i o1 / o2"
        elif ! cmp -s ./test_files/log_files/log2.txt ./test_files/log_files/log3.txt; then
            bug_counter=$((bug_counter+1))
            echo "log diff in File $i o2 / o3"
        else
            error=0
        fi
    else
        error=0
        echo "Passed"
    fi
    
    if [ error == 1 ]; then
        mv ./test_files/FILE_$i.jl ./test_files/bug_files/ 
    fi
done
echo "================"
echo "done with $error_counter file(s) throwing errors"
echo "$bug_counter bug(s) found"