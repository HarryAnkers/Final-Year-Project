mutable struct Function_use <: Node
    state :: State
    name :: String
    return_type :: String
    arguments
    Function_use(state_in, name_in, return_type_in, arguments_in) = new(state_in, name_in, return_type_in, arguments_in)
end

# function init(self::Function)
# end

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