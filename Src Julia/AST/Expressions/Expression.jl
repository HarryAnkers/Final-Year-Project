include("../node.jl")
include("../../State_struct.jl")
include("./Statement.jl")


mutable struct Expression <: Node
    state :: State
    next_sl
    statement
end

function init(self::Statement_Lists)
    rand_n = rand(1:100)
    if rand_n < 90
        self.statement = Statement(self.state,nothing)

        self.next_sl = Statement_Lists(self.state,nothing,nothing)
        init(self.next_sl)
    end
end

function create_text(self::Statement_Lists)
    if self.next_sl !== nothing
        create_text(self.statement)
        create_text(self.next_sl)
    end
end