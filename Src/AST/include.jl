# This file is to merge all the files before being used in the topLevel file
include("./node.jl")
include("./State_struct.jl")
include("./Types.jl")

include("./Statements/Statement_Lists.jl")
include("./Statements/Statement.jl")
include("./Statements/IfStatement.jl")
include("./Statements/ForStatement.jl")
include("./Statements/AssignStatement.jl")
include("./Statements/ReturnStatement.jl")

include("./Expressions/Expression.jl")
include("./Expressions/Op.jl")
include("./Expressions/ArithOp.jl")
include("./Expressions/CompareOp.jl")
include("./Expressions/BitwiseOp.jl")
include("./Expressions/Primatives.jl")
include("./Expressions/SpecialValueCheck.jl")
include("./Expressions/MathsOp.jl")

include("./Functions/Function_use.jl")