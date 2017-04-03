#ifndef SYMBOL_H
#define SYMBOL_H
#include "Type.h"
#include <string>

using namespace std;

class Symbol {
    string _name;
    Type _t;
public:
    bool _isDef;
    Symbol(string name, Type t);
    string name() const;
    Type t() const;
    bool isDef();
    void setDef(bool newBool);
};

std::ostream & operator << (std::ostream &ostr, const Symbol &symbol);
#endif /* SYMBOL_H */
