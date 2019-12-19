# INIT STATE TYPE
mutable struct State
    file::IOStream
    indent_level::Int
    variables::Array{String}
    scopeRecursion::Int
end