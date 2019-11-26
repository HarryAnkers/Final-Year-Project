abstract type Node end

struct A <: Node
    j::Int
    I::Node

    function  A()
        print("aaa")
    end

    function b()
        println("bbbb")
    end
end

blah = A(1,new Node)
A.b()