include("../node.jl")
include("../../State_struct.jl")
# include("../Expressions/Expression.jl")
# include("../Expressions/Primatives.jl")

mutable struct AssignStatement <: Node
    state :: State
    variable :: String
    expr
    AssignStatement(state) = new(state,nothing,nothing)
end

function init(self::AssignStatement)
    # self.variable = Primatives(self.state)
    # init(self.variable)
    # self.expr = Expression(self.state)
    # init(self.expr)
    a=1+1
end

function create_text(self::AssignStatement)
    write(self.state.file, string(self.variable, " = "))
    create_text(self.expr)
    write(self.state.file, "\n")
end