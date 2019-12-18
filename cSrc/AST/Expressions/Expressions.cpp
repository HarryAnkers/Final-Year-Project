#include "Expressions.hpp"
#include "Op.hpp"
#include "Primatives.hpp"

Expression::Expression(State &state){
    int rand_N = rand() % 100;
    if (rand_N < 40){
        exp = new Unary_Op(state);
    } else if (rand_N < 50){
        exp = new Dual_Op(state);
    } else  if(rand_N < 60){
        exp = new Variable(false,"INT",state);
    } else  if(rand_N < 70){
        exp = new Number(state);
    }
}

void Expression::output_text(std::ostream &dst){
    dst<<"(";
    if(exp!= NULL){
        exp->output_text(dst);
    } else {
        dst<<"0";
    }
    dst<<")";
}