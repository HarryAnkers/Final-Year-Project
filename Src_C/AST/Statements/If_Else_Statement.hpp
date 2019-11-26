#ifndef If_Else_Statement_hpp
#define If_Else_Statement_hpp

#include "../ASTNode.hpp"

class IfElseStatement : public ASTNode
{
public:
    node expression;
    node if_statement;
    node else_statement;

    IfElseStatement(State &state);

    //output_text
    void output_text(std::ostream &dst);
};

#endif