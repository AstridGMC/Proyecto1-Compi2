/**
 * Ejemplo mi primer proyecto con Jison utilizando Nodejs en Ubuntu
 */

/* DefINIción Léxica */
%lex

%options case-insensitive

%%

"XML"               return 'xml1'; 
"UTF8"				return 'utf';
"ASCII"			    return 'ascii1';
"version"			return 'version';
"encoding"			return 'encoding';
"mod"				return 'modulo';
"or"				return 'or1';
"and"				return 'and1';
"node()"			return 'funcionNode'
"text()"			return 'funcionText'
"last()"			return 'funcionLast'
"position()"		return 'funcionPosition'

";"                 return 'ptcoma';
"("                 return 'parizq';
")"                 return 'parder';
"["                 return 'corcheteAbierto';
"]"                 return 'corcheteCerrado';
"<""="                 return 'menorIgual';
">""="                return 'mayorIgual';
"<"                 return 'menorque';
">"                 return 'mayorque';
"="                 return 'igual';
"!""="                 return 'diferenteQue';
".""." 				return 'dosPuntosConsecutivos';
"." 				return 'punto';

"\""				return 'comilla';

"+"                 return 'mas';
"-"                 return 'menos';
"*"                 return 'asterisco';
"/""/"               return 'diagonalDoble';
"/"                 return 'diagonal';
"div"				return 'dividir';


"?"                 return 'interrogacionC';
"@"                 return 'arroba';

/* Espacios en blanco */
[ \r\t]+            {}
\n                  {}

[0-9]+("."[0-9]+)\b    return 'decimal';
[0-9]+\b                return 'entero';
/*buscar otra ER para cadenas y separar este ER de identificador*/
([a-zA-Z])[a-zA-Z0-9_]* return 'identificador';  


<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

/* Asociación de operadores y precedencia */



%start S

%% /* Definición de la gramática */

S :
	 CONSULTAS EOF
;

EXPRESION_INICIAL :
	mayorque interrogacionC xml1 version igual comilla decimal comilla encoding igual comilla TIPOENCODING comilla interrogacionC menorque
;

TIPOENCODING :
	utf 
| ascii1
;

CONSULTAS : 
	CONSULTAS CONSULTA
	| CONSULTA
;

CONSULTA :
	DIAGONALES 
	| SIMBOLOS 
	| TIPO_ID
	| FUNCION
;


DIAGONALES:
	 diagonalDoble {console.log("es doble")}
	 	| diagonal {console.log("es simple")}
;

SIMBOLOS:
	arroba SIGUIENTE_ARROBA
	| asterisco
	| dosPuntosConsecutivos
	| punto
;

SIGUIENTE_ARROBA :
	identificador 
	| asterisco
;

TIPO_ID :
	identificador 
	| identificador ARREGLO_ID
;

ARREGLO_ID:
	corcheteAbierto OPERACIONES_ARREGLO corcheteCerrado
;

OPERACIONES_ARREGLO:
	OPERACION_ARITMETICA
	| OPERACION_RELACIONAL
	| OPERACION_IGUALDAD
	| OPERACION_LOGICA
;



TIPOIGUALAR:
	identificador
	| entero
	| decimal 
	| FUNCION
;

TIPOIGUALARAUX :
	TIPOIGUALARAUX CONSULTA
	| CONSULTA
;


OPERACION_ARITMETICA :
	OPERACION_ARITMETICA mas T1
	| OPERACION_ARITMETICA menos T1
	| T1 
;

T1 : 
	T1 modulo T 
	| T
;

T : 
	T asterisco F 
	| T dividir F
	| F 
;

F : 
	TIPOACEPTAR
	| parizq OPERACION_ARITMETICA parder
;

TIPOACEPTAR : 
	  TIPOIGUALAR 
	| RUTAS
	;

RUTAS :
	  RUTAS RUTA
	| RUTA
	;

RUTA:
	diagonalDoble SIMBOLOS2
	| diagonal SIMBOLOS2
	| arroba SIGUIENTE_ARROBA
;

SIMBOLOS2:
	arroba SIGUIENTE_ARROBA
	| dosPuntosConsecutivos
	| punto
;

OPERACION_RELACIONAL :
		OPERACION_ARITMETICA menorque OPERACION_ARITMETICA 
		| OPERACION_ARITMETICA mayorque OPERACION_ARITMETICA
		| OPERACION_ARITMETICA menorIgual OPERACION_ARITMETICA
		| OPERACION_ARITMETICA mayorIgual OPERACION_ARITMETICA
		| OPERACION_ARITMETICA  igual OPERACION_ARITMETICA
		| OPERACION_ARITMETICA  diferenteQue OPERACION_ARITMETICA	
;




OPERACION_LOGICA:
	OPERACION_RELACIONAL and1 OPERACION_RELACIONAL
	OPERACION_RELACIONAL or1 OPERACION_RELACIONAL
;


FUNCION :
	funcionNode
	| funcionText
	|funcionLast
	|funcionPosition
;




	


