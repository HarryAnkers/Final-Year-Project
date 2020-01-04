# Includes the full tree
include("./AST/include.jl")

files_n = parse(UInt8, ARGS[1])
println(string("n = ", files_n))

# Creates files in a loop
for i in 1:files_n
    println(string("creating file - ", i))
    # Creates or overwrites existing file
    open(string("./test_files/FILE_",i,".jl"), "w") do f
        state = State(f)
        # Creates the whole tree
        top_node = Statement_Lists(state)
        # Init. all nodes
        init(top_node)
        # Creates text to be put in the file stream
        create_text(top_node)
        # Close file
        close(top_node.state.file)
    end
end
