mutable struct Function_use <: Node
    state :: State
    id :: String
    indent :: Int
    return_type :: String
    use_type :: Int
    possibilities :: Array{Tuple{Int64,Int64}}
    args
    body
    Function_use(state_in, use_type_in) = new(state_in, "", -1, string(typeof(type_to_random("Number"))), use_type_in, [], [], nothing)
    Function_use(state_in, return_type_in, use_type_in, possibilities) = new(state_in, "", -1, return_type_in, use_type_in, possibilities, [], nothing)
end

function init(self::Function_use)
    # preserves indent as state is changed by ref
    self.indent = self.state.scope
    # Use type 0 is for the creation of a new function
    if self.use_type == 0
        self.state.scope += 1
        tmp_func_count = self.state.func_count
        self.state.func_count = self.state.func_count+1

        # Adds random n of arguments types are in state and variables in the function
        tmp_arg_types = []
        arg_n = rand(0:7)
        for i in 1:arg_n
            rand_type = string(typeof(type_to_random("Number")))

            push!(tmp_arg_types,rand_type)
            push!(self.args, Variable(self.state,rand_type,0))
            init(last(self.args))
        end

        # Init the function body
        self.body = Statement_Lists(self.state)
        init(self.body)
        # Pops off the scope
        pop!(self.state.variables, self.state.scope, 0)
        pop!(self.state.functions, self.state.scope, 0)
        self.state.scope -= 1

        self.id = string("func_",tmp_func_count)
        # Each scope has it's own usable functions. If it exists it appends to that dict key
        if self.state.scope in keys(self.state.functions)
            push!(self.state.functions[self.state.scope], (self.id, self.return_type,tmp_arg_types))
        # If scope doesn't exist in the Dict. It creates new element containing the list with new functions
        else
            self.state.functions[self.state.scope] = [(self.id, self.return_type,tmp_arg_types)]
        end

    # Use type 1 is for the use of an random type compatable existing functions in expressions
    elseif self.use_type == 1
        # Get rand compatible function
        rand_n = rand(1:size(self.possibilities)[1])
        (key, index) = self.possibilities[rand_n]
        (self.id, self.return_type, tmpArgs) = self.state.functions[key][index]
        # Adds random expression in each arg by type
        for argType in tmpArgs
            push!(self.args, Expression(self.state, argType))
            init(last(self.args))
        end
    end
end

function eval_type(self::Function_use)
    return self.return_type
end

function create_text(self::Function_use)
    # Use type 0 is for the creation of a new function
    if self.use_type == 0
        # writes the function first
        write_pretty(self.indent, self.state, "function $(self.id)(")
        # for loops through arguments and writes the new variables
        for argument in self.args
            create_text(argument)
            write(self.state.file,",")
        end
        # writes the body
        write(self.state.file,")\n")
        create_text(self.body)
        write_pretty(self.indent+1, self.state, "return true\n")
        write_pretty(self.indent, self.state, "end\n")
        
    # Use type 1 is for the use of an random type compatable existing functions in expressions
    elseif self.use_type == 1
        # Insert the function name
        write(self.state.file,"$(self.id)(")
        # For loops over adding expressions as commas
        for argument in self.args
            create_text(argument)
            write(self.state.file,",")
        end
        write(self.state.file,")")
    end
end