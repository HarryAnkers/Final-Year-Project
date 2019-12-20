mutable struct Expression <: Node
    state :: State
    expr
    Expression(state_in) = new(state_in,nothing)
end

function init(self::Expression)
    rand_n = rand(0:99)
    if rand_n < 15
        self.expr = ArithOp(self.state)
    elseif rand_n < 25
        self.expr = CompareOp(self.state)
    elseif rand_n < 32
        self.expr = CompareOp(self.state)
    elseif rand_n < 66
        if var_dict_size(self.state) > 0
            self.expr = Variable(self.state,false)
        else
            self.expr = Expression(self.state)
        end
    elseif rand_n < 100
        self.expr = ConstantInt(self.state)
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