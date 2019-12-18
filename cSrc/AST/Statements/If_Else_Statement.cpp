#include "If_Else_Statement.hpp"

#include "Statement_List.hpp"

IfElseStatement::IfElseStatement(State &state){
    state.depth+=1;
    if_statement = new StatementList(state);
    else_statement = new StatementList(state);
    state.depth-=1;
}

//output_text
void IfElseStatement::output_text(std::ostream &dst) {
    dst << "if (){" << std::endl;
    if_statement->output_text(dst);
    dst << "} else {" << std::endl;
    else_statement->output_text(dst);
    dst << "}" << std::endl;
}