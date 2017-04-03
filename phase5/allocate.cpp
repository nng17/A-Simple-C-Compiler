#include "Tree.h"

void Function::allocate(int &offset)
{
    int size = _id->type().parameters()->size();
    int paramOffset = offset + 4;

    for(unsigned i = 0; i < _body->declarations()->symbols().size(); i++)
    {
        if(i < size)
        {
            paramOffset +=4;
            _body->declarations()->symbols()[i]->offset = paramOffset;
        }
        else
        {
            offset -= 4;
            _body->declarations()->symbols()[i]->offset = offset;
        }
    }
}
