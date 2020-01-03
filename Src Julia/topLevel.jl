include("./AST/include.jl")

files_n = parse(UInt8, ARGS[1])
println(string("n = ", files_n))

for i in 1:files_n
    println(string("creating file - ", i))
    open(string("./test_files/FILE_",i,".jl"), "w") do f
        state = State(f)
        top_node = Statement_Lists(state)
        init(top_node)
        create_text(top_node)
        close(top_node.state.file)
    end
end

# function doStuff()
#     a=27
#     b= ((-20483)%(-2094415585159035624618931257345301237))
#     println(b)
#     d = (+((163)%(-23564)))
#     println(d)
#     c = (d\(false))
#     println(c)
#     v= ((b⊻((+((163)%(-23564)))\(false)))/27)
# end

# doStuff()
