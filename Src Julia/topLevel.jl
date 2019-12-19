include("./State_struct.jl")
# include("./AST/Statements/statement_Lists.jl")


# ROOT
open("./test_files/test0.txt", "w") do f
    state = State(f,0,[])
    top_node = Statement_Lists(state,nothing,nothing)   
    init(top_node)
    create_text(top_node)
    close(top_node.state.file)
end