# INIT STATE TYPE
mutable struct State
    file::IOStream
    indent_level::Int
    variables::Array{String}
    scopeRecursion::Int
    State(file) = new(file,0,[],0)
end