#include "Statement.hpp"

#include "Assign_Statement.hpp"
#include "If_Statement.hpp"
#include "If_Else_Statement.hpp"

Statement::Statement(State &state) {
    int rand_N = rand() % 100;
    if (rand_N < 15){
        cur_statement = new IfStatement(state);
    } else if (rand_N < 30){
        cur_statement = new IfElseStatement(state);
    } else if (rand_N < 100){
        cur_statement = new AssignStatement(state);
    }
}

//output_text
void Statement::output_text(std::ostream &dst) {
    if(cur_statement!=NULL){
        cur_statement->output_text(dst);
    }
}
