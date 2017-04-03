#include "Scope.h"

Scope::Scope(Scope* enclosing)
    :_enclosing(enclosing)
{
}

Symbols Scope::symbols() const
{
    return _symbols;
}

Scope* Scope::enclosing() const
{
    return _enclosing;
}

void Scope::newSymbols(Symbol *symbol)
{
    _symbols.push_back(symbol);
}

Symbol* Scope::find(string name)
{
    int i;
    for(i = 0; i < _symbols.size(); i++)
    {
        if(_symbols[i]->name() == name)
            return _symbols[i];
    }
    return NULL;
}

Symbol* Scope::lookup(string name)
{
    Scope* old = _enclosing;
    while(old != NULL)
    {
        if(old->find(name) != NULL)
        {
            return old->find(name);
        }
        else
        {
            old = old->enclosing();
        }
    }
    return NULL;
}
