include("./AST/include.jl")

# ROOT
for i in 1:10
    open(string("./test_files/test",i,".txt"), "w") do f
        state = State(f)
        top_node = Statement_Lists(state)
        init(top_node)
        create_text(top_node)
        close(top_node.state.file)
    end
end