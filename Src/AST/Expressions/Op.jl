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

function eval_type(self::DualOp)
    type1 = eval_type(self.op1)
    type2 = eval_type(self.op2)
    compare_t = compare_type(type1,type2,false)[1]
    # if a divide operator it can convert to a float. Thus, it finds whatever is bigger type argument or float16
    if self.operator in ["\\","/"]
        return compare_type("Float16",compare_t,false)[1]
    # Some arith operators convert bool to int. Thus, it finds whatever is bigger type argument or int8
    elseif self.operator in ["+","-","÷"]
        return compare_type("Int8",compare_t,false)[1]
    end
    return compare_t
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

function eval_type(self::UnaryOp)
    # Some arith operators convert bool to int. Thus, it finds whatever is bigger type argument or int8
    if self.operator in ["+","-"]
        return compare_type("Int8",eval_type(self.op),false)[1]
    end
    return eval_type(self.op)
end

function create_text(self::UnaryOp)
    write(self.state.file, "(")
    write(self.state.file, self.operator)
    create_text(self.op)
    write(self.state.file,")")
end