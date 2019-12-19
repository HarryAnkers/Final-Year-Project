include("./AST/include.jl")

# ROOT
open("./test_files/test0.txt", "w") do f
    state = State(f)
    top_node = Statement_Lists(state)
    init(top_node)
    # create_text(top_node)
    # close(top_node.state.file)
end