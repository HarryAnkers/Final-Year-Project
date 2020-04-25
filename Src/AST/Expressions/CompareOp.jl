mutable struct CompareOp <: Node
    state :: State
    expr
    CompareOp(state_in) = new(state_in,nothing)
end

# all compare ops return a Bool and all can't have complex arguments
function init(self::CompareOp)
    probs = [2,1,1,2,2,1,1,1,1,2]

    probs = round.(Int, 1000*(cumsum(probs)/sum(probs)))
    rand_n = rand(1:last(probs))
    if rand_n <= probs[1]
        self.expr = DualOp(self.state,"==","Bool","BigFloat")
    elseif rand_n <= probs[2]
        self.expr = DualOp(self.state,"!=","Bool","BigFloat")
    elseif rand_n <= probs[3]
        self.expr = DualOp(self.state,"≠","Bool","BigFloat")
    elseif rand_n <= probs[4]
        self.expr = DualOp(self.state,"<","Bool","BigFloat")
    elseif rand_n <= probs[5]
        self.expr = DualOp(self.state,">","Bool","BigFloat")
    elseif rand_n <= probs[6]
        self.expr = DualOp(self.state,"<=","Bool","BigFloat")
    elseif rand_n <= probs[7]
        self.expr = DualOp(self.state,"≤","Bool","BigFloat")
    elseif rand_n <= probs[8]
        self.expr = DualOp(self.state,">=","Bool","BigFloat")
    elseif rand_n <= probs[9]
        self.expr = DualOp(self.state,"≥","Bool","BigFloat")
    elseif rand_n <= probs[10]
        # the not operator must only have a boolean argument
        self.expr = UnaryOp(self.state,"!","Bool","Bool")
    # Throws error if out of bounds of all
    elseif rand_n > last(probs)
        throw(ErrorException("Arith Op rand_n bounds error with - $rand_n. prob = $probs"))
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