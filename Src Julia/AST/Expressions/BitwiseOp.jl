mutable struct BitwiseOp <: Node
    state :: State
    expr
    BitwiseOp(state_in) = new(state_in,nothing)
end

function init(self::BitwiseOp)
    rand_n = rand(0:99)
    if rand_n < 15
        self.expr = DualOp(self.state,"&")
    elseif rand_n < 30
        self.expr = DualOp(self.state,"|")
    elseif rand_n < 45
        self.expr = DualOp(self.state,"⊻")
    elseif rand_n < 60
        self.expr = DualOp(self.state,">>>")
    elseif rand_n < 75
        self.expr = DualOp(self.state,">>")
    elseif rand_n < 90
        self.expr = DualOp(self.state,"<<")
    elseif rand_n < 100
        self.expr = UnaryOp(self.state,"~")
    end
    init(self.expr)
end

function create_text(self::BitwiseOp)
    create_text(self.expr)
end