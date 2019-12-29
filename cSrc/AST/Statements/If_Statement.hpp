#ifndef If_Statement_hpp
#define If_Statement_hpp
#include "../ASTNode.hpp"

class IfStatement : public ASTNode
{
public:
    node expression;
    node cur_statement;

    IfStatement(State &state);

    //output_text
    void output_text(std::ostream &dst);
};

#endif