mutable struct Statement <: Node
    state :: State
    sub_statement
    Statement(state_in) = new(state_in,nothing)
end

function init(self::Statement)
    rand_n = rand(1:100)
    if self.state.scopeRecursion > 5
        rand_n = 101
    end
    if rand_n < 8
        self.sub_statement = IfStatement(self.state)
        init(self.sub_statement)
    end
end

function create_text(self::Statement)
    if self.sub_statement !== nothing
        create_text(self.sub_statement)
    end
end