mutable struct CompareOp <: Node
    state :: State
    expr
    CompareOp(state_in) = new(state_in,nothing)
end

function init(self::CompareOp)
    rand_n = rand(0:89)
    if rand_n < 12
        self.expr = DualOp(self.state,"==","Bool","Number")
    elseif rand_n < 24
        if rand_n < 30
            self.expr = DualOp(self.state,"!=","Bool","Number")
        else
            self.expr = DualOp(self.state,"≠","Bool","Number")
        end
    elseif rand_n < 42
        self.expr = DualOp(self.state,"<","Bool","Number")
    elseif rand_n < 54
        self.expr = DualOp(self.state,">","Bool","Number")
    elseif rand_n < 66
        if rand_n < 72
            self.expr = DualOp(self.state,"<=","Bool","Number")
        else
            self.expr = DualOp(self.state,"≤","Bool","Number")
        end
    elseif rand_n < 84
        if rand_n < 90
            self.expr = DualOp(self.state,">=","Bool","Number")
        else
            self.expr = DualOp(self.state,"≥","Bool","Number")
        end
    elseif rand_n < 100
        self.expr = UnaryOp(self.state,"!","Bool","Bool")
    end
    init(self.expr)
end

function create_text(self::CompareOp)
    create_text(self.expr)
end