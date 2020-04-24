mutable struct SpecialValueCheck <: Node
    state :: State
    expr
    SpecialValueCheck(state_in) = new(state_in,nothing)
end

# all compare ops return a Bool and all can't have complex arguments
function init(self::SpecialValueCheck)
    rand_n = rand(0:99)
    if rand_n < 40
        op1 = Expression(self.state,"Number")
        init(op1)
        op2 = Expression(self.state,"Number")
        init(op2)
        self.expr = Function_use(self.state,"isequal","Bool",[op1,op2])
    elseif rand_n < 60
        op = Expression(self.state,"Number")
        init(op)
        self.expr = Function_use(self.state,"isfinite","Bool",[op])
    elseif rand_n < 80
        op = Expression(self.state,"Number")
        init(op)
        self.expr = Function_use(self.state,"isinf","Bool",[op])
    elseif rand_n < 100
        op = Expression(self.state,"Number")
        init(op)
        self.expr = Function_use(self.state,"isnan","Bool",[op])
    end
end

function eval_type(self::SpecialValueCheck)
    # always returns a Bool
    return "Bool"
end

function create_text(self::SpecialValueCheck)
    create_text(self.expr)
end