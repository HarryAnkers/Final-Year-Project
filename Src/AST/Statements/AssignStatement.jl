mutable struct AssignStatement <: Node
    state :: State
    indent :: Int
    variable
    expr
    AssignStatement(state_in) = new(state_in,0,nothing,nothing)
end

function init(self::AssignStatement)
    # Sets the indent for the statement at it's current level. (This is done as the state level is passed by ref.)
    self.indent = self.state.scope

    # Creates, initilizes, and evaluates the type of the expression so it is known what type to give the variable.
    self.expr = Expression(self.state, "Number")
    init(self.expr)
    e_type = eval_type(self.expr)
    possibilities = get_possibilities(self.state.variables, eval_type(self.expr))

    probs = [2,1]
    if size(possibilities)[1] == 0
        probs[2] = 0
    end
    probs = round.(Int, 1000*(cumsum(probs)/sum(probs)))
    rand_n = rand(1:last(probs))
    if rand_n <= probs[1]
        # Creates a new variable
        self.variable = Variable(self.state,e_type,0)
        init(self.variable)
    elseif rand_n <= probs[2]
        # Uses existing variable
        self.variable = Variable(self.state,e_type,2,possibilities)
        init(self.variable)
    # Throws error if out of bounds of all
    elseif rand_n > last(probs)
        throw(ErrorException("Assign Statement rand_n bounds error with - $rand_n. prob = $probs"))
    end
end

function create_text(self::AssignStatement)
    write_pretty(self.indent, self.state, "")
    create_text(self.variable)
    write(self.state.file, " = ")
    create_text(self.expr)
    write(self.state.file, "\n")
end