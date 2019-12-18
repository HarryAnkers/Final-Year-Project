#ifndef StatementList_hpp
#define StatementList_hpp

#include "../ASTNode.hpp"

class StatementList : public ASTNode
{
public:
    node cur_statement;
    node nextStatement;

    StatementList(State &state);

    //output_text
    void output_text(std::ostream &dst);
};

#endif
