#ifndef arith_hpp
#define arith_hpp
#include "../ASTNode.hpp"
#include "Expressions.hpp"

class Unary_Op : public ASTNode
{
public:
    Expression* exp;
    std::string operand;
    Unary_Op(State &state);

    //output_text
    void output_text(std::ostream &dst);
};

class Dual_Op : public ASTNode
{
public:
    Expression* exp_1;
    Expression* exp_2;
    std::string operand;

    Dual_Op(State &state);

    //output_text
    void output_text(std::ostream &dst);
};

#endif
