mutable struct Expression <: Node
    state :: State
    expr
    return_type :: String
    Expression(state_in, return_type) = new(state_in, nothing, return_type)
end

function init(self::Expression)
    probs = [1,1,1,1,4]
    # all type comparable possibilities are counted if non zero it uses variable. If count is 0 it skips it.
    possibilities = get_possibilities(self.state.variables, self.return_type)
    if size(possibilities)[1] == 0
        probs[4]=0
    end
    
    probs = round.(Int, 1000*(cumsum(probs)/sum(probs)))
    rand_n = rand(1:last(probs))
    # Arith OPs
    if rand_n <= probs[1]
        self.expr = ArithOp(self.state, self.return_type)
    # Bitwise OPs
    elseif rand_n <= probs[2]
        self.expr = BitwiseOp(self.state, self.return_type)
    # Compare OPs
    elseif rand_n <= probs[3]
        self.expr = CompareOp(self.state)
    # Existing Variable use
    elseif rand_n <= probs[4]
        self.expr = Variable(self.state, self.return_type, 1, possibilities)
    # elseif rand_n <= probs[1]
    #     self.expr = SpecialValueCheck(self.state)
    # Constant use
    elseif rand_n <= probs[5]
        self.expr = Constant(self.state, self.return_type)
    # Throws error if out of bounds of all
    elseif rand_n > last(probs)
        throw(ErrorException("Expr rand_n bounds error with - $rand_n. prob = $probs"))
    end
    init(self.expr)
end

function eval_type(self::Expression)
    return eval_type(self.expr)
end

function create_text(self::Expression)
    create_text(self.expr)
end