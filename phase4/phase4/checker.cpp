/*
 * File:	checker.cpp
 *
 * Description:	This file contains the public and private function and
 *		variable definitions for the semantic checker for Simple C.
 *
 *		If a symbol is redeclared, the existing declaration is
 *		retained and the redeclaration discarded.  This behavior
 *		seems to be consistent with GCC, and who are we to argue
 *		with GCC?
 *
 *		Extra functionality:
 *		- inserting an undeclared symbol with the error type
 */

# include <iostream>
# include "lexer.h"
# include "checker.h"
# include "nullptr.h"
# include "tokens.h"
# include "Symbol.h"
# include "Scope.h"
# include "Type.h"

# define FUNCDEFN 1


using namespace std;

static Scope *outermost, *toplevel;
static const Type error;

static string redefined = "redefinition of '%s'";
static string redeclared = "redeclaration of '%s'";
static string conflicting = "conflicting types for '%s'";
static string undeclared = "'%s' undeclared";
static string void_object = "'%s' has type void";
static string invalid_return = "invalid return type";
static string invalid_expression = "invalid type for test expression";
static string lvalue_required = "lvalue required in expression";
static string invalid_binary = "invalid operands to binary %s";
static string invalid_unary = "invalid operand to unary %s";
static string not_function = "called object is not a function";
static string invalid_args = "invalid arguments to called function";

/*
 * Function:	checkIfVoidObject
 *
 * Description:	Check if TYPE is a proper use of the void type (if the
 *		specifier is void, then the indirection must be nonzero or
 *		the kind must be a function).  If the type is proper, it is
 *		returned.  Otherwise, the error type is returned.
 */

static Type checkIfVoidObject(const string name, const Type &type)
{
    if (type.specifier() != VOID)
	return type;

    if (type.indirection() == 0 && !type.isFunction()) {
	report(void_object, name);
	return error;
    }

    return type;
}


/*
 * Function:	openScope
 *
 * Description:	Create a scope and make it the new top-level scope.
 */

Scope *openScope()
{
    toplevel = new Scope(toplevel);

    if (outermost == nullptr)
	outermost = toplevel;

    return toplevel;
}


/*
 * Function:	closeScope
 *
 * Description:	Remove the top-level scope, and make its enclosing scope
 *		the new top-level scope.
 */

Scope *closeScope()
{
    Scope *old = toplevel;
    toplevel = toplevel->enclosing();
    return old;
}


/*
 * Function:	defineFunction
 *
 * Description:	Define a function with the specified NAME and TYPE.  A
 *		function is always defined in the outermost scope.
 */

Symbol *defineFunction(const string &name, const Type &type)
{
    Symbol *symbol = declareFunction(name, type);

    if (symbol->_attributes & FUNCDEFN)
	report(redefined, name);

    symbol->_attributes = FUNCDEFN;
    return symbol;
}


/*
 * Function:	declareFunction
 *
 * Description:	Declare a function with the specified NAME and TYPE.  A
 *		function is always declared in the outermost scope.  Any
 *		redeclaration is discarded.
 */

Symbol *declareFunction(const string &name, const Type &type)
{
    cout << name << ": " << type << endl;
    Symbol *symbol = outermost->find(name);

    if (symbol == nullptr) {
	symbol = new Symbol(name, type);
	outermost->insert(symbol);

    } else if (type != symbol->type()) {
	report(conflicting, name);
	delete type.parameters();

    } else
	delete type.parameters();

    return symbol;
}


/*
 * Function:	declareVariable
 *
 * Description:	Declare a variable with the specified NAME and TYPE.  Any
 *		redeclaration is discarded.
 */

Symbol *declareVariable(const string &name, const Type &type)
{
    cout << name << ": " << type << endl;
    Symbol *symbol = toplevel->find(name);

    if (symbol == nullptr) {
	symbol = new Symbol(name, checkIfVoidObject(name, type));
	toplevel->insert(symbol);

    } else if (outermost != toplevel)
	report(redeclared, name);

    else if (type != symbol->type())
	report(conflicting, name);

    return symbol;
}


/*
 * Function:	checkIdentifier
 *
 * Description:	Check if NAME is declared.  If it is undeclared, then
 *		declare it as having the error type in order to eliminate
 *		future error messages.
 */

Symbol *checkIdentifier(const string &name)
{
    Symbol *symbol = toplevel->lookup(name);

    if (symbol == nullptr) {
	report(undeclared, name);
	symbol = new Symbol(name, error);
	toplevel->insert(symbol);
    }

    return symbol;
}


/*
 * Function:	checkFunction
 *
 * Description:	Check if NAME is a previously declared function.  If it is
 *		undeclared, then implicitly declare it.
 */

Symbol *checkFunction(const string &name)
{
    cout << "calling lookup on: " << name << endl;
    Symbol *symbol = toplevel->lookup(name);

    if (symbol == nullptr)
	symbol = declareFunction(name, Type(INT, 0, nullptr));

    return symbol;
}


Type checkLogicalOR(const Type &left, const Type &right) {
    //cout << "checkLogicalOR" << endl;
    Type temp1 = left.promote();
    Type temp2 = right.promote();
    if(temp1 == error || temp2 == error)
        return error;

    if(temp1.isPredicate() && temp2.isPredicate()) {
        return Type(INT);
    }
    report(invalid_binary, "||");
    return Type();
}

Type checkLogicalAND(const Type &left, const Type &right) {
    //cout << "checkLogicalAND" << endl;
    Type temp1 = left.promote();
    Type temp2 = right.promote();

    if(temp1 == error || temp2 == error)
        return error;

    if(temp1.isPredicate() && temp2.isPredicate()) {
        return Type(INT);
    }
    report(invalid_binary, "&&");
    return Type();
}

Type checkEquality(const Type &left, const Type &right) {
    //cout << "checkEquality" << endl;
    Type temp1 = left.promote();
    Type temp2 = right.promote();

    if(temp1 == error || temp2 == error)
        return error;

    if(temp1.isCompatible(temp2)) {
        return Type(INT);
    }
    report(invalid_binary, "=");
    return Type();
}

Type checkRelational(const Type &left, const Type &right, const string &operand) {
    //cout << "checkRelational" << endl;
    Type temp1 = left.promote();
    Type temp2 = right.promote();

    if(temp1 == error || temp2 == error)
        return error;

    if(temp1.isPredicate() && temp2.isPredicate() && temp1 == temp2)
    {
        return Type(INT);
    }
    report(invalid_binary, operand);
    return Type();
}

Type checkAdditive(const Type &left, const Type &right) {
    //cout << "checkAdditive" << endl;
    Type temp1 = left.promote();
    Type temp2 = right.promote();

    if(temp1 == error || temp2 == error)
        return error;

    if(temp1 == Type(INT) && temp2 == Type(INT))
        return Type(INT);

    else if((!(temp1.specifier() == VOID && temp1.isScalar() && temp1.indirection() == 1)) && temp1.isPointer())
    {
        if(temp2 == Type(INT))
        {
            return Type(temp1.specifier(), temp1.indirection());
        }
    }

    else if((!(temp2.specifier() == VOID && temp2.isScalar() && temp2.indirection() == 1)) && temp2.isPointer())
    {
        if(temp1 == Type(INT))
        {
            return Type(temp2.specifier(), temp2.indirection());
        }
    }

    report(invalid_binary, "+");
    return Type();
}

Type checkSubtract(const Type &left, const Type &right) {
    //cout << "checkSubtract" << endl;
    Type temp1 = left.promote();
    Type temp2 = right.promote();

    if(temp1 == error || temp2 == error)
        return error;

    if(temp1 == Type(INT) && temp2 == Type(INT))
        return Type(INT);

    else if((!(temp1.specifier() == VOID && temp1.isScalar() && temp1.indirection() == 1)) && temp1.isPointer())
    {
        if(temp2 == Type(INT))
        {
            return Type(temp1.specifier(), temp1.indirection());
        }
    }

    else if((!(temp1.specifier() == VOID && temp1.isScalar() && temp1.indirection() == 1)) && temp1.isPointer())
    {
        if(temp1 == temp2)
            return Type(INT);
    }

    report(invalid_binary, "-");
    return Type();
}

Type checkMultiply(const Type &left, const Type &right) {
    //cout << "checkMultiply" << endl;
    Type temp1 = left.promote();
    Type temp2 = right.promote();

    if(temp1 == error || temp2 == error)
        return error;

    if(temp1 == Type(INT) && temp2 == Type(INT))
        return Type(INT);

    report(invalid_binary, "*");
    return Type();
}

Type checkDivide(const Type &left, const Type &right) {
    //cout << "checkDivide" << endl;
    Type temp1 = left.promote();
    Type temp2 = right.promote();

    if(temp1 == error || temp2 == error)
        return error;

    if(temp1 == Type(INT) && temp2 == Type(INT))
        return Type(INT);

    report(invalid_binary, "/");
    return Type();
}

Type checkMod(const Type &left, const Type &right) {
    //cout << "checkMod" << endl;
    Type temp1 = left.promote();
    Type temp2 = right.promote();

    if(temp1 == error || temp2 == error)
        return error;

    if(temp1 == Type(INT) && temp2 == Type(INT))
        return Type(INT);

    report(invalid_binary, "%");
    return Type();
}

Type checkStar(const Type &right) {
    //cout << "checkStar" << endl;
    Type temp1 = right.promote();
    if((!(temp1.specifier() == VOID && temp1.isScalar() && temp1.indirection() == 1)) && temp1.isPointer())
        return Type(temp1.specifier(), temp1.indirection() - 1);

    report(invalid_unary, "*");
    return Type();
}

Type checkAddr(const Type &right, bool lvalue) {
    //cout << "checkAddr" << endl;
    //cout << "lvalue inside checkAddr: " << lvalue << endl;

    if(right == error)
        return error;

    if(lvalue)
    {
        return(Type(right.specifier(), right.indirection() + 1));
    }
    report(lvalue_required);
    return Type();
}

Type checkNot(const Type &right)
{
    //cout << "checkNot" << endl;
    if(right == error)
        return error;

    if(right.isPredicate())
    {
        return Type(INT);
    }

    report(invalid_unary, "!");
    return Type();
}

Type checkNeg(const Type &right)
{
    //cout << "checkNeg" << endl;
    if(right == error)
        return error;
    if(right == Type(INT))
        return Type(INT);

    report(invalid_unary, "-");
    return Type();
}

Type checkSizeof(const Type &right)
{
    //cout << "checkSizeof" << endl;
    if(right == error)
        return error;
    if(right.isPredicate())
        return Type(INT);

    report(invalid_unary, "sizeof");
    return Type();
}

Type checkPostfix(const Type &left, const Type &right) {
    //cout << "checkPostFix" << endl;
    Type temp1 = left.promote();
    Type temp2 = right.promote();

    if(temp1 == error || right == error)
        return error;
    if((!(temp1.specifier() == VOID && temp1.isScalar() && temp1.indirection() == 0)) && temp1.isPointer())
    {
        if(temp2 == Type(INT))
        {
            return Type(temp1.specifier(), temp1.indirection() - 1);
        }
    }
    report(invalid_binary, "[]");
    return Type();
}

Type checkFunctionCall(const Type &funcType, const Parameters* params) {
    //cout << "checkFunctionCall" << endl;
    int i, j;

    if(funcType == error)
        return error;

    if(!funcType.isFunction())
    {
        report(not_function);
        return Type();
    }

    //cout << "check if argument are predicates" << endl;
    for(i = 0; i < params->size(); i++)
    {
        //cout << "inside for loop" << endl;
        if(!params->at(i).isPredicate())
        {
            report(invalid_args);
            return Type();
        }
    }
    //cout << "outside for loop" << endl;
    //cout << "check if compatible types" << endl;
    Parameters* p = funcType.parameters();
    if(p != NULL)
    {
        if(p->size() == params->size())
        {
            cout << "inside for loop for compatible types" << endl;
            for(j = 0; j < p->size(); j++)
            {
                if(!p->at(j).isCompatible(params->at(j)))
                {
                    report(invalid_args);
                    return Type();
                }
            }
            return Type(funcType.specifier(), funcType.indirection());
        }
    }
    else
    {
        return Type(funcType.specifier(), funcType.indirection());
    }
    cout << "outside of everything" << endl;
    report(invalid_args);
    return Type();
}

Type checkAssignment(const Type &left, const Type &right, bool &lvalue)
{
    //cout << "inside checkAssignment" << endl;
    //cout << "lvalue inside checkAssignment: " << lvalue << endl;
    if(left == error || right == error)
        return error;

    if(!lvalue)
    {
        report(lvalue_required);
        return Type();
    }

    if(left.isCompatible(right))
        return left;

    report(invalid_binary, "=");
    return Type();
}

/* used for return */
Type checkReturn(const Type &expr, const Type &funcType)
{
    if(expr == error)
        return error;

    Type returnFunction = checkFunctionCall(funcType, funcType.parameters());

    if(expr.isCompatible(returnFunction))
    {
        return expr;
    }

    report(invalid_return);
    return Type();
}

/* use for for, while, if, else */
Type checkConditions(const Type &expr)
{
    if(expr == error)
    {
        return error;
    }

    if(expr.isPredicate())
    {
        return expr;
    }

    report(invalid_expression);
    return Type();
}
