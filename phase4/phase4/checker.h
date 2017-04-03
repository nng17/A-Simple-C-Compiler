/*
 * File:	checker.h
 *
 * Description:	This file contains the public function declarations for the
 *		semantic checker for Simple C.
 */

# ifndef CHECKER_H
# define CHECKER_H
# include "Scope.h"

using namespace std;

Scope *openScope();
Scope *closeScope();


Symbol *defineFunction(const string &name, const Type &type);
Symbol *declareFunction(const string &name, const Type &type);
Symbol *declareVariable(const string &name, const Type &type);
Symbol *checkIdentifier(const string &name);
Symbol *checkFunction(const string &name);

Type checkLogicalOR(const Type&left, const Type &right);
Type checkLogicalAND(const Type &left, const Type &right);
Type checkEquality(const Type &left, const Type &right);
Type checkRelational(const Type &left, const Type &right, const string &operand);
Type checkAdditive(const Type &left, const Type &right);
Type checkSubtract(const Type &left, const Type &right);
Type checkMultiply(const Type &left, const Type &right);
Type checkDivide(const Type &left, const Type &right);
Type checkMod(const Type &left, const Type &right);
Type checkStar(const Type &right);
Type checkAddr(const Type &right, bool lvalue);
Type checkNot(const Type &right);
Type checkNeg(const Type &right);
Type checkSizeof(const Type &right);
Type checkPostfix(const Type &left, const Type &right);
Type checkFunctionCall(const Type &funcType, const Parameters* params);
Type checkAssignment(const Type &left, const Type &right, bool &lvalue);
Type checkReturn(const Type &expr, const Type &funcType);
Type checkConditions(const Type &expr);

# endif /* CHECKER_H */
