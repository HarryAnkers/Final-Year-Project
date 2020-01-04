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
    # Sets the indent for the statement at it's current level. (This is done as the state level is passed by ref.)
    self.indent = self.state.scope
    # Scope is changed to group new variables declared in body
    self.state.scope += 1
    # If statements expressions must return a Bool
    self.expr = Expression(self.state, "Bool")
    init(self.expr)
    
    self.statement = Statement_Lists(self.state)
    init(self.statement)

    rand_n = rand(0:99)
    # Limits scope depth to stop endless recurssion
    if self.state.scope > 3
        rand_n = 101
    end
    # Creates an else if statement
    if rand_n < 20
        pop!(self.state.variables,self.state.scope,0)
        self.else_if_statement = IfStatement(self.state,true)
        init(self.else_if_statement)
    # Creates an else statement
    elseif rand_n < 40
        pop!(self.state.variables,self.state.scope,0)
        self.else_statement = Statement_Lists(self.state)
        init(self.else_statement)
    end
    # Pops remove all scope variables
    pop!(self.state.variables,self.state.scope,0)
    self.state.scope -= 1
end

function create_text(self::IfStatement)
    # If this if is already an else if it shouldn't be on a indented new line
    if !self.elif
        write_pretty(self.indent, self.state, "if ")
    else
        write(self.state.file, "if ")
    end
    create_text(self.expr)
    write(self.state.file, "\n")
    create_text(self.statement)
    # for the else statement
    if self.else_statement !== nothing
        write_pretty(self.indent, self.state, "else\n")
        create_text(self.else_statement)
    # for the elseif statement
    elseif self.else_if_statement !== nothing
        write_pretty(self.indent, self.state, "else")
        create_text(self.else_if_statement)
    end
    # If it isn't an elseif adds an end line
    if !self.elif
        write_pretty(self.indent, self.state, "end\n")
    end
end