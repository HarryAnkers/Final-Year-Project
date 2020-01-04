mutable struct CompareOp <: Node
    state :: State
    expr
    CompareOp(state_in) = new(state_in,nothing)
end

# all compare ops return a Bool and all can't have complex arguments
function init(self::CompareOp)
    rand_n = rand(0:99)
    if rand_n < 12
        self.expr = DualOp(self.state,"==","Bool","BigFloat")
    elseif rand_n < 24
        if rand_n < 30
            self.expr = DualOp(self.state,"!=","Bool","BigFloat")
        else
            self.expr = DualOp(self.state,"≠","Bool","BigFloat")
        end
    elseif rand_n < 42
        self.expr = DualOp(self.state,"<","Bool","BigFloat")
    elseif rand_n < 54
        self.expr = DualOp(self.state,">","Bool","BigFloat")
    elseif rand_n < 66
        if rand_n < 72
            self.expr = DualOp(self.state,"<=","Bool","BigFloat")
        else
            self.expr = DualOp(self.state,"≤","Bool","BigFloat")
        end
    elseif rand_n < 84
        if rand_n < 90
            self.expr = DualOp(self.state,">=","Bool","BigFloat")
        else
            self.expr = DualOp(self.state,"≥","Bool","BigFloat")
        end
    elseif rand_n < 100
        # the not operator must only have a boolean argument
        self.expr = UnaryOp(self.state,"!","Bool","Bool")
    end
    init(self.expr)
end

function eval_type(self::CompareOp)
    # always returns a Bool
    return "Bool"
end

function create_text(self::CompareOp)
    create_text(self.expr)
end