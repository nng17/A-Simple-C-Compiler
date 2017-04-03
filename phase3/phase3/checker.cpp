#include <cstdlib>
#include <iostream>
#include "lexer.h"
#include "tokens.h"
#include "checker.h"
#include "Type.h"
#include "Symbol.h"
#include "Scope.h"

using namespace std;

Scope *currentScope = NULL;
Scope *globalScope = NULL;

static string conflicting = "conflicting types for '%s'";
static string redefinition = "redefinition of '%s'";
static string redeclaration = "redeclaration of '%s'";
static string undeclared = "'%s' undeclared";
static string typevoid = "'%s' has type void";


void openScope() {
    //cout << "Opening Scope" << endl;
    currentScope = new Scope(currentScope);

    if(globalScope == NULL)
        globalScope = currentScope;

    //cout << "Scope opened" << endl;
}

void closeScope() {
    //cout << "Closing Scope" << endl;
    Scope *scope = currentScope;
    if(currentScope != NULL)
    {
        currentScope = currentScope->enclosing();
        delete scope;
    }
}

void declareFunction(string name, Type type, bool defined)
{
    //cout << "In declare function" << endl;
    Symbol *symbol = globalScope->find(name);
    if(symbol == NULL)
    {
        //cout << "declaring new function with name: " << name << endl;
        symbol = new Symbol(name, type);
        globalScope->newSymbols(symbol);
        symbol->setDef(defined);
    }
    else if(type != symbol->t())
    {
        report(conflicting, name);
        delete type.param();
    }
    //cout << "Function declared with name: " << name << endl;
}


void defineFunction(string name, Type type)
{
    //cout << "in defineFunction " << endl;
    Symbol *symbol = globalScope->find(name);
    if(symbol != NULL)
    {
        /* cout << "found existing function with name :" << name << endl;
        cout << "checking for redef and conflicting type" << endl;
        cout << "current value of isDef: " << symbol->isDef() << endl; */
        if(type != symbol->t())
        {
            report(conflicting, name);
        }
        else if(symbol->isDef() == true)
        {
            report(redefinition, name);
        }
        else
        {
            //cout << "defining function and setting isDef to true" << endl;
            symbol->setDef(true);
        }
    }
    else
    {
        //cout << "new function, calling declare" << endl;
        declareFunction(name, type, true);
    }
}

void declareVar(string name, Type type)
{
    Symbol* symbol = currentScope->find(name);
    if(symbol == NULL)
    {
        symbol = new Symbol(name, type);
        if(isVoid(type))
            report(typevoid, name);

        currentScope -> newSymbols(symbol);
    }
    else if(currentScope != globalScope)
    {
        report(redeclaration, name);
    }
    if(type != symbol->t())
    {
        report(conflicting, name);
    }
}

void useSymbol(string name, Type type)
{
    Symbol *symbol = currentScope->find(name);
    if(symbol == NULL)
    {
        symbol = currentScope->lookup(name);
        if(symbol == NULL)
        {
            if(type.kind() == FUNCTION)
                declareFunction(name, type);
            else
            {
                report(undeclared, name);
            }
        }
    }
}

bool isVoid(Type type) {
    if(type.specifier() == VOID && type.indirection() == 0)
        return true;
    return false;
}
