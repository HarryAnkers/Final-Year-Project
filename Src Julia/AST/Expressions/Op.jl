mutable struct DualOp <: Node
    state :: State
    op1
    operator :: Char
    op2
    DualOp(state_in, operator) = new(state_in,nothing,operator,nothing)
end

function init(self::DualOp)
    self.op1 = Expression(self.state)
    init(self.op1)
    self.op2 = Expression(self.state)
    init(self.op2)
end

function create_text(self::DualOp)
    write(self.state.file, "(")
    create_text(self.op1)
    write(self.state.file, self.operator)
    create_text(self.op2)
    write(self.state.file,")")
end

mutable struct UnaryOp <: Node
    state :: State
    operator :: Char
    op
    UnaryOp(state_in, operator) = new(state_in,operator,nothing)
end

function init(self::UnaryOp)
    self.op = Expression(self.state)
    init(self.op)
end

function create_text(self::UnaryOp)
    write(self.state.file, "(")
    write(self.state.file, self.operator)
    create_text(self.op)
    write(self.state.file,")")
end