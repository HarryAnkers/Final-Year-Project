#ifndef Primatives_hpp
#define Primatives_hpp
#include "../ASTNode.hpp"
#include <string>

class Variable : public ASTNode
{
public:
    std::string var_name;

    Variable(bool new_flag, std::string &type, State &state);

    //output_text
    void output_text(std::ostream &dst);
};

class Number : public ASTNode
{
public:
    float constant_val;

    Number(State &state);

    //output_text
    void output_text(std::ostream &dst);
};

#endif
