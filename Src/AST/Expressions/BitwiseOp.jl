mutable struct BitwiseOp <: Node
    state :: State
    return_type :: String
    expr
    BitwiseOp(state_in, return_type) = new(state_in, return_type, nothing)
end

function init(self::BitwiseOp)
    # Check below
    #type can max be BigInt so it limits it at that
    self.return_type = is_less_than(self.return_type, "BigInt", true)[1]
    
    probs = [1,1,1,1,1,1,1]
    if self.return_type == "Bool"
        probs[4]=0
        probs[5]=0
        probs[6]=0
    end

    probs = round.(Int, 1000*(cumsum(probs)/sum(probs)))
    rand_n = rand(1:last(probs))
    if rand_n <= probs[1]
        self.expr = DualOp(self.state,"&",self.return_type,self.return_type)
    elseif rand_n <= probs[2]
        self.expr = DualOp(self.state,"|",self.return_type,is_less_than("BigInt", self.return_type, true)[1])
    elseif rand_n <= probs[3]
        self.expr = DualOp(self.state,"⊻",self.return_type,self.return_type)
    elseif rand_n <= probs[4]
        self.expr = DualOp(self.state,">>>",self.return_type,is_less_than("Irrational", self.return_type, true)[1])
    elseif rand_n <= probs[5]
        self.expr = DualOp(self.state,">>",self.return_type,self.return_type)
    elseif rand_n <= probs[6]
        self.expr = DualOp(self.state,"<<",self.return_type,is_less_than("Irrational", self.return_type, true)[1])
    elseif rand_n <= probs[7]
        self.expr = UnaryOp(self.state,"~",self.return_type,is_less_than("Irrational", self.return_type, true)[1])
    # Throws error if out of bounds of all
    elseif rand_n > last(probs)
        throw(ErrorException("Bitwise Op rand_n bounds error with - $rand_n. prob = $probs"))
    end
    init(self.expr)
end

function eval_type(self::BitwiseOp)
    return eval_type(self.expr)
end

function create_text(self::BitwiseOp)
    create_text(self.expr)
end