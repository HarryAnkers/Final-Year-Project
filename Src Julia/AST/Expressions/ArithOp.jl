mutable struct ArithOp <: Node
    state :: State
    return_type :: String
    expr
    ArithOp(state_in,return_type) = new(state_in,return_type,nothing)
end

function init(self::ArithOp)
    rand_n = rand(0:99)
    #checks that the return type isn't limited to bool if the arith will convert to a int. if it is skips over it
    if (self.return_type != "Bool") && ((rand_n<20)||(40<=rand_n<60)||(76<rand_n))
        if rand_n < 10
            self.expr = DualOp(self.state,"+",self.return_type,self.return_type)
        elseif rand_n < 20
            self.expr = DualOp(self.state,"-",self.return_type,self.return_type)
        elseif rand_n < 30
            self.expr = DualOp(self.state,"*",self.return_type,self.return_type)
        elseif rand_n < 40
            #checks the return type isn't forced to be less than a float as divide can make it a float. if it is skips over it.
            if compare_type("Float16",self.return_type,false)[2]
                #arguments to / can't be complex
                self.expr = DualOp(self.state,"/",self.return_type,compare_type(self.return_type, "BigFloat", true)[1])
            else
                self.expr = Expression(self.state,self.return_type)
            end
        elseif rand_n < 50
            #arguments can't be complex
            self.expr = DualOp(self.state,"÷",self.return_type,compare_type(self.return_type, "BigFloat", true)[1])
        elseif rand_n < 60
            #checks the return type isn't forced to be less than a float as divide can make it a float. if it is skips over it.
            if compare_type("Float16",self.return_type,false)[2]

            #arguments can't be complex
                self.expr = DualOp(self.state,"\\",self.return_type,compare_type(self.return_type, "BigFloat", true)[1])
            else
                self.expr = Expression(self.state,self.return_type)
            end
        elseif rand_n < 66

            #arguments can't be complex
            self.expr = DualOp(self.state,"^",self.return_type,compare_type(self.return_type, "BigFloat", true)[1])
        elseif rand_n < 76

            #arguments can't be complex
            self.expr = DualOp(self.state,"%",self.return_type,compare_type(self.return_type, "BigFloat", true)[1])
        elseif rand_n < 86
            self.expr = UnaryOp(self.state,"+",self.return_type,self.return_type)
        elseif rand_n < 100
            self.expr = UnaryOp(self.state,"-",self.return_type,self.return_type)
        end
    else
        self.expr = Expression(self.state,self.return_type)
    end
    init(self.expr)
end

function eval_type(self::ArithOp)
    return eval_type(self.expr)
end

function create_text(self::ArithOp)
    create_text(self.expr)
end