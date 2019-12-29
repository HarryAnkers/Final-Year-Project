mutable struct BitwiseOp <: Node
    state :: State
    return_type :: String
    expr
    BitwiseOp(state_in, return_type) = new(state_in, return_type, nothing)
end

function init(self::BitwiseOp)
    rand_n = rand(0:99)
    if rand_n < 15
        self.expr = DualOp(self.state,"&",self.return_type,self.return_type)
    elseif rand_n < 30
        self.expr = DualOp(self.state,"|",self.return_type,self.return_type)
    elseif rand_n < 45
        self.expr = DualOp(self.state,"⊻",self.return_type,self.return_type)
    elseif rand_n < 60
        self.expr = DualOp(self.state,">>>",self.return_type,self.return_type)
    elseif rand_n < 75
        self.expr = DualOp(self.state,">>",self.return_type,self.return_type)
    elseif rand_n < 90
        self.expr = DualOp(self.state,"<<",self.return_type,self.return_type)
    elseif rand_n < 100
        self.expr = UnaryOp(self.state,"~",self.return_type,self.return_type)
    end
    init(self.expr)
end

function create_text(self::BitwiseOp)
    create_text(self.expr)
end