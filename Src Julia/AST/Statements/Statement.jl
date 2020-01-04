mutable struct Statement <: Node
    state :: State
    sub_statement
    Statement(state_in) = new(state_in,nothing)
end

function init(self::Statement)
    rand_n = rand(0:99)
    # Sets max scope depth of 5
    # A better future solution would be adjust probability of new scopes the deeper they go
    if self.state.scope > 5
        rand_n = 101
    end
    # note this must be less than 1/E(lines in a body) (=5%) to avoid endless recursion. Caps to stop this also exist
    if rand_n < 4
        self.sub_statement = IfStatement(self.state)
        init(self.sub_statement)
    elseif rand_n < 100
        self.sub_statement = AssignStatement(self.state)
        init(self.sub_statement)
    end
end

function create_text(self::Statement)
    if self.sub_statement !== nothing
        create_text(self.sub_statement)
    end
end