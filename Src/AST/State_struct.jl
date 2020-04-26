mutable struct State
    file::IOStream
    variables::Dict{Int, Array{Tuple{String,String}}}
    scope::Int
    State(file) = new(file,Dict{Int, Array{Tuple{String,String}}}(),0)
end

# Used to perform indenting for printing to files.
function write_pretty(indent::Int, in_state::State, in_string::String)
    for i = 1:indent
        write(in_state.file, "\t")
    end
    write(in_state.file, in_string)
end

# Gets all type compatable variables
function var_possibilities(state_in::State, type::String)
    possible_tuples::Array{Tuple{Int,Int}} = []
    for key in keys(state_in.variables)
        for i in 1:size(state_in.variables[key])[1]
            var = state_in.variables[key][i]
            if (is_less_than(var[2],type,true)[2])
                push!(possible_tuples, (key,i))
            end
        end
    end
    return possible_tuples
end
