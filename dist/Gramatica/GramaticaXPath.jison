/**
 * Ejemplo mi primer proyecto con Jison utilizando Nodejs en Ubuntu
 */

/* Definición Léxica */
%lex

%options case-insensitive

%%

"Evaluar"           return 'REVALUAR';
";"                 return ';';
"("                 return '(';
")"                 return ')';
"["                 return '[';
"]"                 return ']';

"+"                 return '+';
"-"                 return '-';
"*"                 return '*';
"/"                 return '/';

/* Espacios en blanco */
[ \r\t]+            {}
\n                  {}

[0-9]+("."[0-9]+)?\b    return 'DECIMAL';
[0-9]+\b                return 'ENTERO';

/*EXPRESIONES REGULARES*/
//[39]   	
ExprSingle ("," ExprSingle)* return 'Expr';
//[40]   	
FLWORExpr | QuantifiedExpr
| SwitchExpr
| TypeswitchExpr
| IfExpr
| TryCatchExpr
| OrExpr 
    return 'ExprSingle';



//[108] 
("/" RelativePathExpr?) 
    | ("//" RelativePathExpr)
    | RelativePathExpr	/* xgc: barra inclinada solitaria */ retunrn 'PathExpr';
//[109]   	
 StepExpr (("/" | "//") StepExpr)*	return 'RelativePathExpr';


//[110]   	
PostfixExpr | AxisStep	return 'StepExpr';
//[111]   	
(ReverseStep | ForwardStep) PredicateList	return 'AxisStep';
//[112]   	
(ForwardAxis NodeTest) | AbbrevForwardStep	return 'ForwardStep';
//[115]   	
(ReverseAxis NodeTest) | AbbrevReverseStep	return 'ReverseStep';
//[123]   	
Predicate* return 'PredicateList';
//[121]   	
PrimaryExpr (Predicate | ArgumentList | Lookup)* return PostfixExpr;	
//[124]   	
"[" Expr "]" return 'Predicate';
//[129]   	
NumericLiteral | StringLiteral	return 'Literal';
//[130]   	
IntegerLiteral | DecimalLiteral | DoubleLiteral	return 'NumericLiteral';
//[219]   	
Digits	return 'IntegerLiteral';
//[220]   	
("." Digits) | (Digits "." [0-9]*)	/* ws: explícito */ return 'DecimalLiteral';
//[221]   	
(("." Digits)|(Digits ("." [0-9]*)?))([eE] [+-]? Digits) return'DoubleLiteral';
//[222]   	
('"' (PredefinedEntityRef | CharRef | EscapeQuot | [^"&])* '"') | ("'" ( PredefinedEntityRef | CharRef | EscapeApos | [^'&]) )* "\'")	/* ws: explícito */  return 'StringLiteral';
//[225]   	
"&" ("lt" | "gt" | "amp" | "quot" | "apos") ";"	/ * ws: explícito * / return 'PredefinedEntityRef';
//[226]   	
'""'	return 'EscapeQuot';
//[227]   	
"''"	return 'EscapeApos';
//[238]   	
[0-9]+ return 'Digits';


<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

/* Asociación de operadores y precedencia */

%left 'MAS' 'MENOS'
%left 'POR' 'DIVIDIDO'
%left UMENOS

%start ini

%% /* Definición de la gramática */

ini
	: ArrowFunctionSpecifier EOF
;

//55
ArrowFunctionSpecifier
    : EQName | VarRef | ParenthesizedExpr
;

//[56]
PrimaryExpr	   
    : Literal
    | VarRef
    | ParenthesizedExpr
    | ContextItemExpr
    | FunctionCall
    | FunctionItemExpr
    | MapConstructor
    | ArrayConstructor
    | UnaryLookup	
;

//[57]
Literal	   
    : NumericLiteral | StringLiteral
;

//[58]   	
NumericLiteral	   
    : IntegerLiteral | DecimalLiteral | DoubleLiteral
;	

//[59]   	
VarRef	   
    : "$" VarName	
;
//[60]   	
VarName	   
    : EQName
;

//[61]   	
ParenthesizedExpr	   
    :  "(" Expr? ")"
;

//[62]   	
ContextItemExpr	   
    : "."	
;

//[63]   	
FunctionCall	   
    : EQName ArgumentList	/* xgc: reserved-function-names */
;

/* gn: parens */
//[64]   	
Argument	   
    :  ExprSingle | ArgumentPlaceholder
;

//[65]   	
ArgumentPlaceholder	   
    : "?"	
;

//[66]   	
FunctionItemExpr	   
    : NamedFunctionRef | InlineFunctionExpr
;	

//[67]   	
NamedFunctionRef	   
    : EQName "#" IntegerLiteral	/* xgc: reserved-function-names */
;

//[68]   	
InlineFunctionExpr	   
    : "function" "(" ParamList? ")" ("as" SequenceType)? FunctionBody
;

//[69]   	
MapConstructor	   
    : "map" "{" (MapConstructorEntry ("," MapConstructorEntry)*)? "}"	
;

//[70]
MapConstructorEntry	   
    : MapKeyExpr ":" MapValueExpr	
;

//[71]   	
MapKeyExpr	   
    : ExprSingle
;

//[72]   	
MapValueExpr	   
    : ExprSingle
;	

//[73]   	
ArrayConstructor	   
    : SquareArrayConstructor | CurlyArrayConstructor	
;

//[74]   	
SquareArrayConstructor	   
    : "[" (ExprSingle ("," ExprSingle)*)? "]"	
;

//[75]   	
CurlyArrayConstructor	   
    : "array" EnclosedExpr	
;

//[76]   	
UnaryLookup	   
    : "?" KeySpecifier
;

//[77]   	
SingleType	   
    : SimpleTypeName "?"?	
;

//[78]   	
TypeDeclaration	   
    : "as" SequenceType	
;

//[79]   	
SequenceType	   
    : ("empty-sequence" "(" ")")
    | (ItemType OccurrenceIndicator?)	
;
/////////////////////////////
//[80]   	
OccurrenceIndicator	   
    : "?" | "*" | "+"	/* xgc: occurrence-indicators */
;
/////////////////
//[81]   	
ItemType	   
    : KindTest 
    | ("item" "(" ")") 
    | FunctionTest 
    | MapTest 
    | ArrayTest 
    | AtomicOrUnionType 
    | ParenthesizedItemType
;

//[82]   	
AtomicOrUnionType	   
    : EQName

//[83]   	
KindTest	   
    : DocumentTest
    | ElementTest
    | AttributeTest
    | SchemaElementTest
    | SchemaAttributeTest
    | PITest
    | CommentTest
    | TextTest
    | NamespaceNodeTest
    | AnyKindTest
;

//[84]   	
AnyKindTest	   
    : "node" "(" ")"
;
//...........................
//[85]   	
DocumentTest	   
    :"document-node" "(" (ElementTest | SchemaElementTest)? ")"	
;

//[86]   	
TextTest	   
    : "text" "(" ")"	
;

//[87]   	
CommentTest	   
    : "comment" "(" ")"	
;

//[88]   	
NamespaceNodeTest	   
    : "namespace-node" "(" ")"
;

//[89]   	
PITest	   
    : "processing-instruction" "(" (NCName | StringLiteral)? ")"	
;

//[90]   	
AttributeTest	   
    : "attribute" "(" (AttribNameOrWildcard ("," TypeName)?)? ")"
;

//[91]   	
AttribNameOrWildcard	   
    : AttributeName | "*"
;

//[92]   	
SchemaAttributeTest	   
    : "schema-attribute" "(" AttributeDeclaration ")"
;

//[93]   	
AttributeDeclaration	   
    : AttributeName	
;

//[94]   	
ElementTest	   
    : "element" "(" (ElementNameOrWildcard ("," TypeName "?"?)?)? ")"	
;

//[95]   	
ElementNameOrWildcard	   
    : ElementName | "*"	
;
//[96]   	
SchemaElementTest	   
    : "schema-element" "(" ElementDeclaration ")"	
;

//[97]   	
ElementDeclaration	   
    : ElementName	
;

//[98]   	
AttributeName	   
    : EQName	
;

//[99]   	
ElementName	   
    : EQName
;

//[100]   	
SimpleTypeName	   
    : TypeName	
;

//[101]   	
TypeName	   
    : EQName
;

//[102]   	
FunctionTest	   
    : AnyFunctionTest
    | TypedFunctionTest
;

//[103]   	
AnyFunctionTest	   
    : "function" "(" "*" ")"
;

//[104]   	
TypedFunctionTest	   
    : "function" "(" (SequenceType ("," SequenceType)*)? ")" "as" SequenceType
;

//[105]   	
MapTest	   
    : AnyMapTest | TypedMapTest	
;

//[106]   	
AnyMapTest	   
    : "map" "(" "*" ")"	
;

//[107]   	
TypedMapTest	   
    : "map" "(" AtomicOrUnionType "," SequenceType ")"	
;
//[108]   	
ArrayTest	   
    : AnyArrayTest | TypedArrayTest
;

//[109]   	
AnyArrayTest	   
    : "array" "(" "*" ")"
;

//[110]   	
TypedArrayTest	   
    : "array" "(" SequenceType ")"
;

//[111]   	
ParenthesizedItemType	   
    : "(" ItemType ")"
;

//[112]   	
EQName	   
    : QName | URIQualifiedName
;
	
