include("./AST/include.jl")

files_n = parse(UInt8, ARGS[1])

for i in 1:files_n
    open(string("./test_files/FILE_",i,".txt"), "w") do f
        state = State(f)
        top_node = Statement_Lists(state)
        init(top_node)
        create_text(top_node)
        close(top_node.state.file)
    end
end

println("FInished")