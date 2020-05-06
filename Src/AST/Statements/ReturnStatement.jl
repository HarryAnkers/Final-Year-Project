mutable struct ReturnStatement <: Node
    state :: State
    expr
    indent :: Int
    ReturnStatement(state_in) = new(state_in,nothing,0)
end

function init(self::ReturnStatement)
    self.indent = self.state.scope
    # Creates, initilizes, and evaluates the type of the expression so it is known what type to give the variable.
    self.expr = Expression(self.state, self.state.return_type)
    init(self.expr)
end

function create_text(self::ReturnStatement)
    write_pretty(self.indent, self.state, "return ")
    create_text(self.expr)
    write(self.state.file, "\n")
end