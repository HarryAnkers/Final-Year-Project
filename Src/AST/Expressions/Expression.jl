mutable struct Expression <: Node
    state :: State
    expr
    return_type :: String
    Expression(state_in, return_type) = new(state_in, nothing, return_type)
end

function init(self::Expression)
    rand_n = rand(0:99)
    if rand_n < 14
        self.expr = ArithOp(self.state, self.return_type)
    elseif rand_n < 28
        self.expr = BitwiseOp(self.state, self.return_type)
    elseif rand_n < 42
        self.expr = CompareOp(self.state)
    elseif rand_n < 60
        # all type comparable possibbilities are counted if non zero it uses variable. If count is 0 it skips it.
        possibilities = var_possibilities(self.state, self.return_type)
        size_p = size(possibilities)[1]
        if size_p > 0
            self.expr = Variable(self.state, self.return_type, 1, possibilities)
        else
            self.expr = Expression(self.state, self.return_type)
        end
    # elseif rand_n < 68
    #     self.expr = SpecialValueCheck(self.state)
    elseif rand_n < 100
        self.expr = Constant(self.state, self.return_type)
    end
    init(self.expr)
end

function eval_type(self::Expression)
    return eval_type(self.expr)
end

function create_text(self::Expression)
    create_text(self.expr)
end