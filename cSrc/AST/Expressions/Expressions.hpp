#ifndef expression_hpp
#define expression_hpp

#include "../ASTNode.hpp"

class Expression : public ASTNode
{
public:
    node exp;
    Expression(State &state);

    //output_text
    void output_text(std::ostream &dst);
};

#endif