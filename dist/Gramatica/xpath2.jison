

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
"/\/"               return 'divdiv';
"/"                 return 'div';

"last()"            return "FLast";
"position()"        return "FPosition"


/* Espacios en blanco */comilla
[ \r\t]+            {}
\n                  {}


(?:0?[1-9]|[1-9][1-9])([\-/.])(?:0?[1-9]|1[1-2]|12][0-9]|0?[1-9])\1\d{4} return 'fecha';
[0-9]+("."[0-9]+)\b    return 'DECIMAL';
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
	: INICIAL EOF {console.log("inicial: "+$1);}
;

INICIAL: 
    PAL_NODO NODOS_SELECT {$$ = $1.toString()+$2.toString();}
    |PAL_NODO  { $$ = $1.toString();}
    |NODOS_SELECT {$$=$1.toString();}
;


PAL_NODO:
    // id [2]
    identificador corizq INST_INTERNA corder
    // id
    |identificador  {$$= $1.toString();}
; 


NODOS_SELECT:
    // NODOS_SELECT /DKSD/KSKD/
    NODOS_SELECT NODOS_SELECT_BUSCAR { $$=$1.toString()+$2.toString();}
    //  /bookstore
    |NODOS_SELECT_BUSCAR    {  $$= $1.toString();}
;

NODOS_SELECT_BUSCAR:
    // // libro
    divdiv A_BUSCAR {console.log("// A_BUSCAR "+$2); $$= $1.toString()+$2.toString();}
    // / libro
    |div  A_BUSCAR {console.log("A_BUSCAR "+$2); $$=$1.toString()+$2.toString();}
    // /
    |div  {console.log(" "+$1) ; $$=$1.toString();}
;

A_BUSCAR:
    //id
    PAL_NODO {$$= $1.toString();}
    // @ id
    |arroba PAL_NODO {$$ = $1.toString()+$2.toString();}
    //@
    |arroba {$$=$1.toString()}
;


INST_INTERNA:
    PREDICADOS_COND
    |arroba identificador igual comillaS PALABRA comillaS
    |texto masq NUMBER
    |texto menosq NUMBER
    |NUMBER
;


PREDICADOS_COND:
    // last() - 1
    FLast menos ENTERO
    // position() < 3
    | FPosition menosq NUMBER
    // position > 34
    | FPosition masq NUMBER
    // last()
    |FLast
; 

SUM_RES:
    menos
    |mas
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
    
