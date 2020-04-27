mutable struct Statement <: Node
    state :: State
    sub_statement
    Statement(state_in) = new(state_in,nothing)
end

function init(self::Statement)
    probs = [20,10,90,6]
    probs = round.(Int, 1000*(cumsum(probs)/sum(probs)))
    rand_n = rand(1:last(probs))

    # note this must be less than 1/E(lines in a body) (=5%) to avoid endless recursion. Caps to stop this also exist
    if rand_n <= probs[1]
        self.sub_statement = IfStatement(self.state)
        init(self.sub_statement)
    elseif rand_n <= probs[2]
        self.sub_statement = ForStatement(self.state)
        init(self.sub_statement)
    elseif rand_n <= probs[3]
        self.sub_statement = AssignStatement(self.state)
        init(self.sub_statement)
    elseif rand_n <= probs[4]
        println("hit")
        self.sub_statement = Function_use(self.state,0)
        init(self.sub_statement)
    # Throws error if out of bounds of all
    elseif rand_n > last(probs)
        throw(ErrorException("Statement rand_n bounds error with - $rand_n. prob = $probs"))
    end
end

function create_text(self::Statement)
    if self.sub_statement !== nothing
        create_text(self.sub_statement)
    end
end