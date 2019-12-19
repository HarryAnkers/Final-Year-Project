mutable struct AssignStatement <: Node
    state :: State
    variable :: String
    expr
    AssignStatement(state_in) = new(state_in,nothing,nothing)
end

function init(self::AssignStatement)
    println("AssignStatement")
    # self.variable = Primatives(self.state)
    # init(self.variable)
    # self.expr = Expression(self.state)
    # init(self.expr)
    self.variable = "variable"
end

function create_text(self::AssignStatement)
    write(self.state.file, "--AssignStatement--")
    write(self.state.file, string(self.variable, " = "))
    create_text(self.expr)
    write(self.state.file, "\n")
end