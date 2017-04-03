#ifndef TYPE_H
#define TYPE_H
#include <vector>
#include <string>
#include <iostream>
#include "tokens.h"

enum Kind {
    SCALAR, ARRAY, FUNCTION
};

typedef std::vector<class Type> Parameters;

class Type {
    Kind _kind;
    int _specifier;
    unsigned _indirection;
public:
    int _length;
    Parameters* _param;
    Type(Kind kind, int specifier = VOID, unsigned indirection = 0, Parameters* param = NULL, int length = 0);
    Kind kind() const;
    int specifier() const;
    unsigned indirection() const;
    Parameters* param() const;
    int length() const;
    bool operator ==(const Type &that) const;
    bool operator !=(const Type &that) const;
    bool checkEqual(Parameters *param1, Parameters *param2) const;
};

std::ostream & operator << (std::ostream &ostr, const Type &type);

#endif /* TYPE_H */
