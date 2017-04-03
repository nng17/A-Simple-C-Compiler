/*
 * File:	parser.h
 *
 */

# ifndef PARSER_H
# define PARSER_H

void funcOrGlb();
void remainingDecls();
void global_declarators();
void specifier();
void parameter();
void parameters();
void pointers();
void declarations();
void declaration();
void declarator_list();
void declarator();
void statements();
void statement();
void assignment();
void expression();
void exprAND();
void exprEQUAL();
void exprCOMPARE();
void exprADDSUB();
void exprMULTDIV();
void exprUNARY();
void exprBRACKET();
void exprOTHER();
void expression_list();
void match(int);

# endif /* PARSER_H */
