mutable struct AssignStatement <: Node
    state :: State
    indent :: Int
    variable
    expr
    AssignStatement(state_in) = new(state_in,0,nothing,nothing)
end

function init(self::AssignStatement)
    self.indent = self.state.scope
    self.expr = Expression(self.state)
    init(self.expr)
    self.variable = Variable(self.state,true)
    init(self.variable)
end

function create_text(self::AssignStatement)
    
    write_pretty(self.indent, self.state, "")
    create_text(self.variable)
    write(self.state.file, " = ")
    create_text(self.expr)
    write(self.state.file, "\n")
end