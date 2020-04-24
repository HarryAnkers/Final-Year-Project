mutable struct Statement_Lists <: Node
    state :: State
    next_sl
    statement
    Statement_Lists(state_in) = new(state_in,nothing,nothing)
end

function init(self::Statement_Lists)
    println("-----")
    println(self.state.scope+1)
    probs = [round.(Int, 95/(self.state.scope+1)^(0.6)),100-round.(Int, 95/(self.state.scope+1)^(0.6))]
    println(probs)
    probs = round.(Int, 1000*(probs/sum(probs)))
    println(probs)

    rand_n = rand(0:(sum(probs)))
    if rand_n <= probs[1]
        self.statement = Statement(self.state)
        init(self.statement)

        self.next_sl = Statement_Lists(self.state)
        init(self.next_sl)
    # if doesn't match then it finishes list
    # else
        # throw(ErrorException("In Statement Lists nothing was used and rand_n = $rand_n. prob = $probs"))
    end
end

function create_text(self::Statement_Lists)
    if self.next_sl !== nothing
        create_text(self.statement)
        create_text(self.next_sl)
    end
end