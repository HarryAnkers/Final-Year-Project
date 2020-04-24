# mutable struct Function <: Node
#     state :: State
#     name :: String
#     return_type :: String
#     arguments_type :: Array{String}
#     new :: Bool
#     random :: Bool
#     UnaryOp(state_in, name_in, return_type_in, new_in, random_in) = new(state_in, name_in, return_type_in, (), new_in, random_in)
# end

# function init(self::Function)
#     rand_n = rand(0:8)
#     for i in 0..rand_n

#         append!(self.arguments_type, Expression)
#     end
#     self.op = Expression(self.state, self.operand_type)
#     init(self.op)
# end

# function eval_type(self::Function)
#     # Some arith operators convert bool to int. Thus, it finds whatever is bigger type argument or int8
#     if self.operator in ["+","-"]
#         return compare_type("Int8",eval_type(self.op),false)[1]
#     end
#     return eval_type(self.op)
# end

# function create_text(self::Function)
#     write(self.state.file, "(")
#     write(self.state.file, self.operator)
#     create_text(self.op)
#     write(self.state.file,")")
# end