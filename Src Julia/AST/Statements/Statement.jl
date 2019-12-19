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
    if rand_n < 10
        sub_statement = IfStatement(self.state)
        init(sub_statement)
    end
end

function create_text(self::Statement)
    if self.sub_statement !== nothing
        write(self.state.file,"--statement--")
        create_text(self.sub_statement)
    end
end