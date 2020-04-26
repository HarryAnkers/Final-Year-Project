mutable struct State
    file::IOStream
    variables::Dict{Int, Array{Tuple{String,String}}}
    var_count::Int
    functions::Dict{Int, Array{Tuple{String,String,Array{String}}}}
    func_count::Int
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

# Gets all type compatable variables/functions
function get_possibilities(state_in_dict::Dict{Int, Array{}}, type::String)
    possible_tuples::Array{Tuple{Int,Int}} = []
    for key in keys(state_in_dict)
        for i in 1:size(state_in_dict[key])[1]
            var = state_in_dict[key][i]
            if (is_less_than(var[2],type,true)[2])
                push!(possible_tuples, (key,i))
            end
        end
    end
    return possible_tuples
end
