# INIT STATE TYPE
mutable struct State
    file::IOStream
    variables::Dict{Int, Array{Tuple{String,String}}}
    scope::Int
    State(file) = new(file,Dict{Int, Array{Tuple{String,String}}}(),0)
end

function write_pretty(indent::Int, in_state::State, in_string::String)
    for i = 1:indent
        write(in_state.file, "\t")
    end
    write(in_state.file, in_string)
end

function var_dict_size(state_in::State)
    var_size = 0
    for key in keys(state_in.variables)
        var_size += size(state_in.variables[key])[1]
    end
    return var_size
end

function get_var(state_in::State, i::Int)
    for key in keys(state_in.variables)
        if i <= size(state_in.variables[key])[1]
            return state_in.variables[key][i]
        end
        i -= size(state_in.variables[key])[1]
    end
end
