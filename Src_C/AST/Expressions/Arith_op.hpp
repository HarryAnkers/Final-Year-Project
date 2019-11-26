#ifndef Primatives_hpp
#define Primatives_hpp
#include "../ASTNode.hpp"

class Unary_Add_Op : public ASTNode
{
public:
    expression::exp_1;
    expression::exp_2;

    Add_Op(State &state);

    //output_text
    void output_text(std::ostream &dst);
};

class Unary_Sub_Op : public ASTNode
{
public:
    expression::exp_1;
    expression::exp_2;

    Add_Op(State &state);

    //output_text
    void output_text(std::ostream &dst);
};

class Two_Arith_Op : public ASTNode
{
public:
    expression::exp_1;
    expression::exp_2;

    Two_Arith_Op(State &state);

    //output_text
    void output_text(std::ostream &dst);
}

// class Add_Op : public Two_Arith_Op
// {
// public:

//     Two_Arith_Op(State &state);

//     //output_text
//     void output_text(std::ostream &dst);
// }


#endif
