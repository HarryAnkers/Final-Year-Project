#ifndef STATE_hpp
#define STATE_hpp

#include <iostream>
#include <string>
#include <map>

class State
{
public:
    std::map<std::string, std::string> varTypeMap;
    int varId;
    int depth;
    virtual ~State() {}
    State():
        varId(0), depth(0){}
};


#endif
