mutable struct Variable <: Node
    state :: State
    id :: String
    return_type :: String
    use_type :: Int
    possibilities :: Array{Tuple{Int64,Int64}}
    Variable(state_in, return_type, use_type_in) = new(state_in, "", return_type, use_type_in, [])
    Variable(state_in, return_type, use_type_in, possibilities) = new(state_in, "", return_type, use_type_in, possibilities)
end

function init(self::Variable)
    arr_size = 0
    # Use type 0 is for the creation of a new variable
    if self.use_type == 0
        # Counts total number of variables in the state
        for dict_row in self.state.variables
            arr_size += size(dict_row[2])[1]
        end
        # Each scope has it's own usable variables. If it exists it appends to that dict key
        if self.state.scope in keys(self.state.variables)
            push!(self.state.variables[self.state.scope], (string("var_",arr_size),self.return_type))
            self.id = string("var_",arr_size)
        # If scope doesn't exist in the Dict. It creates new element containing the list with new variable
        else
            self.state.variables[self.state.scope] = [(string("var_",arr_size),self.return_type)]
            self.id = string("var_",arr_size)
        end
    # Use type 1 is for the use of an random type compatable existing variable in expressions
    elseif self.use_type == 1
        rand_n = rand(1:size(self.possibilities)[1])
        (key, index) = self.possibilities[rand_n]
        (self.id, self.return_type) = self.state.variables[key][index]
    # Use type 2 is for the reassignment of an exisiting variable in which the type in the state will need to be changed
    elseif self.use_type == 2
        rand_n = rand(1:size(self.possibilities)[1])
        (key, index) = self.possibilities[rand_n]
        (self.id, _) = self.state.variables[key][index]
        self.state.variables[key][index] = (self.id,self.return_type)
    end
end

function eval_type(self::Variable)
    return self.return_type
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
    # Creates a random constant with type less than the required.
    self.num = type_to_var(self.return_type)
end

function eval_type(self::Constant)
    return string(typeof(self.num))
end

function create_text(self::Constant)
    write(self.state.file, string('(', self.num,")"))
end