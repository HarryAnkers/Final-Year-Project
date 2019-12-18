#ifndef Assign_Statement_hpp
#define Assign_Statement_hpp

#include "../ASTNode.hpp"

class AssignStatement : public ASTNode
{
public:
    node var_id;
    node expression;

    AssignStatement(State &state);

    //output_text
    void output_text(std::ostream &dst);
};

#endif