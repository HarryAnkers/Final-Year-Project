mutable struct Expression <: Node
    state :: State
    expr
    return_type :: String
    Expression(state_in, return_type) = new(state_in, nothing, return_type)
end

function init(self::Expression)
    probs = [20,20,20,20,200,10,5]
    # all type comparable possibilities are counted if non zero it uses variable. If count is 0 it skips it.
    var_possibilities = get_possibilities(self.state.variables, self.return_type)
    if size(var_possibilities)[1] == 0
        probs[4]=0
    end

    func_possibilities1 = get_possibilities(delete!(copy(self.state.functions),-1), self.return_type)
    func_possibilities2 = get_possibilities(Dict(-1=>get!(copy(self.state.functions),-1,"Err")), self.return_type)
    if size(func_possibilities1)[1] == 0
        probs[6]=0
    end
    if size(func_possibilities2)[1] == 0
        probs[7]=0
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
        self.expr = Variable(self.state, self.return_type, 1, var_possibilities)
    # Constant use
    elseif rand_n <= probs[5]
        self.expr = Constant(self.state, self.return_type)
    # Function use
    elseif rand_n <= probs[6]
        self.expr = Function_use(self.state, self.return_type, 1, func_possibilities1)
    # Preexisting Function use
    elseif rand_n <= probs[7]
        self.expr = Function_use(self.state, self.return_type, 1, func_possibilities2)
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