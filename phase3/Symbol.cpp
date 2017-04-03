#include "Symbol.h"

using namespace std;

Symbol::Symbol(string name, Type t)
    :_name(name), _t(t)
{
}

string Symbol::name() const
{
    return _name;
}

Type Symbol::t() const
{
    return _t;
}

bool Symbol::isDef()
{
    return _isDef;
}

void Symbol::setDef(bool newBool)
{
    _isDef = newBool;
}

std::ostream & operator << (std::ostream &ostr, const Symbol &symbol)
{
    ostr << "name: " << symbol.name() << " with type: " << symbol.t() << endl;
    return ostr;
}
