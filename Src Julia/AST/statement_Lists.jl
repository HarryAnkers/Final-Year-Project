include("./node.jl")

mutable struct statement_Lists <: Node
    state::State

    # current_node
    function init()
        rand_n = rand(Float16)*100
        if rand_n < 90
            current_node = statement_Lists(state)
            current_node.init()
        end
    end

    function create_text()
        print("aa--aa")
        if(isempty(current_node))
            current_node.create_text()
        end
    end
end