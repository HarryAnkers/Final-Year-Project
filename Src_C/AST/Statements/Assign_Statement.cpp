#include "./Assign_Statement.hpp"

#include "../Expressions/Primatives.hpp"
#include <string>

AssignStatement::AssignStatement(State &state){
    std::string type = "blank";
    var_id = new Variable(true,type,state);
    // expression = new StatementList();
}

//output_text
void AssignStatement::output_text(std::ostream &dst) {
    var_id->output_text(dst);
    dst << "=";
    if(expression != NULL){
        expression->output_text(dst);
    }
    dst << std::endl;
}