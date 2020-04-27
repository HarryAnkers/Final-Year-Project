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

    # Pops remove all scope variables
    pop!(self.state.variables, self.state.scope,0)
    pop!(self.state.functions, self.state.scope, 0)
    self.state.scope -= 1
end

function create_text(self::ForStatement)
    write_pretty(self.indent, self.state, "for ")
    create_text(self.var)

    probs = [1,1]
    probs = round.(Int, 1000*(cumsum(probs)/sum(probs)))
    rand_n = rand(1:last(probs))

    if rand_n <= probs[1]
        write(self.state.file, string(" = 1:",self.num,"\n"))
    elseif rand_n <= probs[2]
        write(self.state.file, string(" = x:",self.num,"\n"))
    # Throws error if out of bounds of all
    elseif rand_n > last(probs)
        throw(ErrorException("For-Statement rand_n bounds error with - $rand_n. prob = $probs"))
    end
    create_text(self.statement)
    write_pretty(self.indent, self.state, "end\n")
end