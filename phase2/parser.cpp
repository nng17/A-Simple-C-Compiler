/* Nathan Ng
 * COEN 175
 * phase 2
 * parser.cpp
 */

#include "parser.h"
#include "lexer.cpp"

using namespace std;

/* common errors, int x works but int x, y doesnt. 
 * int x[10] and int x[10], y[10],
 * pointers don't work
 * **p should work (recursive unary)
 */

int lookahead;
string lexbuf;

int main() {
    lookahead = lexan(lexbuf);
    while(lookahead != DONE)
    {
        funcOrGlb();
    }
    return 0;
}

void funcOrGlb() {
    specifier();
    //cout << "specifier read: int" << endl;
    pointers();
    //cout << "matching id" << endl;
    match(ID);
    //cout << "ID matched" << endl;
    if(lookahead == '(')
    {
        match('(');
        parameters();
        match(')');
        if(lookahead == '{')
        {
            match('{');
            declarations();
            //cout << "checking statement" << lookahead << endl;
            statements();
            //cout << "checked statement" << endl;
            match('}');
        }
        else
        {
            remainingDecls();
        }
    }
    else
    {
        while(lookahead == '[')
        {
            match('[');
            match(NUM);
            match(']');
        }
        remainingDecls();
    }
}

void remainingDecls() {
    while(lookahead != ';')
    {
        match(',');
        global_declarators();
    }
    match(';');
}

void global_declarators() {
    pointers();
    match(ID);
    if(lookahead == '(')
    {
        match('(');
        parameters();
        match(')');
    }
    if(lookahead == '[')
    {
        match('[');
        match(NUM);
        match(']');
    }
}

void pointers() {
    if(lookahead == '*')
    {
        match('*');
        pointers();
        //cout << "pointers" << endl;
    }
}

void specifier() {
    while(lookahead == INT || lookahead == CHAR || lookahead == VOID) {
        match(lookahead);
        //cout << "specifier" << endl;
    }
}

void parameters() {
    parameter();
    while(lookahead == ',')
    {
        match(',');
        parameter();
    }
}

void parameter() {
    specifier();
    //cout << "specifier in parameter read:" << lookahead << endl;
    pointers();
    match(ID);
    //cout << "id matched in parameter" << lookahead << endl;
}

void declarations() {
    while(lookahead == INT || lookahead == CHAR || lookahead == VOID)
    {
        declaration();
    }
}

void declaration() {
    specifier();
    //cout << "specifier in declaration read" << lookahead << endl;
    declarator_list();
    match(';');
    //cout << "matched semicolon" << endl;
    //cout << "declaration" << endl;
}

void declarator_list() {
    declarator();
    if(lookahead == ',')
    {
        match(',');
        declarator_list();
    }
}

void declarator() {
    pointers();
    match(ID);
    //cout << "ID in declarator read" << lookahead << endl;
    if(lookahead == '[')
    {
        match('[');
        match(NUM);
        match(']');
    }
}

void statements() {
   while(lookahead != '}')
   {
       statement();
   }
}

void statement() {
    if(lookahead == '{')
    {
        match('{');
        declarations();
        statements();
        match('}');
    }
    else if(lookahead == RETURN)
    {
        match(RETURN);
        expression();
        match(';');
    }
    else if(lookahead == WHILE)
    {
        match(WHILE);
        match('(');
        expression();
        match(')');
        statement();
    }
    else if(lookahead == FOR)
    {
        match(FOR);
        match('(');
        assignment();
        match(';');
        expression();
        match(';');
        assignment();
        match(')');
        statement();
    }
    else if(lookahead == IF)
    {
        match(IF);
        match('(');
        expression();
        match(')');
        statement();
        if(lookahead == ELSE)
        {
            match(ELSE);
            statement();
        }
    }
    else
    {
        assignment();
        match(';');
    }
}

void assignment() {
    expression();
    while(lookahead == '=')
    {
        match('=');
        expression();
    }
}

void expression() {
    exprAND();
    while(lookahead == OR)
    {
        match(lookahead);
        exprAND();
        cout << "or" << endl;
    }
}

void exprAND() {
    exprEQUAL();
    while(lookahead == AND)
    {
        match(lookahead);
        exprEQUAL();
        cout << "and" << endl;
    }
}

void exprEQUAL() {
    exprCOMPARE();
    while(lookahead == EQUAL || lookahead == NOT_EQUAL)
    {
        int temp = lookahead;
        match(lookahead);
        exprCOMPARE();
        if(temp == EQUAL)
        {
            cout << "eql" << endl;
        }
        else
            cout << "neq" << endl;
    }
}

void exprCOMPARE() {
    exprADDSUB();
    while(lookahead == '<' || lookahead == '>' || lookahead == GREATER_EQUAL || lookahead == LESS_EQUAL)
    {
        int temp = lookahead;
        match(lookahead);
        exprADDSUB();
        if(temp == '>')
        {
            cout << "gtn" << endl;
        }
        if(temp == '<')
        {
            cout << "ltn" << endl;
        }
        if(temp == GREATER_EQUAL)
        {
            cout << "geq" << endl;
        }
        if(temp == LESS_EQUAL)
        {
            cout << "leq" << endl;
        }
    }
}

void exprADDSUB() {
    exprMULTDIV();
    while(lookahead == '+' || lookahead == '-')
    {
        int temp = lookahead;
        match(lookahead);
        exprMULTDIV();
        if(temp == '+')
        {
            cout << "add" << endl;
        }
        if(temp == '-')
            cout << "sub" << endl;
    }
}

void exprMULTDIV() {
    exprUNARY();
    if(lookahead == '*' || lookahead == '/' || lookahead == '%')
    {
        int temp = lookahead;
        match(lookahead);
        exprUNARY();
        if(temp == '*')
        {
            cout << "mul" << endl;
        }
        if(temp == '/')
        {
            cout << "div" << endl;
        }
        if(temp == '%')
        {
            cout << "rem" << endl;
        }
    }
}

void exprUNARY() {
    if(lookahead == '&')
    {
        match(lookahead);
        exprUNARY();
        cout << "addr" << endl;
    }
    else if(lookahead == '*')
    {
        match(lookahead);
        exprUNARY();
        cout << "deref" << endl;
    }
    else if(lookahead == '!')
    {
        match(lookahead);
        exprUNARY();
        cout << "not" << endl;
    }
    else if(lookahead == '-')
    {
        match(lookahead);
        exprUNARY();
        cout << "neg" << endl;
    }
    else if(lookahead == SIZEOF)
    {
        match(lookahead);
        exprUNARY();
        cout << "sizeof" << endl;
    }
    else {
        exprBRACKET();
    }
}

void exprBRACKET() {
    exprOTHER();
    if(lookahead == '[')
    {
        match('[');
        expression();
        match(']');
        cout << "index" << endl;
    }
}

void exprOTHER() {
    if(lookahead == ID)
    {
        match(ID);
        if(lookahead == '(')
        {
            match('(');
            while(lookahead != ')')
                expression_list();
            match(')');
        }
    }
    else if(lookahead == NUM)
    {
        match(NUM);
        //cout << "num returned" << lookahead << endl;
    }
    else if(lookahead == STRING)
    {
        match(STRING);
    }
    else if(lookahead == '(')
    {
        match('(');
        expression();
        match(')');
    }
}

void expression_list() {
    expression();
    if(lookahead == ',')
    {
        match(',');
        expression_list();
    }
}

void match(int t)
{
    if(lookahead == t)
        lookahead = lexan(lexbuf);
}