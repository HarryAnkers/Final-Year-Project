mutable struct Expression <: Node
    state :: State
    expr
    return_type :: String
    Expression(state_in, return_type) = new(state_in, nothing, return_type)
end

function init(self::Expression)
    rand_n = rand(0:99)
    if rand_n < 20
        self.expr = ArithOp(self.state, self.return_type)
    elseif rand_n < 25
        self.expr = BitwiseOp(self.state, self.return_type)
    elseif rand_n < 32
        self.expr = CompareOp(self.state)
    elseif rand_n < 66
        if var_dict_size(self.state) > 0
            self.expr = Variable(self.state, self.return_type, false)
        else
            self.expr = Expression(self.state, self.return_type)
        end
    elseif rand_n < 100
        self.expr = Constant(self.state, self.return_type)
    end
    if self.expr !== nothing
        init(self.expr)
    end
end

function create_text(self::Expression)
    if self.expr !== nothing
        create_text(self.expr)
    end
end