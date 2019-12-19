mutable struct Expression <: Node
    state :: State
    Expression(state_in) = new(state_in)
end

function init(self::Expression)
    println("Expression")
    # rand_n = rand(1:100)
    # if rand_n < 90
    #     self.statement = Statement(self.state,nothing)

    #     self.next_sl = Statement_Lists(self.state,nothing,nothing)
    #     init(self.next_sl)
    # end
end

function create_text(self::Expression)
    write(self.state.file, "--Expression--")
    write(self.state.file,"Expr")
end