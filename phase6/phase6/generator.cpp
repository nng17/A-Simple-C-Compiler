/*
 * File:	generator.cpp
 *
 * Description:	This file contains the public and member function
 *		definitions for the code generator for Simple C.
 *
 *		Extra functionality:
 *		- putting all the global declarations at the end
 */

# include <sstream>
# include <iostream>
# include <vector>
# include "generator.h"
# include "machine.h"

using namespace std;

struct Label
{
	static unsigned counter;
	unsigned number;
	Label() {
		number = counter++;
	}	
};

unsigned Label::counter = 0;

ostream &operator << (ostream &ostr, const Label &lbl)
{
	return ostr << ".L" << lbl.number;
}

typedef std::vector<string> stringLabels;

static unsigned maxargs;
int temp_offset;
Label *retLbl;
stringLabels strlbl;


/*
 * Function:	operator <<
 *
 * Description:	Convenience function for writing the operand of an
 *		expression.
 */

ostream &operator <<(ostream &ostr, Expression *expr)
{
    return ostr << expr->_operand;
}

string getTemp()
{
	stringstream ss;
	temp_offset -= 4;
	ss << temp_offset << "(%ebp)";
	return ss.str();
}

/*
 * Function:	Identifier::generate
 *
 * Description:	Generate code for an identifier.  Since there is really no
 *		code to generate, we simply update our operand.
 */


void Identifier::generate()
{
    stringstream ss;


    if (_symbol->_offset != 0)
	ss << _symbol->_offset << "(%ebp)";
    else
	ss << global_prefix << _symbol->name();

    _operand = ss.str();
}


/*
 * Function:	Number::generate
 *
 * Description:	Generate code for a number.  Since there is really no code
 *		to generate, we simply update our operand.
 */

void Number::generate()
{
    stringstream ss;


    ss << "$" << _value;
    _operand = ss.str();
}


# if STACK_ALIGNMENT == 4

/*
 * Function:	Call::generate
 *
 * Description:	Generate code for a function call expression, in which each
 *		argument is simply a variable or an integer literal.
 */

void Call::generate()
{
    unsigned numBytes = 0;
	_operand = getTemp();


    for (int i = _args.size() - 1; i >= 0; i --) {
	_args[i]->generate();
	cout << "\tpushl\t" << _args[i] << endl;
	numBytes += _args[i]->type().size();
    }

    cout << "\tcall\t" << global_prefix << _id->name() << endl;

    if (numBytes > 0)
	{
		cout << "\taddl\t$" << numBytes << ", %esp" << endl;
	}

	cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

# else

/*
 * If the stack has to be aligned to a certain size before a function call
 * then we cannot push the arguments in the order we see them.  If we had
 * nested function calls, we cannot guarantee that the stack would be
 * aligned.
 *
 * Instead, we must know the maximum number of arguments so we can compute
 * the size of the frame.  Again, we cannot just move the arguments onto
 * the stack as we see them because of nested function calls.  Rather, we
 * have to generate code for all arguments first and then move the results
 * onto the stack.  This will likely cause a lot of spills.
 *
 * For now, since each argument is going to be either a number of in
 * memory, we just load it into %eax and then move %eax onto the stack.
 */

void Call::generate()
{
	_operand = getTemp();
	
    if (_args.size() > maxargs)
	maxargs = _args.size();

    for (int i = _args.size() - 1; i >= 0; i --) {
	_args[i]->generate();
	cout << "\tmovl\t" << _args[i] << ", %eax" << endl;
	cout << "\tmovl\t%eax, " << i * SIZEOF_ARG << "(%esp)" << endl;
    }

    cout << "\tcall\t" << global_prefix << _id->name() << endl;
	cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

# endif


/*
 * Function:	Assignment::generate
 *
 * Description:	Generate code for this assignment statement, in which the
 *		right-hand side is an integer literal and the left-hand
 *		side is an integer scalar variable.  Actually, the way
 *		we've written things, the right-side can be a variable too.
 */

void Assignment::generate()
{
	bool indirect;
    _left->generate(indirect);
    _right->generate();

	//char or int
	if(!indirect)
	{
		if(_left->type().size() == 1)
		{
			cout << "\tmovl\t" << _right << ", %eax" << endl;
			cout << "\tmovb\t" << "%al, " << _left << endl;

		}
		if(_left->type().size() == 4)
		{
			cout << "\tmovl\t" << _right << ", %eax" << endl;
			cout << "\tmovl\t" << "%eax, " << _left << endl;
		}
	}
	//char* or int*
	else
	{
		if(_left->type().size() == 1)
		{
			cout << "\tmovl\t" << _right << ", %eax" << endl;
			cout << "\tmovl\t" << _left << ", %ecx" << endl;
			cout << "\tmovb\t" << "%al, (%ecx)" << endl;
		}
		if(_left->type().size() == 4)
		{
			cout << "\tmovl\t" << _right << ", %eax" << endl;
			cout << "\tmovl\t" << _left << ", %ecx" << endl;
			cout << "\tmovl\t" << "%eax, (%ecx)" << endl;
		}
	}
}


/*
 * Function:	Block::generate
 *
 * Description:	Generate code for this block, which simply means we
 *		generate code for each statement within the block.
 */

void Block::generate()
{
    for (unsigned i = 0; i < _stmts.size(); i ++)
	_stmts[i]->generate();
}


/*
 * Function:	Function::generate
 *
 * Description:	Generate code for this function, which entails allocating
 *		space for local variables, then emitting our prologue, the
 *		body of the function, and the epilogue.
 */

void Function::generate()
{
    int offset = 0;
	retLbl = new Label();

    /* Generate our prologue. */

    allocate(offset);
    cout << global_prefix << _id->name() << ":" << endl;
    cout << "\tpushl\t%ebp" << endl;
    cout << "\tmovl\t%esp, %ebp" << endl;
    cout << "\tsubl\t$" << _id->name() << ".size, %esp" << endl;


    /* Generate the body of this function. */

    maxargs = 0;
	temp_offset = offset;
    _body->generate();
	offset = temp_offset;

    offset -= maxargs * SIZEOF_ARG;

    while ((offset - PARAM_OFFSET) % STACK_ALIGNMENT)
	offset --;

	cout << *retLbl << ":" << endl;
    /* Generate our epilogue. */

    cout << "\tmovl\t%ebp, %esp" << endl;
    cout << "\tpopl\t%ebp" << endl;
    cout << "\tret" << endl << endl;

    cout << "\t.globl\t" << global_prefix << _id->name() << endl;
    cout << "\t.set\t" << _id->name() << ".size, " << -offset << endl;

    cout << endl;
}


/*
 * Function:	generateGlobals
 *
 * Description:	Generate code for any global variable declarations.
 */

void generateGlobals(const Symbols &globals)
{
    if (globals.size() > 0)
	cout << "\t.data" << endl;

    for (unsigned i = 0; i < globals.size(); i ++) {
	cout << "\t.comm\t" << global_prefix << globals[i]->name();
	cout << ", " << globals[i]->type().size();
	cout << ", " << globals[i]->type().alignment() << endl;
    }

	//print labels
	for(unsigned j = 0; j < strlbl.size(); j++)
	{
		cout << strlbl[j] << endl;
	}
}

void Expression::generate()
{
	cerr << "oops" << endl;
}

void Expression::generate(bool &indirect)
{
    indirect = false;
    generate();
}

void Not::generate()
{
    _expr->generate();
    _operand = getTemp();
    cerr << "#NOT" << endl;
    cout << "\tmovl\t" << _expr << ", %eax" << endl;
    cout << "\tcmpl\t" << "$0, %eax" << endl;
    cout << "\tsete\t" << "%al" << endl;
    cout << "\tmovzbl\t" << "%al, %eax" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void Negate::generate()
{
    _expr->generate();
    _operand = getTemp();
    cerr << "#NEGATE" << endl;
    cout << "\tmovl\t" << _expr << ", %eax" << endl;
    cout << "\tnegl\t" << "%eax" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void Dereference::generate(bool &indirect)
{
    indirect = true;
    _expr->generate();
	_operand = _expr->_operand;
}

void Dereference::generate()
{
    _expr->generate();
    _operand = getTemp();

	cout << "\tmovl\t" << _expr << ", %eax" << endl;
    if(_type.size() == 1)
    {
        cout << "\tmovsbl\t" << "(%eax), %eax" << endl;
    }
    else
    {
        cout << "\tmovl\t" << "(%eax), %eax" << endl;
    }
    cout << "\tmovl\t" << "%eax, " << this << endl;
}

void Address::generate()
{
    bool indirect;
    _expr->generate(indirect);
    if(indirect)
    {
        _operand = _expr->_operand;
    }
    else
    {
        _operand = getTemp();
        cout << "\tleal\t" << _expr << ", %eax" << endl;
		cout << "\tmovl\t" << "%eax, " << this << endl;
    }
}

void Promote::generate()
{
	_expr->generate();
	_operand = getTemp();
	cout << "\tmovsbl\t" << _expr << ", %eax" << endl;
	cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void Multiply::generate()
{
    _left->generate();
    _right->generate();
    _operand = getTemp();
	cerr << "#MULTIPLY" << endl;
    cout << "\tmovl\t" << _left << ", %eax" << endl;
    cout << "\timull\t" << _right << ", %eax" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void Divide::generate()
{
    _left->generate();
    _right->generate();
    _operand = getTemp();
	cerr << "#DIVIDE" << endl;
    cout << "\tmovl\t" << _left << ", %eax" << endl;
    cout << "\tmovl\t" << _right << ", %ecx" << endl;
    cout << "\tcltd\t" << endl;
    cout << "\tidivl\t" << "%ecx" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void Remainder::generate()
{
    _left->generate();
    _right->generate();
    _operand = getTemp();
	cerr << "#REMAINDER" << endl;
    cout << "\tmovl\t" << _left << ", %eax" << endl;
    cout << "\tmovl\t" << _right << ", %ecx" << endl;
    cout << "\tcltd\t" << endl;
    cout << "\tidivl\t" << "%ecx" << endl;
    cout << "\tmovl\t" << "%edx, " << _operand << endl;
}

void Add::generate()
{
    _left->generate();
    _right->generate();
    _operand = getTemp();
	cerr << "#ADD" << endl;
    cout << "\tmovl\t" << _left << ", %eax" << endl;
    cout << "\taddl\t" << _right << ", %eax" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void Subtract::generate()
{
    _left->generate();
    _right->generate();
    _operand = getTemp();
	cerr << "#SUBTRACT" << endl;
    cout << "\tmovl\t" << _left << ", %eax" << endl;
    cout << "\tsubl\t" << _right << ", %eax" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void LessThan::generate()
{
    _left->generate();
    _right->generate();
    _operand = getTemp();
	cerr << "#LESSTHAN" << endl;
    cout << "\tmovl\t" << _left << ", %eax" << endl;
    cout << "\tcmpl\t" << _right << ", %eax" << endl;
    cout << "\tsetl\t" << "%al" << endl;
    cout << "\tmovzbl\t" << "%al, " << "%eax" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void GreaterThan::generate()
{
    _left->generate();
    _right->generate();
    _operand = getTemp();
	cerr << "#GREATERTHAN" << endl;
    cout << "\tmovl\t" << _left << ", %eax" << endl;
    cout << "\tcmpl\t" << _right << ", %eax" << endl;
    cout << "\tsetg\t" << "%al" << endl;
    cout << "\tmovzbl\t" << "%al, " << "%eax" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void LessOrEqual::generate()
{
    _left->generate();
    _right->generate();
    _operand = getTemp();
	cerr << "#LESSEQUAL" << endl;
    cout << "\tmovl\t" << _left << ", %eax" << endl;
    cout << "\tcmpl\t" << _right << ", %eax" << endl;
    cout << "\tsetle\t" << "%al" << endl;
    cout << "\tmovzbl\t" << "%al, " << "%eax" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void GreaterOrEqual::generate()
{
    _left->generate();
    _right->generate();
    _operand = getTemp();
	cerr << "#GREATEREQUAL" << endl;
    cout << "\tmovl\t" << _left << ", %eax" << endl;
    cout << "\tcmpl\t" << _right << ", %eax" << endl;
    cout << "\tsetge\t" << "%al" << endl;
    cout << "\tmovzbl\t" << "%al, " << "%eax" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void Equal::generate()
{
    _left->generate();
    _right->generate();
    _operand = getTemp();
	cerr << "#EQUAL" << endl;
    cout << "\tmovl\t" << _left << ", %eax" << endl;
    cout << "\tcmpl\t" << _right << ", %eax" << endl;
    cout << "\tsete\t" << "%al" << endl;
    cout << "\tmovzbl\t" << "%al, " << "%eax" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void NotEqual::generate()
{
    _left->generate();
    _right->generate();
    _operand = getTemp();
	cerr << "#NOTEQUAL" << endl;
    cout << "\tmovl\t" << _left << ", %eax" << endl;
    cout << "\tcmpl\t" << _right << ", %eax" << endl;
    cout << "\tsetne\t" << "%al" << endl;
    cout << "\tmovzbl\t" << "%al, " << "%eax" << endl;
    cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void LogicalAnd::generate()
{
	cerr << "#LOGICALAND" << endl;
	_operand = getTemp();

	Label L;

	_left->generate();
	cout << "\tmovl\t" << _left << ", %eax" << endl;
	cout << "\tcmpl\t" << "$0, %eax" << endl;
	cout << "\tje\t" << L << endl;

	_right->generate();
	cout << "\tmovl\t" << _right << ", %eax" << endl;
	cout << "\tcmpl\t" << "$0, %eax" << endl;

	cout << L << ":" << endl;
	cout << "\tsetne\t" << "%al" << endl;
	cout << "\tmovzbl\t" << "%al, %eax" << endl;
	cout << "\tmovl\t" << "%eax, " << _operand << endl;
}

void LogicalOr::generate()
{
	cerr << "#LOGICALOR" << endl;
	_operand = getTemp();

	Label L;

	_left->generate();
	cout << "\tmovl\t" << _left << ", %eax" << endl;
	cout << "\tcmpl\t" << "$0, %eax" << endl;
	cout << "\tjne\t" << L << endl;

	_right->generate();
	cout << "\tmovl\t" << _right << ", %eax" << endl;
	cout << "\tcmpl\t" << "$0, %eax" << endl;

	cout << L << ":" << endl;
	cout << "\tsetne\t" << "%al" << endl;
	cout << "\tmovzbl\t" << "%al, %eax" << endl;
	cout << "\tmovl\t" << "%eax, " << _operand << endl;
}


void Return::generate()
{
	_expr->generate();
	cerr << "#RETURN" << endl;
	cout << "\tmovl\t" << _expr << ", %eax" << endl;
	cout << "\tjmp\t" << *retLbl << endl;
}

void String::generate()
{
	stringstream ss;
	Label lbl;
	ss << lbl;
	_operand = ss.str();

	ss << ":\t.asciz\t" << _value;
	strlbl.push_back(ss.str());
}

void While::generate()
{
	Label EXIT;
	Label LOOP;

	cerr << "#WHILE" << endl;
	cout << LOOP << ":" << endl;
	_expr->generate();
	cout << "\tmovl\t" << _expr << ", %eax" << endl;
	cout << "\tcmpl\t" << "$0, %eax" << endl;
	cout << "\tje\t" << EXIT << endl;

	_stmt->generate();
	cout << "\tjmp\t" << LOOP << endl;

	cout << EXIT << ":" << endl;
}

void For::generate()
{
	Label LOOP;
	Label EXIT;
	cerr << "#FOR" << endl;

	_init->generate();
	cout << LOOP << ":" << endl;
	_expr->generate();
	//_incr->generate();
	cout << "\tmovl\t" << _expr << ", %eax" << endl;
	cout << "\tcmpl\t" << "$0, %eax" << endl;
	cout << "\tje\t" << EXIT << endl;

	_stmt->generate();
	_incr->generate();
	cout << "\tjmp\t" << LOOP << endl;
	cout << EXIT << ":" << endl;
}

void If::generate()
{
	Label SKIP;
	Label EXIT;

	cerr << "#IFTHENELSE" << endl;

	_expr->generate();
	cout << "\tmovl\t" << _expr << ", %eax" << endl;
	cout << "\tcmpl\t" << "$0, %eax" << endl;
	cout << "\tje\t" << SKIP << endl;

	_thenStmt->generate();
	cout << "\tjmp\t" << EXIT << endl;
	cout << SKIP << ":" << endl;

	if(_elseStmt != NULL)
	{
		_elseStmt->generate();
	}

	cout << EXIT << ":" << endl;
}
