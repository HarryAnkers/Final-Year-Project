#include <iostream>
#include <fstream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// #include "AST/AST_include.hpp"
#include "AST/State.hpp"
#include "AST/Statements/Statement_List.hpp"

int main(){
    srand ( time(NULL) );
    State state = State();
    ASTNode *ast = new StatementList(state);
    std::cout<<"AAA"<<std::endl;
    ast->output_text(std::cout);
    return 0;
}