# INIT STATE TYPE
mutable struct State
    file::IOStream
    indent_level::Int
    variables::Array{String}
    scopeRecursion::Int
    State(file) = new(file,0,[],0)
end

function write_pretty(indent::Int, in_state::State, in_string::String)
    for i = 1:indent
        write(in_state.file, "\t")
    end
    write(in_state.file, in_string)
end