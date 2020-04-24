# mutable struct MathsOp <: Node
#     state :: State
#     return_type :: String
#     expr
#     MathsOp(state_in,return_type) = new(state_in,return_type,nothing)
# end

# function init(self::MathsOp)
#     rand_n = rand(0:90)
#     #checks that the return type isn't limited to bool if the arith will convert to a int. if it is skips over it
#     if compare_type("Float16",self.return_type,false)[2]
#         if rand_n < 7
#             op = Expression(self.state,"Number")
#             init(op)
#             self.return_type = compare_type(eval_type(op), "Float32", false)[1]
#             self.expr = Function_use(self.state,"sqrt",self.return_type,[op])
#         elseif rand_n < 14
#             op = Expression(self.state,"Number")
#             init(op)
#             self.return_type = compare_type(eval_type(op), "Float32", false)[1]
#             self.expr = Function_use(self.state,"cbrt",self.return_type,[op])
#         elseif rand_n < 21
#             op = Expression(self.state,"Number")
#             init(op)
#             self.return_type = compare_type(eval_type(op), "Float32", false)[1]
#             self.expr = Function_use(self.state,"exp",self.return_type,[op])
#         elseif rand_n < 28
#             op = Expression(self.state,"Number")
#             init(op)
#             self.return_type = compare_type(eval_type(op), "Float32", false)[1]
#             self.expr = Function_use(self.state,"expm1",self.return_type,[op])
#         elseif rand_n < 35
#             op = Expression(self.state,"Number")
#             init(op)
#             self.return_type = compare_type(eval_type(op), "Float32", false)[1]
#             if compare_type("Complex{Int8}",self.return_type,false)[2]

#             else
#             self.expr = Function_use(self.state,"log",self.return_type,[op])
#         elseif rand_n < 42
#             op = Expression(self.state,"Number")
#             init(op)
#             self.return_type = compare_type(eval_type(op), "Float32", false)[1]
#             self.expr = Function_use(self.state,"log2",self.return_type,[op])
#         elseif rand_n < 49
#             op = Expression(self.state,"Number")
#             init(op)
#             self.return_type = compare_type(eval_type(op), "Float32", false)[1]
#             self.expr = Function_use(self.state,"log10",self.return_type,[op])
#         elseif rand_n < 56
#             op = Expression(self.state,"Number")
#             init(op)
#             self.return_type = compare_type(eval_type(op), "Float32", false)[1]
#             self.expr = Function_use(self.state,"log1p",self.return_type,[op])
#         elseif rand_n < 63
#             op = Expression(self.state,"Number")
#             init(op)
#             self.return_type = compare_type(eval_type(op), "Float32", false)[1]
#             self.expr = Function_use(self.state,"exponent",self.return_type,[op])
#         elseif rand_n < 70
#             while(self.return_type != "Bool")
#                 op = Expression(self.state,"Number")
#                 init(op)
#                 self.return_type = compare_type(eval_type(op), "Float32", false)[1]
#             end
#             self.expr = Function_use(self.state,"significand",self.return_type,[op])
#         elseif rand_n < 77
#             op1 = Expression(self.state,"Number")
#             init(op1)
#             op2 = Expression(self.state,"Number")
#             init(op2)
#             self.expr = Function_use(self.state,"hypot",self.return_type,[op1,op2])
#         elseif rand_n < 84
#             op1 = Expression(self.state,"Number")
#             init(op1)
#             op2 = rand(Int8)
#             self.expr = Function_use(self.state,"ldexp",self.return_type,[op1,op2])
#         elseif rand_n < 91
#             op1 = Expression(self.state,"Number")
#             init(op1)
#             op2 = Expression(self.state,"Number")
#             init(op2)
#             self.expr = Function_use(self.state,"log",self.return_type,[op1,op2])
#         end
#     else
#         self.expr = Expression(self.state,self.return_type)
#         init(self.expr)
#     end
# end

# function eval_type(self::MathsOp)
#     return eval_type(self.expr)
# end

# function create_text(self::MathsOp)
#     create_text(self.expr)
# end