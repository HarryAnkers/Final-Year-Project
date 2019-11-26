include("./State_struct.jl")
include("./AST/statement_Lists.jl")

# ROOT
open("./test_files/test0.txt", "w") do f
    state = State(f,0,[])
    top_node = statement_Lists(state)
    top_node.create_text
    # write(state.file,"bbbbb")
end