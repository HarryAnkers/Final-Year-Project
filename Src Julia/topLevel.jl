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

# function doStuff()
#     var1::Real = 0
#     var2::Float16 = pi
#     var3 = var1 + var2
#     println(typeof(promote(var1,var2)))
#     println(typeof(var3))
#     println(var3)
# end

# doStuff()