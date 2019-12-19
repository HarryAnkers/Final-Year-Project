mutable struct Expression <: Node
    state :: State
    expr
    Expression(state_in) = new(state_in,nothing)
end

function init(self::Expression)
    rand_n = rand(0:100)
    if rand_n < 5
        self.expr = DualOp(self.state,'+')
    elseif rand_n < 10
        self.expr = DualOp(self.state,'-')
    elseif rand_n < 15
        self.expr = DualOp(self.state,'/')
    elseif rand_n < 20
        self.expr = DualOp(self.state,'*')
    elseif rand_n < 25
        self.expr = UnaryOp(self.state,'-')
    elseif rand_n < 30
        self.expr = UnaryOp(self.state,'+')
    elseif rand_n < 50
        if var_dict_size(self.state) > 0
            self.expr = Variable(self.state,false)
        else
            self.expr = Expression(self.state)
        end
    elseif rand_n < 90
        self.expr = ConstantInt(self.state)
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