mutable struct Function_use <: Node
    state :: State
    id :: String
    return_type :: String
    use_type :: Int
    possibilities :: Array{Tuple{Int64,Int64}}
    args
    Function_use(state_in, id_in, return_type_in, use_type_in) = new(state_in, "", return_type_in, use_type_in, [], [])
    Function_use(state_in, id_in, return_type_in, use_type_in, possibilities) = new(state_in, "", return_type_in, use_type_in, possibilities, [])
end

function init(self::Function)
    # Use type 0 is for the creation of a new funnction
    if self.use_type == 0
        arr_size = self.func_count
        

        # Each scope has it's own usable functions. If it exists it appends to that dict key
        if self.state.scope in keys(self.state.functions)
            push!(self.state.functions[self.state.scope], (string("func_",arr_size),self.return_type))
            self.id = string("func_",arr_size)
        # If scope doesn't exist in the Dict. It creates new element containing the list with new functions
        else
            self.state.functions[self.state.scope] = [(string("func_",arr_size),self.return_type)]
            self.id = string("func_",arr_size)
        end
    # # Use type 1 is for the use of an random type compatable existing functions in expressions
    if self.use_type == 1
        rand_n = rand(1:size(self.possibilities)[1])
        (key, index) = self.possibilities[rand_n]
        (self.id, self.return_type, tmpArgs) = self.state.functions[key][index]
        for argType in tmpArgs
            push!(self.args, Expression(self.state, argType))
            last(self.args) = init(last(self.args))
        end
    end
end

function eval_type(self::Function)
    return self.return_type
end

function create_text(self::Function_use)
    write(self.state.file, string(self.name,"("))
    for arg in self.arguments
        if typeof(arg) <: Node
            create_text(arg)
        else
            write(self.state.file,arg)
        end
        write(self.state.file,",")
    end
    write(self.state.file, ")")
end