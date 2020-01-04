mutable struct BitwiseOp <: Node
    state :: State
    return_type :: String
    expr
    BitwiseOp(state_in, return_type) = new(state_in, return_type, nothing)
end

function init(self::BitwiseOp)
    rand_n = rand(0:99)
    #type can max be BigInt so it limits it at that
    self.return_type = compare_type(self.return_type, "BigInt", true)[1]
    if rand_n < 15
        self.expr = DualOp(self.state,"&",self.return_type,self.return_type)
    elseif rand_n < 30
        self.expr = DualOp(self.state,"|",self.return_type,self.return_type)
    elseif rand_n < 45
        self.expr = DualOp(self.state,"⊻",self.return_type,self.return_type)
    elseif rand_n < 60
        #shift can't have bool arguments. If bool skips it
        if self.return_type == "Bool"
            self.expr = Expression(self.state, self.return_type) 
        else
            self.expr = DualOp(self.state,">>>",self.return_type,self.return_type)
        end
    elseif rand_n < 75
        #shift can't have bool arguments. If bool skips it
        if self.return_type == "Bool"
            self.expr = Expression(self.state, self.return_type) 
        else
            self.expr = DualOp(self.state,">>",self.return_type,self.return_type)
        end
    elseif rand_n < 90
        #shift can't have bool arguments. If bool skips it
        if self.return_type == "Bool"
            self.expr = Expression(self.state, self.return_type) 
        else
            self.expr = DualOp(self.state,"<<",self.return_type,self.return_type)
        end
    elseif rand_n < 100
        self.expr = UnaryOp(self.state,"~",self.return_type,self.return_type)
    end
    init(self.expr)
end

function eval_type(self::BitwiseOp)
    return eval_type(self.expr)
end

function create_text(self::BitwiseOp)
    create_text(self.expr)
end