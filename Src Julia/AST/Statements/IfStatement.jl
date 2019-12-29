mutable struct IfStatement <: Node
    state :: State
    elif :: Bool
    indent
    expr
    statement
    else_statement
    else_if_statement
    IfStatement(state_in) = new(state_in,false,0,nothing,nothing,nothing,nothing)
    IfStatement(state_in,elif_in) = new(state_in,elif_in,0,nothing,nothing,nothing,nothing)
end

function init(self::IfStatement)
    self.indent = self.state.scope
    self.state.scope += 1
    # self.expr = Expression(self.state)
    # init(self.expr)
    
    self.statement = Statement_Lists(self.state)
    init(self.statement)

    rand_n = rand(0:99)
    if self.state.scope > 3
        rand_n = 101
    end
    if rand_n < 20
        self.else_if_statement = IfStatement(self.state,true)
        init(self.else_if_statement)
    elseif rand_n < 40
        self.else_statement = Statement_Lists(self.state)
        init(self.else_statement)
    end
    pop!(self.state.variables,self.state.scope,0)
    self.state.scope -= 1
end

function create_text(self::IfStatement)
    if !self.elif
        write_pretty(self.indent, self.state, "if ")
    else
        write(self.state.file, "if ")
    end
    # create_text(self.expr)
    write(self.state.file, "true \n")
    create_text(self.statement)
    if self.else_statement !== nothing
        write_pretty(self.indent, self.state, "else ")
        create_text(self.else_statement)
    elseif self.else_if_statement !== nothing
        write_pretty(self.indent, self.state, "else")
        create_text(self.else_if_statement)
    end
    if !self.elif
        write_pretty(self.indent, self.state, "end\n")
    end
end