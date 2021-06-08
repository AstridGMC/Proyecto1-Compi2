/**
 * Ejemplo mi primer proyecto con Jison utilizando Nodejs en Ubuntu
 */

/*%{
	const Error = require('./Error.js');
	var erroresLexicos = [];
	var variables=[];
	var erroresSintacticos = [];
%}
*/

/* DefINIción Léxica */
%lex

%options case-insensitive

%%

"Evaluar"           return 'REVALUAR';
"Aceptar"           return 'ACEPTAR';
";"                 return 'ptcoma';
"("                 return 'parizq';
")"                 return 'parder';
"["                 return 'corizq';
"]"                 return 'corder';
"<"                 return 'menosque';
">"                 return 'masque';
"="                 return 'igual';
"\""			return 'comilla';
"'"				return 'apostrofe';
"!"				return 'inicoment';

"+"                 return 'mas';
"-"                 return 'menos';
"*"                 return 'por';
"/"                 return 'div';

/* Espacios en blanco */
[ \r\t]+            {}
\n                  {}

[0-9]+("."[0-9]+)?\b    return 'decimal';
[0-9]+\b                return 'entero';
([a-zA-Z0-9])[a-zA-Z0-9_]* return 'identificador'; 
[:|_]					return 'especialchars';

<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

/* Asociación de operadores y precedencia */

%left 'mas' 'menos'
%left 'por' 'div'
%left Umenos

%start XML_GRAMAR

%% /* Definición de la gramática */
XML_GRAMAR :  
	ABRIR_ELEMENTO CONTENIDO_ELEMENTO EOF	 {return $1;}
;

ELEMENTOS : ELEMENTO E_PRIMA 
	| error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
;
E_PRIMA : ELEMENTO E_PRIMA	| ;

ELEMENTO :  
	ABRIR_ELEMENTO 	CONTENIDO_ELEMENTO 
;

ABRIR_ELEMENTO : 
	menosque identificador 
	| menosque inicoment menos menos 
; 

CONTENIDO_ELEMENTO: ETIQUETA | COMENTARIO ;

ETIQUETA : 
	ATRIBUTOS  CIERRE_ELEMENTO
	| CIERRE_ELEMENTO
;

ATRIBUTOS : ATRIBUTO A_PRIMA ;
A_PRIMA : ATRIBUTO A_PRIMA | ;


ATRIBUTO : identificador igual QUOTES C_ATRIBUTO QUOTES
;

C_ATRIBUTO : TIPOCONTENIDO C_A_PRIMA ;
C_A_PRIMA :TIPOCONTENIDO C_A_PRIMA | ;


CIERRE_ELEMENTO : 
	masque CONTENIDO_ETIQUETA menosque div identificador masque 
	| masque L_ELEMENTOS menosque div identificador masque 
	| masque menosque div identificador masque
	| div masque 
;

L_ELEMENTOS : L_ELEMENTOS ELEMENTO
	| ELEMENTO ;


CONTENIDO_ETIQUETA : TIPOCONTENIDO C_E_PRIMA;
C_E_PRIMA : TIPOCONTENIDO C_E_PRIMA  |  ;


TIPOCONTENIDO :
	TIPO_DATO | SIGNOS | especialchars ;


TIPO_DATO : identificador|decimal|entero;
SIGNOS : mas | menos | por | div ;

QUOTES : comilla | apostrofe ;


COMENTARIO : C_TEXTO menos menos masque
	| menos menos masque
;

C_TEXTO : TIPO_DATO C_T_PRIMA ;
C_T_PRIMA : TIPO_DATO C_T_PRIMA | ;

