#include "Statement_List.hpp"

#include "../ASTNode.hpp"
#include "Statement.hpp"
#include "Statement_List.hpp"

// StatementList(State &state) {
StatementList::StatementList(State &state) {
    cur_statement = new Statement(state);
    if (state.depth<7){
        int rand_N = rand() % 100;
        if (rand_N < 60){
            nextStatement = new StatementList(state);
        }
    }
}

//output_text
void StatementList::output_text(std::ostream &dst) {
    cur_statement->output_text(dst);
    if(nextStatement!=NULL){
        nextStatement->output_text(dst);
    }
}