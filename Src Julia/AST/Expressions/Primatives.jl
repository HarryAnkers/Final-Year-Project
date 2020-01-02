mutable struct Variable <: Node
    state :: State
    id :: String
<<<<<<< HEAD
    type :: String
    new :: Bool
    Variable(state_in) = new(state_in, "", "", true)
    Variable(state_in, new_in) = new(state_in, "", "", new_in)
=======
    return_type :: String
    new :: Bool
    possibilities :: Array{Tuple{Int64,Int64}}
    Variable(state_in, return_type, new_in) = new(state_in, "", return_type, new_in, [])
    Variable(state_in, return_type, new_in, possibilities) = new(state_in, "", return_type, new_in, possibilities)
>>>>>>> 75f33fb46f8223a9cac9f8b05977e995444e46f4
end

function init(self::Variable)
    arr_size = 0
    if self.new
        if self.state.scope in keys(self.state.variables)
            arr_size = size(self.state.variables[self.state.scope])[1]
<<<<<<< HEAD
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
=======
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
>>>>>>> 75f33fb46f8223a9cac9f8b05977e995444e46f4
    end
end

function create_text(self::Variable)
    write(self.state.file, self.id)
end

<<<<<<< HEAD
mutable struct ConstantInt <: Node
    state :: State
    num :: Int
    ConstantInt(state_in) = new(state_in, 0)
end

function init(self::ConstantInt)
    self.num = rand(-10000:10000)
end

function create_text(self::ConstantInt)
    write(self.state.file, string(self.num))
=======
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
    return typeof(self.num)
end

function create_text(self::Constant)
    write(self.state.file, string('(', self.num,")"))
>>>>>>> 75f33fb46f8223a9cac9f8b05977e995444e46f4
end