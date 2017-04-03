#include "Tree.h"

using namespace std;

void Function::generate()
{
    int offset = 0;
    allocate(offset);
    //Do function prologue
    string function = id.name();
    cout << "function: " << function << endl;
    cout << 
    // - body -> generate()
    //Do function epilogue
}

void Block::generate()
{

}

void Call::generate()
{

}

void Identifier::generate()
{

}

void Number::generate()
{

}

void Assignment::generate()
{

}
