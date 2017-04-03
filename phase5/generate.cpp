# include "Tree.h"
# include <iostream>
# include <vector>
# include <cstdlib>

using namespace std;

void Function::generate()
{
    int offset = 0;
    allocate(offset);
    cout << "\t.globl\t" << _id->name() << endl;
    cout << "\t.set\t" << _id->name() << ".size, " << abs(offset) << endl;
    cout << endl;

    cout << _id->name() << ":" << endl;

    //Prologue
    cout << "\tpushl\t%ebp" << endl;
    cout << "\tmovl\t%esp, %ebp" << endl;
    cout << "\tsubl\t$" << _id->name() <<".size, %esp" << endl;

    //Generate the body
    _body->generate();

    //Epilogue
    cout << "\tmovl\t%ebp, %esp" << endl;
    cout << "\tpopl\t%ebp" << endl;
    cout << "\tret" << endl;
    cout << endl;
}

void Block::generate()
{
    unsigned i;
    for (i = 0; i < _stmts.size(); i++)
	   _stmts[i]->generate();
}

void Identifier::generate()
{
    if(_symbol->offset() == 0)
        cout << _symbol->name();
    else
        cout << _symbol->offset() << "(%ebp)";
}

void Number::generate()
{
    cout << "$" << _value;
}

void Assignment::generate()
{
    cout << "\tmovl\t";
    _right->generate();
    cout << ", %eax" << endl;
    cout << "\tmovl\t%eax";
    cout << ", ";
    _left->generate();
    cout << endl;
}

void Call::generate()
{
    int i;
    for (i = _args.size() - 1; i >= 0; i--) {
    	cout << "\tpushl\t";
    	_args[i]->generate();
    	cout << endl;
    }

    cout << "\tcall\t" << _id->name() << endl;
    cout << "\taddl\t";
    cout << "$" << 4 * _args.size();
    cout << ", %esp" << endl;
}
