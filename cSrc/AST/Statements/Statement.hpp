#ifndef Statement_hpp
#define Statement_hpp
#include "../ASTNode.hpp"

class Statement : public ASTNode
{
public:
    node cur_statement;

    Statement(State &state);

    //output_text
    void output_text(std::ostream &dst);
};

#endif
