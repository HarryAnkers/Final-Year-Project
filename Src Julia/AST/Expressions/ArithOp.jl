mutable struct ArithOp <: Node
    state :: State
    expr
    ArithOp(state_in) = new(state_in,nothing)
end

function init(self::ArithOp)
    rand_n = rand(0:99)
    if rand_n < 10
        self.expr = DualOp(self.state,"+")
    elseif rand_n < 20
        self.expr = DualOp(self.state,"-")
    elseif rand_n < 30
        self.expr = DualOp(self.state,"*")
    elseif rand_n < 40
        self.expr = DualOp(self.state,"/")
    elseif rand_n < 50
        self.expr = DualOp(self.state,"÷")
    elseif rand_n < 60
        self.expr = DualOp(self.state,"\\")
    elseif rand_n < 66
        self.expr = DualOp(self.state,"^")
    elseif rand_n < 76
        self.expr = DualOp(self.state,"%")
    elseif rand_n < 86
        self.expr = UnaryOp(self.state,"+")
    elseif rand_n < 100
        self.expr = UnaryOp(self.state,"-")
    end
    init(self.expr)
end

function create_text(self::ArithOp)
    create_text(self.expr)
end