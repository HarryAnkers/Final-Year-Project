mutable struct AssignStatement <: Node
    state :: State
    indent :: Int
    variable
    expr
    AssignStatement(state_in) = new(state_in,0,nothing,nothing)
end

function init(self::AssignStatement)
    self.indent = self.state.scope
    rand_n = rand(0:99)

    self.expr = Expression(self.state, "Number")
    init(self.expr)
    e_type =eval_type(self.expr)

    possibilities = var_possibilities(self.state, e_type)
    if size(possibilities)[1] == 0
        rand_n = 0
    end
    if rand_n < 66
        self.variable = Variable(self.state,e_type,0)
        init(self.variable)
    else 
        self.variable = Variable(self.state,e_type,2,possibilities)
        init(self.variable)
    end
end

function create_text(self::AssignStatement)
    write_pretty(self.indent, self.state, "")
    create_text(self.variable)
    write(self.state.file, " = ")
    create_text(self.expr)
    write(self.state.file, "\n")
end