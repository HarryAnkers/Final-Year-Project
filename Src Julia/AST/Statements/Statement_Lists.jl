include("../node.jl")
include("../../State_struct.jl")

mutable struct Statement_Lists <: Node
    state::State
    next_sl
    statement
end

function init(sl::Statement_Lists)
    rand_n = rand(Float16)*100
    if rand_n < 90
        next_sl = Statement_Lists(sl.state,nothing,nothing)
        init(next_sl)
    end
end

function create_text(sl::Statement_Lists)
    if(isempty(sl.next_sl))
        create_text(sl.statement)
    end
end