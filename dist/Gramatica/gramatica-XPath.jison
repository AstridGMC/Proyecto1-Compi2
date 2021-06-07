

/**
 * Ejemplo mi primer proyecto con Jison utilizando Nodejs en Ubuntu
 */

/* DefINIción Léxica */
%lex

%options case-insensitive

%%
";"                 return 'ptcoma';
"("                 return 'parizq';
")"                 return 'parder';
"["                 return 'corizq';
"]"                 return 'corder';
"<"                 return 'menosq';
">"                 return 'masq';
"="                 return 'igual';
"\""				return 'comilla';
"\''"				return 'comillaS';
"\."				return 'punto';
"@"				    return 'arroba';

"+"                 return 'mas';
"-"                 return 'menos';
"*"                 return 'por';
"/\/"                 return 'divdiv';
"/"                 return 'div';

"last()"            return "FLast";
"position()"        return "FPosition"


/* Espacios en blanco */comilla
[ \r\t]+            {}
\n                  {}


(?:0?[1-9]|[1-9][1-9])([\-/.])(?:0?[1-9]|1[1-2]|12][0-9]|0?[1-9])\1\d{4} return 'fecha';
[0-9]+("."[0-9]+)?\b    return 'DECIMAL';
[0-9]+\b                return 'ENTERO';
([a-zA-Z])[a-zA-Z0-9_]* return 'identificador';
[^/"']                  return 'texto';



<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

/* Asociación de operadores y precedencia */

%left 'mas' 'menos'
%left 'por' 'div'
%left Umenos


%start ini

%% /* Definición de la gramática */

ini
	: INICIAL EOF
;

INICIAL: 
    PAL_NODO NODOS_SELECT
    |PAL_NODO
    |NODOS_SELECT
;


NODOS_SELECT:
    // NODOS_SELECT 
    NODOS_SELECT NODOS_SELECT_BUSCAR
    //  /bookstore
    |NODOS_SELECT_BUSCAR    
;

NODOS_SELECT_BUSCAR:
    // // libro
    divdiv A_BUSCAR
    // / libro
    |div  A_BUSCAR
    // /
    |div
;

A_BUSCAR:
    //id
    PAL_NODO
    // @ id
    |arroba PAL_NODO
    //@
    |arroba
;


PAL_NODO:
    // id [2]
    identificador corder INST_INTERNA corizq
    // id
    |identificador
; 


PREDICADOS_COND:
    // last() - 1
    FLast menos NUMBER
    // position() < 3
    | FPosition menosq NUMBER
    // position > 34
    | FPosition masq NUMBER
    // last()
    |FLast
; 

INST_INTERNA:
    PREDICADOS_COND
    |A_BUSCAR identificador
    |arroba identificador igual comillaS PALABRA comillaS
    |texto masq NUMBER
    |texto menosq NUMBER
    |NUMBER
;


NUMBER:
    ENTERO
    |DECIMAL
;

PALABRA:
    identificador
    |fecha
    |NUMBER
    |texto
;
    
