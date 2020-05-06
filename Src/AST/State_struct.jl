mutable struct State
    file::IOStream
    variables::Dict{Int, Array{Tuple{String,String}}}
    var_count::Int
    functions::Dict{Int, Array{Tuple{String,String,Array{String}}}}
    func_count::Int
    return_type::String
    scope::Int
    State(file) = new(file, Dict{Int, Array{Tuple{String,String}}}(), 0, init_funcs(), 0, "", 0)
end

# Used to perform indenting for printing to files.
function write_pretty(indent::Int, in_state::State, in_string::String)
    for i = 1:indent
        write(in_state.file, "\t")
    end
    write(in_state.file, in_string)
end

# Gets all type compatable variables/functions
function get_possibilities(state_in_dict, type::String)
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

# add functions
function init_funcs()
    finalDict = Dict{Int, Array{Tuple{String,String,Array{String}}}}()
    finalDict[-1] = []

    funcs = [("sin","Number",["Number"]),
            ("sin","BigFloat",["BigFloat"]),
            ("cos","BigFloat",["BigFloat"]),
            ("cos","Number",["Number"]),
            ("tan","BigFloat",["BigFloat"]),
            ("tan","Number",["Number"]),

            ("sind","Number",["Number"]),
            ("sind","BigFloat",["BigFloat"]),
            ("cosd","BigFloat",["BigFloat"]),
            ("cosd","Number",["Number"]),
            ("tand","BigFloat",["BigFloat"]),
            ("tand","Number",["Number"]),

            ("round","Number",["Number"]),

            ("abs","BigFloat",["Number"]),
            
            ("fma","BigFloat",["BigFloat"]),
            ]
    for func in funcs
        push!(finalDict[-1], func)
    end
    return finalDict
end