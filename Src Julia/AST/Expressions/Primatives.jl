mutable struct Variable <: Node
    state :: State
    id :: String
    return_type :: String
    new :: Bool
    possibilities :: Array{Tuple{Int64,Int64}}
    Variable(state_in, return_type, new_in) = new(state_in, "", return_type, new_in, [])
    Variable(state_in, return_type, new_in, possibilities) = new(state_in, "", return_type, new_in, possibilities)
end

function init(self::Variable)
    arr_size = 0
    if self.new
        if self.state.scope in keys(self.state.variables)
            arr_size = size(self.state.variables[self.state.scope])[1]
            self.return_type = string(typeof(type_to_var(self.return_type)))
            push!(self.state.variables[self.state.scope], (string("var_",arr_size),self.return_type))
            self.id = string("var_",arr_size)
        else
            self.return_type = string(typeof(type_to_var(self.return_type)))
            self.state.variables[self.state.scope] = [("var_0",self.return_type)]
            self.id = "var_0"
        end
    else
        possibilities = var_possibilities(self.state, self.return_type)
        size_p = size(possibilities)[1]
        rand_n = rand(1:size_p)
        (key, index) = possibilities[rand_n]
        (self.id, self.return_type) = self.state.variables[key][index]
    end
end

function create_text(self::Variable)
    write(self.state.file, self.id)
end

mutable struct Constant <: Node
    state :: State
    return_type :: String
    num :: Number
    Constant(state_in, return_type) = new(state_in, return_type, 0)
end

function init(self::Constant)
    self.num = type_to_var(self.return_type)
end

function eval_type(self::Constant)
    return string(typeof(self.num))
end

function create_text(self::Constant)
    write(self.state.file, string('(', self.num,")"))
end