#ifndef ast_ASTNode_hpp
#define ast_ASTNode_hpp

#include <iostream>
#include <stdlib.h>
#include "State.hpp"

class ASTNode;

typedef ASTNode *node;

class ASTNode
{
public:
    ~ASTNode() {}

    //constructors will do the generating

    //output text
    virtual void output_text(std::ostream &dst) =0;
};


#endif
