//USING THIS AS A REFERENCE TO HOW .Y works

%code requires{
  #include "ast.hpp"

  #include <cassert>

  extern const ASTNode *g_root; // A way of getting the AST out

  //! This is to fix problems when generating C++
  // We are declaring the functions provided by Flex, so
  // that Bison generated code can call them.
  int yylex(void);
  void yyerror(const char *);
}

// Represents the value associated with any kind of
// AST node.
%union{
  const ASTNode *node;
  float number;
  std::string *string;
}

%token T_LSQBRACKET T_RSQBRACKET T_LCUBRACKET T_RCUBRACKET T_LTRIBRACKET T_RTRIBRACKET T_LBRACKET T_RBRACKET
%token T_ASSIGN T_DOT T_COMMA T_COLON T_QMARK T_SEMICOLON T_SPEACHMARK T_APOSTROPHE
%token T_NOT T_AND T_OR T_MORE T_LESS T_XOR T_TILDA
%token T_CHAR T_SIGN_CHAR T_UNSIGN_CHAR T_SHORT T_UNSIGN_SHORT T_INT T_UNSIGN_INT
%token T_LONG T_UNSIGN_LONG T_LONGLONG T_UNSIGN_LONGLONG T_FLOAT T_DOUBLE T_LONGDOUBLE T_VOID
%token T_TIMES T_DIVIDE T_PLUS T_MINUS T_MODULUS T_INC T_DEC
%token T_ADDASSIGN T_SUBASSIGN T_MULASSIGN T_DIVASSIGN T_MODASSIGN 
%token T_LSHIFTASSIGN T_RSHIFTASSIGN T_ANDASSIGN T_XORASSIGN T_ORASSIGN
%token T_LAND T_LOR T_LEQUAL T_LNEQUAL T_LLESSEQ T_LMOREEQ T_LSHIFT T_RSHIFT
%token T_NUMBER T_ID T_COMMENT
%token T_RETURN T_SIZE_OF T_ELSE T_IF T_ELIF T_WHILE T_DO T_FOR

%type <node> TOP_LIST DEC_FUNCTION BODY
%type <node> DEC_VAR_LIST DEC_VARIABLE DEC_STATEMENT
%type <node> GLO_DEC_VAR_LIST GLO_DEC_VARIABLE GLO_DEC_STATEMENT
%type <node> STATEMENT RETURN_STATEMENT 
%type <node> IF_OR_ELSE VAL_LIST
%type <node> WHILE_STATEMENT DO_STATEMENT NEW_SCOPE FOR_STATEMENT EXPR_STATEMENT
%type <node> ARGUMENT_LIST ARGUMENT_LIST_NO_TYPE
%type <node> EXPR_1 EXPR_2 EXPR_3 EXPR_4 EXPR_5 EXPR_6 EXPR_7 EXPR_8
%type <node> EXPR_9 EXPR_10 EXPR_11 EXPR_12 EXPR_13 EXPR_14 EXPR_15 PRIMATIVES
%type <number> T_NUMBER
%type <string> T_ID
%type <string> TYPE T_CHAR T_SIGN_CHAR T_UNSIGN_CHAR T_SHORT T_UNSIGN_SHORT T_INT T_UNSIGN_INT
%type <string> T_LONG T_UNSIGN_LONG T_LONGLONG T_UNSIGN_LONGLONG T_FLOAT T_DOUBLE T_LONGDOUBLE T_VOID

%start ROOT

%%
//syntax notes P_ means its a primative

ROOT : TOP_LIST { g_root = $1; }

TOP_LIST : TOP_LIST DEC_FUNCTION        { $$ = new Top_List($2,$1); }
        | TOP_LIST GLO_DEC_STATEMENT    { $$ = new Top_List($2,$1); }
        | DEC_FUNCTION                  { $$ = new Top_List($1); }
        | GLO_DEC_STATEMENT             { $$ = new Top_List($1); }

DEC_FUNCTION : TYPE T_ID T_LBRACKET ARGUMENT_LIST T_RBRACKET T_LCUBRACKET BODY T_RCUBRACKET { $$ = new Function(*$1, *$2, $4, $7); }
        | TYPE T_ID T_LBRACKET T_RBRACKET T_LCUBRACKET BODY T_RCUBRACKET { $$ = new Function(*$1, *$2, new Argument(), $6); }
        | TYPE T_ID T_LBRACKET ARGUMENT_LIST T_RBRACKET T_SEMICOLON { $$ = new Future_Func(*$1, *$2, $4); }
        | TYPE T_ID T_LBRACKET T_RBRACKET T_SEMICOLON { $$ = new Future_Func(*$1, *$2, new Argument()); }

ARGUMENT_LIST : ARGUMENT_LIST T_COMMA TYPE T_ID         { $$ = new Argument(*$3, *$4, $1); }
        | TYPE T_ID                                     { $$ = new Argument(*$1, *$2); }

ARGUMENT_LIST_NO_TYPE : ARGUMENT_LIST_NO_TYPE T_COMMA EXPR_2    { $$ = new ArgumentNoType($3, $1); }
        | EXPR_2                                                { $$ = new ArgumentNoType($1); }
        | %empty                                                { $$ = new ArgumentNoType(); }

TYPE : T_CHAR                   { $$ = $1; }
        | T_SIGN_CHAR           { $$ = $1; }
        | T_UNSIGN_CHAR         { $$ = $1; }
        | T_SHORT               { $$ = $1; }
        | T_UNSIGN_SHORT        { $$ = $1; }
        | T_INT                 { $$ = $1; }
        | T_UNSIGN_INT          { $$ = $1; }
        | T_LONG                { $$ = $1; }
        | T_UNSIGN_LONG         { $$ = $1; }
        | T_LONGLONG            { $$ = $1; }
        | T_UNSIGN_LONGLONG     { $$ = $1; }
        | T_FLOAT               { $$ = $1; }
        | T_DOUBLE              { $$ = $1; }
        | T_LONGDOUBLE          { $$ = $1; }
        | T_VOID                { $$ = $1; }

BODY : BODY STATEMENT           { $$ = new Body($2,$1); }
        | STATEMENT             { $$ = new Body($1); }
        | %empty                { $$ = new Body(); }
    
STATEMENT :  RETURN_STATEMENT           { $$ = $1; }
        | DEC_STATEMENT                 { $$ = $1; }
        | EXPR_STATEMENT                { $$ = $1; }
        | IF_OR_ELSE                    { $$ = $1; }
        | WHILE_STATEMENT               { $$ = $1; }
        | DO_STATEMENT                  { $$ = $1; }
        | NEW_SCOPE                     { $$ = $1; }
        | FOR_STATEMENT                 { $$ = $1; }

EXPR_STATEMENT : EXPR_1 T_SEMICOLON             { $$ = new ExprStatement($1); }
        | T_SEMICOLON                           { $$ = new ExprStatement(); }

FOR_STATEMENT : T_FOR T_LBRACKET DEC_STATEMENT EXPR_STATEMENT EXPR_1 T_RBRACKET STATEMENT       { $$ = new ForStatement($3,$4,$5,$7);}
        | T_FOR T_LBRACKET EXPR_STATEMENT EXPR_STATEMENT EXPR_1 T_RBRACKET STATEMENT            { $$ = new ForStatement($3,$4,$5,$7);}
        | T_FOR T_LBRACKET DEC_STATEMENT EXPR_STATEMENT T_RBRACKET STATEMENT                    { $$ = new ForStatement($3,$4,$6);}
        | T_FOR T_LBRACKET EXPR_STATEMENT EXPR_STATEMENT T_RBRACKET STATEMENT                   { $$ = new ForStatement($3,$4,$6);}

NEW_SCOPE : T_LCUBRACKET BODY T_RCUBRACKET      { $$ = new NewScope($2); }

RETURN_STATEMENT : T_RETURN EXPR_1 T_SEMICOLON          { $$ = new ReturnStatement($2); }
        | T_RETURN T_SEMICOLON                          { $$ = new ReturnStatement(); }

DEC_STATEMENT : TYPE DEC_VAR_LIST T_SEMICOLON      { $$ = new DeclareStatement(*$1, $2); }
        | TYPE T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET    { $$ = new DeclareArray(*$1, *$2, $4); }
        | TYPE T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET    { $$ = new DeclareArray(*$1, *$2, -$5); }
        | TYPE T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_ASSIGN T_LCUBRACKET VAL_LIST T_RCUBRACKET    { $$ = new DeclareArray(*$1, *$2, $4, $8); }
        | TYPE T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_ASSIGN T_LCUBRACKET VAL_LIST T_RCUBRACKET    { $$ = new DeclareArray(*$1, *$2, -$5, $9); }
        | TYPE T_ID T_LSQBRACKET T_RSQBRACKET T_ASSIGN T_LCUBRACKET VAL_LIST T_RCUBRACKET    { $$ = new DeclareArray(0,*$1, *$2, $7); }

VAL_LIST : EXPR_2                               { $$ = new ValList($1); }
        | VAL_LIST T_COMMA EXPR_2               { $$ = new ValList($3,$1); }
        | %empty                                { $$ = new ValList(); }

DEC_VAR_LIST : DEC_VARIABLE                     { $$ = new Dec_Var_List($1); }
        | DEC_VAR_LIST T_COMMA DEC_VARIABLE     { $$ = new Dec_Var_List($3,$1); }

DEC_VARIABLE : T_ID T_ASSIGN EXPR_2             { $$ = new Declare(*$1, $3); }  
        | T_ID                                  { $$ = new Declare(*$1); }

GLO_DEC_STATEMENT : TYPE GLO_DEC_VAR_LIST T_SEMICOLON   { $$ = new DeclareStatement(*$1, $2); }

GLO_DEC_VAR_LIST : GLO_DEC_VARIABLE                     { $$ = new Dec_Var_List($1); }
        | GLO_DEC_VAR_LIST T_COMMA GLO_DEC_VARIABLE     { $$ = new Dec_Var_List($3,$1); }

GLO_DEC_VARIABLE : T_ID T_ASSIGN T_NUMBER                       { $$ = new GlobalDeclare(*$1, $3); } 
        | T_ID T_ASSIGN T_MINUS T_NUMBER                        { $$ = new GlobalDeclare(*$1, -$4); }
        | T_ID T_ASSIGN T_LBRACKET T_NUMBER T_RBRACKET          { $$ = new GlobalDeclare(*$1, $4); } 
        | T_ID T_ASSIGN T_LBRACKET T_MINUS T_NUMBER T_RBRACKET  { $$ = new GlobalDeclare(*$1, -$5); } 
        | T_ID                                                  { $$ = new GlobalDeclare(*$1); }

IF_OR_ELSE : T_IF EXPR_1 STATEMENT T_ELSE STATEMENT      { $$ = new IfElse_Statement ($2,$3,$5); }
        | T_IF EXPR_1 STATEMENT                                 { $$ = new If_Statement($2,$3); }

WHILE_STATEMENT : T_WHILE EXPR_1 STATEMENT                              { $$ = new While_Statement($2,$3); }

DO_STATEMENT : T_DO STATEMENT T_WHILE EXPR_1 T_SEMICOLON                { $$ = new Do_While_Statement($2,$4); }

EXPR_1 : EXPR_2                         { $$ = $1; }
        | EXPR_1 T_COMMA EXPR_2         { $$ = new CommaOp($1, $3); }

EXPR_2 : EXPR_3                                 { $$ = $1; }
        | T_ID T_ASSIGN EXPR_2                  { $$ = new AssignOp(*$1, $3); }
        | T_ID T_ADDASSIGN EXPR_2               { $$ = new AssignOp(*$1, new AddOperator(new Variable(*$1), $3)); }
        | T_ID T_SUBASSIGN EXPR_2               { $$ = new AssignOp(*$1, new SubOperator(new Variable(*$1), $3)); }
        | T_ID T_MULASSIGN EXPR_2               { $$ = new AssignOp(*$1, new MulOperator(new Variable(*$1), $3)); }
        | T_ID T_DIVASSIGN EXPR_2               { $$ = new AssignOp(*$1, new DivOperator(new Variable(*$1), $3)); }
        | T_ID T_MODASSIGN EXPR_2               { $$ = new AssignOp(*$1, new ModOperator(new Variable(*$1), $3)); }
        | T_ID T_LSHIFTASSIGN EXPR_2            { $$ = new AssignOp(*$1, new BLShift(new Variable(*$1), $3)); }
        | T_ID T_RSHIFTASSIGN EXPR_2            { $$ = new AssignOp(*$1, new BRShift(new Variable(*$1), $3)); }
        | T_ID T_ANDASSIGN EXPR_2               { $$ = new AssignOp(*$1, new BAnd(new Variable(*$1), $3)); }
        | T_ID T_ORASSIGN EXPR_2                { $$ = new AssignOp(*$1, new BOr(new Variable(*$1), $3)); }
        | T_ID T_XORASSIGN EXPR_2               { $$ = new AssignOp(*$1, new BXor(new Variable(*$1), $3)); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_ASSIGN EXPR_2                  { $$ = new AssignOp(*$1, $3, $6); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_ADDASSIGN EXPR_2               { $$ = new AssignOp(*$1, $3, new AddOperator(new ArrayVal(*$1,$3), $6)); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_SUBASSIGN EXPR_2               { $$ = new AssignOp(*$1, $3, new SubOperator(new ArrayVal(*$1,$3), $6)); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_MULASSIGN EXPR_2               { $$ = new AssignOp(*$1, $3, new MulOperator(new ArrayVal(*$1,$3), $6)); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_DIVASSIGN EXPR_2               { $$ = new AssignOp(*$1, $3, new DivOperator(new ArrayVal(*$1,$3), $6)); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_MODASSIGN EXPR_2               { $$ = new AssignOp(*$1, $3, new ModOperator(new ArrayVal(*$1,$3), $6)); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_LSHIFTASSIGN EXPR_2            { $$ = new AssignOp(*$1, $3, new BLShift(new ArrayVal(*$1,$3), $6)); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_RSHIFTASSIGN EXPR_2            { $$ = new AssignOp(*$1, $3, new BRShift(new ArrayVal(*$1,$3), $6)); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_ANDASSIGN EXPR_2               { $$ = new AssignOp(*$1, $3, new BAnd(new ArrayVal(*$1,$3), $6)); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_ORASSIGN EXPR_2                { $$ = new AssignOp(*$1, $3, new BOr(new ArrayVal(*$1,$3), $6)); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_XORASSIGN EXPR_2               { $$ = new AssignOp(*$1, $3, new BXor(new ArrayVal(*$1,$3), $6)); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_ASSIGN EXPR_2                  { $$ = new AssignOp(*$1, -$4, $7); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_ADDASSIGN EXPR_2               { $$ = new AssignOp(*$1, -$4, new AddOperator(new ArrayVal(*$1,-$4), $7)); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_SUBASSIGN EXPR_2               { $$ = new AssignOp(*$1, -$4, new SubOperator(new ArrayVal(*$1,-$4), $7)); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_MULASSIGN EXPR_2               { $$ = new AssignOp(*$1, -$4, new MulOperator(new ArrayVal(*$1,-$4), $7)); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_DIVASSIGN EXPR_2               { $$ = new AssignOp(*$1, -$4, new DivOperator(new ArrayVal(*$1,-$4), $7)); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_MODASSIGN EXPR_2               { $$ = new AssignOp(*$1, -$4, new ModOperator(new ArrayVal(*$1,-$4), $7)); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_LSHIFTASSIGN EXPR_2            { $$ = new AssignOp(*$1, -$4, new BLShift(new ArrayVal(*$1,-$4), $7)); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_RSHIFTASSIGN EXPR_2            { $$ = new AssignOp(*$1, -$4, new BRShift(new ArrayVal(*$1,-$4), $7)); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_ANDASSIGN EXPR_2               { $$ = new AssignOp(*$1, -$4, new BAnd(new ArrayVal(*$1,-$4), $7)); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_ORASSIGN EXPR_2                { $$ = new AssignOp(*$1, -$4, new BOr(new ArrayVal(*$1,-$4), $7)); }

EXPR_3 : EXPR_4                                         { $$ = $1; }
        | EXPR_3 T_QMARK EXPR_1 T_COLON EXPR_4          { $$ = new TenOp($1,$3,$5); }

EXPR_4 : EXPR_5                         { $$ = $1; }
        | EXPR_4 T_LOR EXPR_5           { $$ = new LOr($1,$3); }

EXPR_5 : EXPR_6                         { $$ = $1; }
        | EXPR_5 T_LAND EXPR_6          { $$ = new LAnd($1,$3); }

EXPR_6 : EXPR_7                         { $$ = $1; }
        | EXPR_6 T_OR EXPR_7            { $$ = new BOr($1,$3); }

EXPR_7 : EXPR_8                         { $$ = $1; }
        | EXPR_7 T_XOR EXPR_8           { $$ = new BXor($1,$3); }

EXPR_8 : EXPR_9                         { $$ = $1; }
        | EXPR_8 T_AND EXPR_9           { $$ = new BAnd($1,$3); }

EXPR_9 : EXPR_10                        { $$ = $1; }
        | EXPR_9 T_LEQUAL EXPR_10       { $$ = new LEqual($1,$3); }
        | EXPR_9 T_LNEQUAL EXPR_10      { $$ = new LNotEqual($1,$3); }

EXPR_10 : EXPR_11                       { $$ = $1; }
        | EXPR_10 T_MORE EXPR_11        { $$ = new LMore($1,$3); }
        | EXPR_10 T_LESS EXPR_11        { $$ = new LLess($1,$3); }
        | EXPR_10 T_LMOREEQ EXPR_11     { $$ = new LMoreEqual($1,$3); }
        | EXPR_10 T_LLESSEQ EXPR_11     { $$ = new LLessEqual($1,$3); }

EXPR_11 : EXPR_12                       { $$ = $1; }
        | EXPR_11 T_LSHIFT EXPR_12      { $$ = new BLShift($1,$3); }
        | EXPR_11 T_RSHIFT EXPR_12      { $$ = new BRShift($1,$3); }

EXPR_12 : EXPR_13                       { $$ = $1; }
        | EXPR_12 T_PLUS EXPR_13        { $$ = new AddOperator( $1 , $3 ); }
        | EXPR_12 T_MINUS EXPR_13       { $$ = new SubOperator( $1 , $3 ); }

EXPR_13 : EXPR_14                       { $$ = $1; }
        | EXPR_13 T_TIMES EXPR_14       { $$ = new MulOperator( $1 , $3 ); }
        | EXPR_13 T_DIVIDE EXPR_14      { $$ = new DivOperator( $1 , $3 ); }
        | EXPR_13 T_MODULUS EXPR_14     { $$ = new ModOperator( $1 , $3 ); }

EXPR_14 : EXPR_15                       { $$ = $1; }
        | T_SIZE_OF T_LBRACKET T_ID T_RBRACKET                                                  { $$ = new SizeOf(*$3); }
        | T_SIZE_OF T_LBRACKET T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_RBRACKET               { $$ = new SizeOf(*$3, $5); }
        | T_SIZE_OF T_LBRACKET T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_RBRACKET       { $$ = new SizeOf(*$3, -$6); }
        | T_NOT EXPR_14                 { $$ = new LNot($2); }
        | T_TILDA EXPR_14               { $$ = new BNot($2); }
        | T_INC T_ID                    { $$ = new AssignOp(*$2, new AddOperator(new Variable(*$2), new Number(1,0))); }
        | T_DEC T_ID                    { $$ = new AssignOp(*$2, new SubOperator(new Variable(*$2), new Number(1,0))); }
        | T_INC T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET                    { $$ = new AssignOp(*$2,$4, new AddOperator(new ArrayVal(*$2,$4), new Number(1,0))); }
        | T_DEC T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET                    { $$ = new AssignOp(*$2,$4, new SubOperator(new ArrayVal(*$2,$4), new Number(1,0))); }
        | T_INC T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET            { $$ = new AssignOp(*$2,-$5, new AddOperator(new ArrayVal(*$2,-$5), new Number(1,0))); }
        | T_DEC T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET            { $$ = new AssignOp(*$2,-$5, new SubOperator(new ArrayVal(*$2,-$5), new Number(1,0))); }
        | T_PLUS EXPR_15                { $$ = new PosOp($2);}
        | T_MINUS EXPR_15               { $$ = new NegOp($2);}

EXPR_15 : PRIMATIVES                                            { $$ = $1; }
        | T_ID T_INC                                            { $$ = new AssignOp(*$1, new AddOperator(new Variable(*$1), new Number(1,0))); }
        | T_ID T_DEC                                            { $$ = new AssignOp(*$1, new SubOperator(new Variable(*$1), new Number(1,0))); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_INC           { $$ = new AssignOp(*$1,$3, new AddOperator(new ArrayVal(*$1,$3), new Number(1,0))); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET T_DEC           { $$ = new AssignOp(*$1,$3, new SubOperator(new ArrayVal(*$1,$3), new Number(1,0))); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_INC   { $$ = new AssignOp(*$1,-$4, new AddOperator(new ArrayVal(*$1,-$4), new Number(1,0))); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET T_DEC   { $$ = new AssignOp(*$1,-$4, new SubOperator(new ArrayVal(*$1,-$4), new Number(1,0))); }
        | T_ID T_LBRACKET ARGUMENT_LIST_NO_TYPE T_RBRACKET      { $$ = new FunctionStatementInExpr(*$1,$3); }
        | T_LBRACKET EXPR_1 T_RBRACKET                          { $$ = $2; }

PRIMATIVES : T_ID                                 { $$ = new Variable(*$1); }
        | T_ID T_LSQBRACKET T_NUMBER T_RSQBRACKET   { $$ = new ArrayVal(*$1,$3); }
        | T_ID T_LSQBRACKET T_MINUS T_NUMBER T_RSQBRACKET   { $$ = new ArrayVal(*$1,-$4); }
        | T_NUMBER                      { $$ = new Number( $1 , 0 ); }
        | T_MINUS T_NUMBER              { $$ = new Number( 0 , $2 ); }
%%

const ASTNode *g_root; // Definition of variable (to match declaration earlier)

const ASTNode *parseAST()
{
  g_root=0;
  yyparse();
  return g_root;
}