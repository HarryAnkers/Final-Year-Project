mutable struct Statement_Lists <: Node
    state :: State
    next_sl
    statement
    Statement_Lists(state_in) = new(state_in,nothing,nothing)
end

function init(self::Statement_Lists)
    rand_n = rand(1:100)
    if rand_n < 90
        println(string("SL SR = ",self.state.scopeRecursion))
        self.statement = Statement(self.state)
        init(self.statement)

        self.next_sl = Statement_Lists(self.state)
        init(self.next_sl)
    end
end

function create_text(self::Statement_Lists)
    if self.next_sl !== nothing
        write(self.state.file,"--sl--")
        create_text(self.statement)
        create_text(self.next_sl)
    end
end