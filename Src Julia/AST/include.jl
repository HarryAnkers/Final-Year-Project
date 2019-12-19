include("./node.jl")
include("./State_struct.jl")

# needs Statement
include("./Statements/Statement_Lists.jl")

# needs IfStatement
# needs AssignStatement
include("./Statements/Statement.jl")

#needs Expr
include("./Statements/IfStatement.jl")

#needs Expr
include("./Statements/AssignStatement.jl")

#needs Primatives
include("./Expressions/Expression.jl")