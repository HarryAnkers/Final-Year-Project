mutable struct Variable <: Node
    state :: State
    id :: String
    type :: String
    new :: Bool
    Variable(state_in) = new(state_in, "", "", true)
    Variable(state_in, new_in) = new(state_in, "", "", new_in)
end

function init(self::Variable)
    arr_size = 0
    if self.new
        if self.state.scope in keys(self.state.variables)
            arr_size = size(self.state.variables[self.state.scope])[1]
            push!(self.state.variables[self.state.scope], (string("var_",arr_size),"Int"))
            self.type = "Int"
            self.id = string("var_",arr_size)
        else
            self.state.variables[self.state.scope] = [("var_0","Int")]
            self.type = "Int"
            self.id = "var_0"
        end
    else
        arr_size = var_dict_size(self.state)
        rand_n = rand(1:arr_size)
        (self.id, self.type) = get_var(self.state,rand_n)
    end
end

function create_text(self::Variable)
    write(self.state.file, self.id)
end

mutable struct ConstantInt <: Node
    state :: State
    num :: Int
    ConstantInt(state_in) = new(state_in, 0)
end

function init(self::ConstantInt)
    self.num = rand(-10000:10000)
end

function create_text(self::ConstantInt)
    write(self.state.file, string(' ', self.num))
end