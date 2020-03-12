JULIA=/Applications/Julia-1.3.app/Contents/Resources/julia/bin/julia
# Declares how many processes are wanted
let pro_N=$1
# Counters for files that threw an exception and those that exposed bugs
# let error_counter=0
# let bug_counter=0

# Removes all old test files
if [[ ! -d "./test_files/Process_$pro_N" ]]
then
    mkdir "./test_files/Process_$pro_N"
    mkdir "./test_files/Process_$pro_N/log_files"
    mkdir "./test_files/Process_$pro_N/bug_files"
    mkdir "./test_files/Process_$pro_N/error_files" 
fi

echo "process $i started"
while :
do
    let bug=1
    let error=0

    rm -rfv ./test_files/log_files/*.txt 2>/dev/null

    # Creates the files
    $JULIA "topLevel.jl" "./test_files/Process_$pro_N/"
    # Ran at each opt. level results are stored in variables e.g. o0_return
    $JULIA "--optimize=0" "./test_files/Process_$pro_N/File.jl" 0 2>/dev/null
    let o0_return=$?
    $JULIA "--optimize=1" "./test_files/Process_$pro_N/FILE.jl" 1 2>/dev/null
    let o1_return=$?
    $JULIA "--optimize=2" "./test_files/Process_$pro_N/FILE.jl" 2 2>/dev/null
    let o2_return=$?
    $JULIA "--optimize=3" "./test_files/Process_$pro_N/FILE.jl" 3 2>/dev/null
    let o3_return=$?

    # Checks if file threw an error and if it did inc. the count
    if [ $o0_return -ne 0 ]; then
        error=1
    fi
    # All checks to see if opt. returned different things.
    # If they did inc. count and moves the file
    if [ $o0_return -ne $o1_return ]; then
        echo "error diff in File $i o0 / o1 ($o0_return-$o1_return)"
    elif [ $o1_return -ne $o2_return ]; then
        echo "error diff in File $i o1 / o2 ($o1_return-$o2_return)"
    elif [ $o2_return -ne $o3_return ]; then
        echo "error diff in File $i o2 / o3 ($o2_return-$o3_return)"
    elif [ $o0_return -eq 0 ]; then
        if ! cmp -s ./test_files/Process_$pro_N/log_files/log0.txt ./test_files/Process_$pro_N/log_files/log1.txt; then
            echo "log diff in File $i o0 / o1"
        elif ! cmp -s ./test_files/Process_$pro_N/log_files/log1.txt ./test_files/Process_$pro_N/log_files/log2.txt; then
            echo "log diff in File $i o1 / o2"
        elif ! cmp -s ./test_files/Process_$pro_N/log_files/log2.txt ./test_files/Process_$pro_N/log_files/log3.txt; then
            echo "log diff in File $i o2 / o3"
        else
            bug=0
        fi
    else
        bug=0
    fi
    
    if [ $bug -eq 1 ]; then
        echo "Bug found!"
        cp ./test_files/Process_$pro_N/FILE.jl ./test_files/bug_files/$date
    elif [ $error -eq 1 ]; then
        cp ./test_files/Process_$pro_N/FILE.jl ./test_files/error_files/$date
    fi
done