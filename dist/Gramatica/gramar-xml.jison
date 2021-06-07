/**
 * Ejemplo mi primer proyecto con Jison utilizando Nodejs en Ubuntu
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
"<"                 return 'menosq';
">"                 return 'masq';
"="                 return 'igual';
"\""				return 'comilla';

"+"                 return 'mas';
"-"                 return 'menos';
"*"                 return 'por';
"/"                 return 'div';

/* Espacios en blanco */
[ \r\t]+            {}
\n                  {}

[0-9]+("."[0-9]+)?\b    return 'decimal';
[0-9]+\b                return 'entero';
/*buscar otra ER para cadenas y separar este ER de identificador*/
([a-zA-Z])[a-zA-Z0-9_]* return 'identificador'; 
[^/"']                  return 'texto'; 


<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); }
/lex

/* Asociación de operadores y precedencia */

%left 'mas' 'menos'
%left 'por' 'div'
%left Umenos

%start XML_GRAMAR

%% /* Definición de la gramática */
XML_GRAMAR :  ETIQUETAS EOF	
;

ETIQUETAS :  ETIQUETAS ETIQUETA
	| ETIQUETA
	| error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
;

ETIQUETA : 
	  ETIQUETA_SIMPLE 
;
				
ETIQUETA_SIMPLE : 
			//INICIO_ETIQUETA > ETIQUETA_SIMPLE_CUERPO
	    INICIO_ETIQUETA masq  ETIQUETA_SIMPLE_CUERPO { console.log("ETIQUETA SIMPLE 1")}
			//INICIO_ETIQUETA / >
		|INICIO_ETIQUETA div masq { console.log("ETIQUETA SIMPLE 2")}
;

ETIQUETA_SIMPLE_CUERPO:
	//< id > ..... </ id >
	
	 ETIQUETAS_ATRRIBUTOS menosq div  identificador masq {console.log("< id > ..... </ id >"+$4)}
	    //  EXPRESIONES </ id >
	| EXPRESIONES menosq div  identificador masq  {console.log("expresiones "+ $1+ "< /id "+$4+$5)}
        //< id > </ id >
	| menosq div identificador masq {console.log("< id > </ id >")}
	
;

ETIQUETAS_ATRRIBUTOS:
	ETIQUETAS_ATRRIBUTOS ETIQUETA
	ETIQUETA
;

INICIO_ETIQUETA:
	//< id ATRIBUTOS
	menosq identificador ATRIBUTOS  {console.log(" < "+$2 ); }
	//< id 
	|menosq identificador { console.log("< "+$2);}
;

ATRIBUTOS : ATRIBUTOS ATRIBUTO 
	| ATRIBUTO 
;
			// id = " id "
ATRIBUTO : 
	identificador igual comilla EXPRESIONES comilla {console.log("atributo "+ $1)}
;

EXPRESIONES:
	 EXPRESIONES EXPRESION
	|EXPRESION
;

EXPRESION: identificador
		|decimal
		|entero
		|texto
;

/*
XML_GRAMAR :  
	ETIQUETAS EOF	
;

ETIQUETAS :   
	ETIQUETAS  ETIQUETA
	| ETIQUETA
	| error { console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); }
;

ETIQUETA :  
	// < id             >         TIPOS < / id >
	ABRIR_ETIQUETA C_S_ATRIBUTOS C_S_TIPO {console.log($1)+"1111111"}
;

	// < id
ABRIR_ETIQUETA : 
	menosque identificador {console.log($2)}
; 

C_S_ATRIBUTOS :
	//ATRIBUTOS >
	ATRIBUTOS masque  {console.log($1)}
	//> 
	| masque {console.log($1)}
;

C_S_TIPO :  
	// TIPOS < / id >
	TIPOS CERRAR_ETIQUETA {console.log($1)}
	// < / id >
	|CERRAR_ETIQUETA {console.log($1)}
;

CERRAR_ETIQUETA :
	//< / id >
	menosque div identificador masque {console.log($1)}
;

TIPOS :
	TIPOS TIPO
	| TIPO ;

TIPO:
	TIPOATRIBUTO 
	| ETIQUETA;

TIPOATRIBUTO :
	identificador|decimal|entero|texto;*/

