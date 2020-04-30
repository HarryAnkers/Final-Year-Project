# Includes the full tree
include("./AST/include.jl")

file_loc = ARGS[1]

function add_vars(self::State)
    write(self.file, "\n")
    if haskey(self.variables, 0)
        write(self.file, string("tmpLog = open(string(\"",file_loc,"log_files/log\",(ARGS[2]),\".txt\"), \"w\")\n"))
        write(self.file, "write(tmpLog, string(") 

        for i in self.variables[0]
            write(self.file, i[1])
            write(self.file, ",\",\",")
        end
        write(self.file, "0,\"\\n\"))\n")
        write(self.file, "close(tmpLog)\n")
    else
        write(self.file, "#no variables \n")

        write(self.file, string("tmpLog = open(string(\"",file_loc,"log_files/log\",(ARGS[2]),\".txt\"), \"w\")\n"))
        write(self.file, "write(tmpLog, \"no Vars\", string(x))\n")
        write(self.file, "close(tmpLog)\n")
    end
end

open(string(file_loc,"FILE.jl"), "w") do f
    # Creates the whole tree
    top_node = Statement_Lists(State(f))
    # Init. all nodes
    init(top_node)

    # Creates text to be put in the file stream
    write(f, "x = parse(Int64, ARGS[1])\n") 
    create_text(top_node)
    add_vars(top_node.state)

    # Close file
    close(f)
end
