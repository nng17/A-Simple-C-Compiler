
#ifndef SCOPE_H
#define SCOPE_H
#include "Symbol.h"
#include <vector>

typedef std::vector <Symbol *> Symbols;

using namespace std;

class Scope {
    Symbols _symbols;
    Scope* _enclosing;
public:
    Scope(Scope *enclosing);
    Symbols symbols() const;
    Scope* enclosing() const;
    void newSymbols(Symbol *symbol);
    Symbol* find(string name);
    Symbol* lookup(string name);
};

#endif /* SCOPE_H */
