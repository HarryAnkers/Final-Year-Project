mutable struct ForStatement <: Node
    state :: State
    indent
    var
    use_Arg
    num
    statement
    ForStatement(state_in) = new(state_in,0,0,nothing)
end

function init(self::ForStatement)
    # Sets the indent for the statement at it's current level. (This is done as the state level is passed by ref.)
    self.indent = self.state.scope
    # Scope is changed to group new variables declared in body
    self.state.scope += 1
    # If statements expressions must return a Bool
    # self.expr = Expression(self.state, "Bool")
    self.num = rand(-100:100)
    self.var = Variable(self.state,"Int32",0)
    init(self.var)
    
    self.statement = Statement_Lists(self.state)
    init(self.statement)

    # Limits scope depth to stop endless recurssion
    if self.state.scope > 4
        self.statement = AssignStatement(self.state)
        init(self.statement)
    end
    # Pops remove all scope variables
    pop!(self.state.variables,self.state.scope,0)
    self.state.scope -= 1
end

function create_text(self::ForStatement)
    write_pretty(self.indent, self.state, "for ")
    create_text(self.var)
    if rand(-10,10) <= 0
        write(self.state.file, string(" = 1:",self.num,"\n"))
    else
        write(self.state.file, string(" = x:",self.num,"\n"))
    end
    create_text(self.statement)
    write_pretty(self.indent, self.state, "end\n")
end