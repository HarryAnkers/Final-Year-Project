mutable struct AssignStatement <: Node
    state :: State
    indent :: Int
    variable
    expr
    AssignStatement(state_in) = new(state_in,0,nothing,nothing)
end

function init(self::AssignStatement)
    self.indent = self.state.scope
<<<<<<< HEAD
    self.variable = Variable(self.state,true)
    init(self.variable)
    self.expr = Expression(self.state)
    init(self.expr)
end

function create_text(self::AssignStatement)
    
=======
    self.expr = Expression(self.state, "Number")
    init(self.expr)
    self.variable = Variable(self.state,"Number",true)
    init(self.variable)
end

function create_text(self::AssignStatement)
>>>>>>> 75f33fb46f8223a9cac9f8b05977e995444e46f4
    write_pretty(self.indent, self.state, "")
    create_text(self.variable)
    write(self.state.file, " = ")
    create_text(self.expr)
    write(self.state.file, "\n")
end