mutable struct IfStatement <: Node
    state :: State
    expr
    statement
    else_statement
    else_if_statement
    IfStatement(state_in) = new(state_in,nothing,nothing,nothing,nothing)
end

function init(self::IfStatement)
    self.state.scopeRecursion += 1
    println(string("SR = ",self.state.scopeRecursion))
    println(self.state)
    self.statement = Statement_Lists(self.state)
    self.state.scopeRecursion -= 1
    println("---")
    println(self.state)
    println(self.statement.state)
    init(self.statement)
    self.expr = Expression(self.state)
    init(self.expr)

    rand_n = rand(1:100)
    if self.state.scopeRecursion > 5
        rand_n = 101
    end
    if rand_n < 20
        self.else_if_statement = IfStatement(self.state)
        init(self.else_if_statement)
    elseif rand_n < 40
        self.else_statement = Statement_Lists(self.state)
        init(self.else_statement)
    end
end

function create_text(self::IfStatement)
    write(self.state.file, "--IfStatement--")
    write(self.state.file, "if ")
    create_text(self.expr)
    write(self.state.file, "\n")
    create_text(self.statement)
    if self.else_statement !== nothing
        write(self.state.file, "else ")
        create_text(self.else_statement)
    elseif self.else_if_statement !== nothing
        write(self.state.file, "else")
        create_text(self.else_if_statement)
    end
    write(self.state.file, "end\n")
end