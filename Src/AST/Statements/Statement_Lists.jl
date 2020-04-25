mutable struct Statement_Lists <: Node
    state :: State
    next_sl
    statement
    Statement_Lists(state_in) = new(state_in,nothing,nothing)
end

function init(self::Statement_Lists)
    probs = [round.(Int, 96/(self.state.scope+1)^(0.3)),100-round.(Int, 96/(self.state.scope+1)^(0.3))]
    probs = round.(Int, 1000*(cumsum(probs)/sum(probs)))

    rand_n = rand(0:last(probs))
    if rand_n <= probs[1]
        self.statement = Statement(self.state)
        init(self.statement)

        self.next_sl = Statement_Lists(self.state)
        init(self.next_sl)
    # Throws error if out of bounds of all
    elseif rand_n > last(probs)
        throw(ErrorException("Statement List rand_n bounds error with - $rand_n. prob = $probs"))
    end
end

function create_text(self::Statement_Lists)
    if self.next_sl !== nothing
        create_text(self.statement)
        create_text(self.next_sl)
    end
end