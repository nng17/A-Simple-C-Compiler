# include "Type.h"
# include "tokens.h"

using namespace std;

//constructor with parameters
Type::Type(Kind kind, int specifier, unsigned indirection, Parameters *param, int length)
    :_kind(kind), _specifier(specifier), _indirection(indirection), _param(param), _length(length)
{

}

Kind Type::kind() const
{
    return _kind;
}

int Type::specifier() const
{
    return _specifier;
}

unsigned Type::indirection() const
{
    return _indirection;
}

int Type::length() const
{
    return _length;
}

Parameters* Type::param() const
{
    return _param;
}

bool Type::operator != (const Type &that) const
{
    return ! (*this == that);
}

bool Type::operator == (const Type &that) const
{
    if(_kind != that._kind)
        return false;
    if(_specifier != that._specifier)
        return false;
    if(_indirection != that._indirection)
        return false;
    if(_kind == ARRAY)
    {
        if(_length != that._length)
            return false;
    }
    checkEqual(_param, that._param);

    return true;
}

bool Type::checkEqual(Parameters *param1, Parameters *param2) const
{
    int i;
    if(param1 == param2)
    {
        if(param1 == NULL || param2 == NULL)
            return false;
        return true;
    }
    if(param1->size() != param2->size())
        return false;
    for(i = 0; i < param1->size(); i++)
    {
        if(param1->at(i) != param2->at(i))
            return false;
    }
    return true;
}

std::ostream & operator << (std::ostream &ostr, const Type &type)
{
    ostr << "kind: " << type.kind() << " specifier: " << type.specifier() << " indirection: " << type.indirection() << endl;
    return ostr;
}
