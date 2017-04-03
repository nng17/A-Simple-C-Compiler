# ifndef CHECKER_H
# define CHECKER_H
# include "Scope.h"

using namespace std;

void openScope();
void closeScope();
void declareFunction(string name, Type type, bool defined = false);
void defineFunction(string name, Type type);
void declareVar(string name, Type type);
void useSymbol(string name, Type type);
bool isVoid(Type type);

# endif /* CHECKER_H */
