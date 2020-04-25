DIV = false

mutable struct ArithOp <: Node
    state :: State
    return_type :: String
    expr
    ArithOp(state_in,return_type) = new(state_in,return_type,nothing)
end

function init(self::ArithOp)
    probs = [2,2,2,2,1,1,1,1,1,1]
    if self.return_type == "Bool"
        probs[1]=0
        probs[2]=0
        probs[4]=0
        probs[6]=0
        probs[9]=0
        probs[10]=0
    elseif (compare_type("Float16",self.return_type,false)[2])
        probs[4]=0
        probs[6]=0
        probs[7]=0
    end
    if !DIV
        probs[4]=0
        probs[5]=0
        probs[6]=0
        probs[8]=0
    end
    if sum(probs)==0
        throw(ErrorException("Arith Op no rand_n possible"))
    end

    probs = round.(Int, 1000*(cumsum(probs)/sum(probs)))
    rand_n = rand(1:last(probs))
    if rand_n <= probs[1]
        self.expr = DualOp(self.state,"+",self.return_type,self.return_type)
    elseif rand_n <= probs[2]
        self.expr = DualOp(self.state,"-",self.return_type,self.return_type)
    elseif rand_n <= probs[3]
        self.expr = DualOp(self.state,"*",self.return_type,self.return_type)
    elseif rand_n <= probs[4]
        #arguments can't be complex
        self.expr = DualOp(self.state,"/",self.return_type,compare_type(self.return_type, "BigFloat", true)[1])
    elseif rand_n <= probs[5]
        #arguments can't be complex
        self.expr = DualOp(self.state,"÷",self.return_type,compare_type(self.return_type, "BigFloat", true)[1])
    elseif rand_n <= probs[6]
        #arguments can't be complex
        self.expr = DualOp(self.state,"//",self.return_type,compare_type(self.return_type, "BigFloat", true)[1])
    elseif rand_n <= probs[7]
        #arguments can't be complex
        self.expr = DualOp(self.state,"^",self.return_type,compare_type(self.return_type, "BigFloat", true)[1])
    elseif rand_n <= probs[8]
        #arguments can't be complex
        self.expr = DualOp(self.state,"%",self.return_type,compare_type(self.return_type, "BigFloat", true)[1])
    elseif rand_n <= probs[9]
        self.expr = UnaryOp(self.state,"+",self.return_type,self.return_type)
    elseif rand_n <= probs[10]
        self.expr = UnaryOp(self.state,"-",self.return_type,self.return_type)
    # Throws error if out of bounds of all
    elseif rand_n > last(probs)
        throw(ErrorException("Arith Op rand_n bounds error with - $rand_n. prob = $probs"))
    end
    init(self.expr)
end

function eval_type(self::ArithOp)
    return eval_type(self.expr)
end

function create_text(self::ArithOp)
    create_text(self.expr)
end