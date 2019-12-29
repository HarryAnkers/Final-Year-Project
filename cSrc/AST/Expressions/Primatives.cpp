#include "Primatives.hpp"

#include <string>
#include <map>

Variable::Variable(bool new_flag, std::string type, State &state) {
    if (new_flag) {
        int curVarId = state.varId;
        state.varId++;
        var_name = "variable_" + std::to_string(curVarId);
        state.varTypeMap[var_name] = "int";
    } else{
        auto it = state.varTypeMap.begin();
        std::advance(it, rand() % state.varTypeMap.size());
        std::string random_key = it->first;
    }
}

//output_text
void Variable::output_text(std::ostream &dst) {
    dst << var_name;
}

Number::Number(State &state) {
    float r = (((float) rand()) / (float) RAND_MAX) * 200000;
    constant_val =  -100000 + r;
}

//output_text
void Number::output_text(std::ostream &dst) {
    dst << std::to_string(constant_val);
}
