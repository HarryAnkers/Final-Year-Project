include("../node.jl")
include("../../State_struct.jl")



mutable struct Statement <: Node
    state :: State
    sub_statement
    Statement(state) = new(state,nothing)
end

function init(self::Statement)
    rand_n = rand(1:100)
    if self.state.scopeRecursion < 7
        rand_n = 101
    if rand_n < 5
        # sub_statement = IfStatement(self.state)
        print("if")
    end
end

function create_text(self::Statement)
    if self.sub_statement !== nothing
        create_text(self.sub_statement)
    end
end