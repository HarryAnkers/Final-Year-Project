mutable struct DualOp <: Node
    state :: State
    op1
    operator :: String
    op2
    return_type :: String
    operand_type :: String
    DualOp(state_in, operator, return_type, operand_type) = new(state_in,nothing,operator,nothing, return_type, operand_type)
end

function init(self::DualOp)
    self.op1 = Expression(self.state, self.operand_type)
    init(self.op1)
    self.op2 = Expression(self.state, self.operand_type)
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
    operator :: String
    op
    return_type :: String
    operand_type :: String
    UnaryOp(state_in, operator, return_type, operand_type) = new(state_in,operator,nothing, return_type, operand_type)
end

function init(self::UnaryOp)
    self.op = Expression(self.state, self.operand_type)
    init(self.op)
end

function create_text(self::UnaryOp)
    write(self.state.file, "(")
    write(self.state.file, self.operator)
    create_text(self.op)
    write(self.state.file,")")
end