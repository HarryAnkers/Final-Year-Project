#include "If_Statement.hpp"

#include "Statement_List.hpp"

IfStatement::IfStatement(State &state) {
    state.depth+=1;
    cur_statement = new StatementList(state);
    state.depth-=1;
}

    //output_text
void IfStatement::output_text(std::ostream &dst) {
    dst << "if (){" << std::endl;
    cur_statement->output_text(dst);
    dst << "}" << std::endl;
}
