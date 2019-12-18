#include "Op.hpp"

Unary_Op::Unary_Op(State &state){
    int rand_N = rand() % 100;
    if (rand_N < 45){
        operand = "-";
    } else if (rand_N < 90){
        operand = "+";
    } else if (rand_N < 100){
        operand = "^";
    }
    exp = new Expression(state);
}

void Unary_Op::output_text(std::ostream &dst){
    dst << operand;
    exp->output_text(dst);
}

Dual_Op::Dual_Op(State &state){
    int rand_N = rand() % 100;
    if (rand_N < 20){
        operand = "+";
    } else if (rand_N < 40){
        operand = "-";
    } else if (rand_N < 60){
        operand = "/";
    } else if (rand_N < 80){
        operand = "*";
    }
    
    else if (rand_N < 85){
        operand = "==";
    } else if (rand_N < 90){
        operand = "||";
    } else if (rand_N < 95){
        operand = "&&";
    } else if (rand_N < 100){
        operand = "!=";
    }
    exp_1 = new Expression(state);
    exp_2 = new Expression(state);
}

void Dual_Op::output_text(std::ostream &dst) {
    exp_1 -> output_text(dst);
    dst << operand;
    exp_2 ->  output_text(dst);
}