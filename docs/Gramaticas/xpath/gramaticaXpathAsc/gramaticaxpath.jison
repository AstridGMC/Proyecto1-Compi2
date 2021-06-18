
%{
	define('grammarXPATH',function () {
			return {
				getParser: function () {
					return gramaticaxpath;
				}
			};
		});

	var erroresLexicos = [];
	var variables=[];
	var erroresSintacticos = [];
	var errorSemantico=[];
	
	
%}

/********************************************************* LEXICO *****************************************************/

 
%lex
%{

	if (!('idCST' in yy)) {
		yy.idCST = 0;
		yy.dotCST = 'graph{'+'\n';
	}
	if (!('idAST' in yy)) {
		yy.idAST = 0;
		yy.dotAST = 'graph{'+'\n';
	}
	
%}
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

//metodos
"node()" 			return 'funcionNode';
"text()"			return 'funcionText';
"last()"			return 'funcionLast';
"position()"		return 'funcionPosition';

//axes
"ancestor_or_self"	return 'ancestor_or_self1';
"ancestor"			return 'ancestor1';
"attribute"			return 'attribute1';
"child"				return 'child1';
"descendant_or_self" return 'descendant_or_self1';	
"descendant"		return 'descendant1';
"following_sibling"	return 'following_sibling1';
"following"			return 'following1';
//	| namespace -> no se toma en cuenta
"parent"			return 'parent1';
"preceding_sibling"	return 'preceding_sibling1';
"preceding"			return 'preceding1';
"self"				return 'self1';

//simbolos
";"                 return 'ptcoma';
":"                 return 'dosPuntos';
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
"+"                 return 'mas';
"-"                 return 'menos';
"*"                 return 'asterisco';
"/""/"               return 'diagonalDoble';
"/"                 return 'diagonal';

"div"				return 'dividir';
"?"                 return 'interrogacionC';
"@"                 return 'arroba';
"|"                 return 'concatenacion';


/* Espacios en blanco */
[ \r\t]+            {}
\n                  {}

[0-9]+("."[0-9]+)\b    return 'decimal';
[0-9]+\b                return 'entero';
([a-zA-Z])[a-zA-Z0-9_]* return 'identificador';
\"[^\"]*\"				return 'cadena';
"\""				return 'comilla';




<<EOF>>                 return 'EOF';

.                       { console.error('Este es un error léxico: ' + yytext + ', en la linea: ' + yylloc.first_line + ', en la columna: ' + yylloc.first_column); 
						erroresLexicos.push(new Error( yylloc._$.first_line ,  yylloc._$.first_column, 'sintactico','xmldesc', yytext));
						}
/lex


	//Importaciones 
%{	
	var etiquetas=[];


	//const {Dato} = require("../../../Scripts/ClasesXpath/Dato");
//const {OperacionAritmetica} = require("../../../Scripts/ClasesXpath/OperacionAritmetica");
	//const {Operador} = require("../../../Scripts/ClasesXpath/Operador");
	//const {OperacionRelacional} = require("../../../Scripts/ClasesXpath/OperacionRelacional");
	//const {OperacionLogica} = require("../../../Scripts/ClasesXpath/OperacionLogica");
	//const {Predicado} = require("../../../Scripts/ClasesXpath/Predicado");
	//const {IdSimple} = require("../../../Scripts/ClasesXpath/IdSimple");
	//const {IdCompuesto} = require("../../../Scripts/ClasesXpath/IdCompuesto");
	//const {SimbolosXpath} = require("../../../Scripts/ClasesXpath/SimbolosXpath");
	//const {TiposXpath} = require("../../../Scripts/ClasesXpath/TiposXpath");
	//const {Metodo} = require("../../../Scripts/ClasesXpath/Metodo");
	//const {Metodo} = require("../../../Scripts/ClasesXpath/Metodo");
	//const {Funcion} = require("../../../Scripts/ClasesXpath/Funcion");
	//const {Arroba} = require("../../../Scripts/ClasesXpath/Arroba");
	//const {diagonalDobleC} = require("../../../Scripts/ClasesXpath/diagonalDobleC");
	//const {diagonalSimpleS} = require("../../../Scripts/ClasesXpath/diagonalSimpleS"); 
	var AUXid=0;
	
	
	
	//const {Error} = require('../../../Scripts/Errores/Error.js');
    //const {Regla} = require("../../../Scripts/Arboles/Regla");
    //const {ObjetoNodo} = require("../../Scripts/Arboles/ObjetoNodo");
    //const {Atributo} = require("../../Scripts/clasesXML/Atributo");
	//const {Nodo} = require("../../Scripts/clasesXML/Nodo");\
	var AUXid=0;
		
	function unirErrores(){
		erroresGramar[0]= erroresLexicos ;
		erroresGramar[1]= erroresSintacticos;
		erroresGramar[2]=errorSemantico;
		
		console.log(erroresGramar.length);
		console.log(erroresGramar[0].length+'errores lexicos');
		console.log(erroresGramar[1].length+'errores sintacticos');
		console.log(erroresGramar[2].length +'errores semanticos');
	}

	function ingresarRegla(regla){
		if(reglas.length>0){
			var reglas2=[];
			reglas2.push(regla);
			reglas= reglas2.concat(reglas);
			console.log('agregando regla'+reglas.length+' --- '+regla.getProduccion());
		}else{
			reglas.push(regla);
			console.log('agregando regla'+reglas.length);
		}
	}

	function llenarArboles(ast,cst){
		ASTtree=ast;
		 CSTtree=ast;
	}
%}

/********************************************************* SINTACTICO ASCENDENTE *****************************************************/
%start S

%% /* Definición de la gramática */

S :
	RUTAS EOF
	{ 
			//AST
		var id =$1.idAST;

		//CST
		var padre =++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'S'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n}';
		//reglas semanticas
		//$$[0] = $1[0]; 
		$$  = new ObjetoA($1.objeto, id, padre);
		var regla = new Regla("GRAMATICAL","S-> RUTAS EOF",""); ingresarRegla(regla);
		console.log("DOT:",yy.dotCST+'}');
		console.log('-------------------------');
		console.log("DOT:",yy.dotAST+'}');
		llenarArboles(yy.dotAST,yy.dotCST);
		unirErrores();
		$$ = $1.objeto; 
		return $$; 
	}
	|error { 
			console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); 
			var error =  new Error( this._$.first_line ,  this._$.first_column, 'sintactico','xmldesc', yytext);
			erroresSintacticos.push(error); unirErrores(); 
	}
;


RUTAS :
	RUTAS concatenacion CONSULTAS
	 	{ 	
		//AST
		var padre1 =++yy.idAST;
		yy.dotAST+= padre1+' [label="'+$2.yytext+'"];'+'\n'; 
		yy.dotAST += padre1+'--'+$1.idAST+';'+'\n';
		yy.dotAST += padre1+'--'+$3.idCST+';'+'\n';
		//CST
		var padre =++yy.idCST;
		yy.dotCST+= padre+' [label="'+'RUTAS'+'"];'+'\n'; 
		var hijo =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'concatenacion'+'"];'+'\n'; 
		var hijo2 =++yy.idCST;
		yy.dotCST+= hijo2+' [label="'+$2.yy.text+'"];'+'\n'; 
		yy.dotCST += padre+'--'+$1.idCST+';'+'\n';
		yy.dotCST += padre+'--'+hijo+';'+'\n';
		yy.dotCST += padre+'--'+$3.idCST+';'+'\n';
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';
		//REGLAS SEMANTICAS	 
		//$1[0].push($3[0]); 
		//$$[0] = $1[0];
		var ob=  [$1.objeto];
		ob.push($3.objeto); 
		$$  = new ObjetoA(ob, padre1, padre);

		var regla = new ObjetoA("GRAMATICAL","RUTAS-> RUTAS concatenacion CONSULTAS",""); ingresarRegla(regla);
		}
	| CONSULTAS 
		{
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'ARREGLOS_ID'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoA($1.objeto, id, id2);
		$$= objeto;

		var regla = new Regla("GRAMATICAL","RUTAS-> CONSULTAS",""); ingresarRegla(regla);
		}
;

CONSULTAS:
	 CONSULTAS CONSULTA
	 	{ 	
		//AST
		var padre=  yy.idAST+' [label="'+'CONSULTAS'+'"];'+'\n'; 
		yy.dotAST += padre+'--'+$1.idAST+';'+'\n';
		yy.dotAST += padre+'--'+$2.idAST+';'+'\n';
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= id2+' [label="'+'CONSULTAS'+'"];'+'\n'; 
		yy.dotCST += id2+'--'+$1.idCST+';'+'\n';
		yy.dotCST += id2+'--'+$2.idCST+';'+'\n';
		//reglas gram
		var objet = [$1.objeto];
		objet.push($2.objeto); 
		var objeto = new ObjetoA(objet,padre, id2);
		$$=objeto;
		var regla = new Regla("GRAMATICAL","CONSULTA-> CONSULTAS CONSULTA",""); ingresarRegla(regla);
		}
	| CONSULTA
		{
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'CONSULTAS'+'"];'+'\n'; 
		yy.dotCST +=yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoA($1.objeto,id, id2);
		$$= objeto;

		var regla = new Regla("GRAMATICAL","CONSULTAS-> CONSULTA",""); ingresarRegla(regla);
		}
	|
	error CONSULTA
		{
			console.error('Este es un error sintáctico: ' + yytext + ', en la linea: ' + this._$.first_line + ', en la columna: ' + this._$.first_column); 
			var error =  new Error( this._$.first_line ,  this._$.first_column, 'sintactico','xmldesc', yytext);
			erroresSintacticos.push(error); unirErrores(); 
			$$=new ObjetoA('ERROR','', ' ');
		}
;

CONSULTA :
	DIAGONALES  
	{
		///AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= id2+' [label="'+'CONSULTA'+'"];'+'\n'; 
		yy.dotCST += id2+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoNodo($1.objeto,id, id2);
		$$= objeto;
		var regla = new Regla("GRAMATICAL","CONSULTA-> DIAGONALES",""); ingresarRegla(regla);
	}
	| TIPO_ID
	{
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= id2+' [label="'+'CONSULTA'+'"];'+'\n'; 
		yy.dotCST += id2+'--'+$1.idCST+';'+'\n';
		var objet = new ObjetoNodo($1.objeto,id, id2);
		$$= objet;

		var regla = new Regla("GRAMATICAL","CONSULTA-> TIPO_ID",""); ingresarRegla(regla);
	}
	| punto
	{
		//AST
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+'.'+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'CONSULTA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'punto'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+'.'+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		

		var ob = new SimbolosXpath(TiposXpath.PUNTO,@1.first_line, @1.first_column);
		$$=  new ObjetoA(ob,id, padre);
		
		var regla = new Regla("GRAMATICAL","CONSULTA-> punto",""); ingresarRegla(regla);
	}
	| dosPuntos
	{
		//AST
		var id =++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+':'+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'CONSULTA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'dosPuntos'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yy.text+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob = new SimbolosXpath(TiposXpath.DOSPUNTOSCONSECUTIVOS,@1.first_line, @1.first_column);
		$$=  new ObjetoA(ob,id, padre);
		var regla = new Regla("GRAMATICAL","CONSULTA-> dosPuntos",""); ingresarRegla(regla);
	}
	| FUNCION
	{
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		$$=  new ObjetoA($1.objeto,id, id2);
		
		var regla = new Regla("GRAMATICAL","CONSULTA-> FUNCION",""); ingresarRegla(regla);
	}
;

DIAGONALES:
	diagonalDoble SIMBOLOS  
	{
		var padre1 =++yy.idAST;
		yy.dotAST+= padre1+' [label="'+'DIAGONALES'+'"];'+'\n'; 
		var hijo =++yy.idAST;
		yy.dotAST+= hijo+' [label="'+'//'+'"];'+'\n'; 

		yy.dotAST += padre1+'--'+hijo+';'+'\n';
		yy.dotAST += padre1+'--'+$2.idAST+';'+'\n';

		var padre =++yy.idCST;
		yy.dotCST+= padre+' [label="'+'DIAGONALES'+'"];'+'\n'; 
		var hijo =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'diagonalDoble'+'"];'+'\n'; 
		var hijo1 =++yy.idCST;
		yy.dotCST+= hijo1+' [label="'+'//'+'"];'+'\n'; 
		yy.dotCST += padre+'--'+hijo+';'+'\n';
		yy.dotCST += padre+'--'+$2.getIdCST+';'+'\n';
		yy.dotCST += hijo+'--'+hijo1+';'+'\n';
		var ob = new diagonalDobleC($2.objeto, @1.first_line, @1.first_column);
		$$  = new ObjetoA(ob, padre1, padre);
		var regla = new Regla("GRAMATICAL","DIAGONALES-> diagonalDoble SIMBOLOS","crear nodos AST;\n Crear nodos CST;\n Return newDiagonalDoble;"); ingresarRegla(regla);
	} 
	| diagonal SIMBOLOS 
	{
		var padre1 =++yy.idAST;
		yy.dotAST+= padre1+' [label="'+'DIAGONALES'+'"];'+'\n'; 
		var hijo =++yy.idAST;
		yy.dotAST+= hijo+' [label="'+'/'+'"];'+'\n'; 

		yy.dotAST += padre1+'--'+hijo+';'+'\n';

		var padre =++yy.idCST;
		yy.dotCST+= padre+' [label="'+'DIAGONALES'+'"];'+'\n'; 
		var hijo =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'diagonal'+'"];'+'\n'; 
		var hijo1 =++yy.idCST;
		yy.dotCST+= hijo1+' [label="'+'/'+'"];'+'\n'; 
		yy.dotCST += padre+'--'+hijo+';'+'\n';
		yy.dotCST += padre+'--'+$2.idCST+';'+'\n';
		yy.dotCST += hijo+'--'+hijo1+';'+'\n';

		var ob = new diagonalSimpleS($2.objeto, @1.first_line, @1.first_column);
		$$  = new ObjetoA(ob, padre1, padre);

		
		var regla = new Regla("GRAMATICAL","DIAGONALES-> diagonal SIMBOLOS","crear nodos AST, crear nodos AST, retornar diagramas"); ingresarRegla(regla);
	}
;



SIMBOLOS:  
	arroba SIGUIENTE_ARROBA  {
		//CST
		var padre =++yy.idAST;
		yy.dotAST+= padre+' [label="'+'SIMBOLOS'+'"];'+'\n'; 
		var hijo =++yy.idAST;
		yy.dotAST+= hijo+' [label="'+'arroba'+'"];'+'\n'; 
		
		yy.dotAST += padre+'--'+hijo+';'+'\n';
		yy.dotAST += padre+'--'+$2.idAST+';'+'\n';
		//AST
		var padre =++yy.idCST;
		yy.dotCST+= padre+' [label="'+'SIMBOLOS'+'"];'+'\n'; 
		var hijo =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'arroba'+'"];'+'\n'; 
		yy.dotCST += padre+'--'+hijo+';'+'\n';
		yy.dotCST += padre+'--'+$2.idCST+';'+'\n';

		var ob = new Arroba($2.objeto, @1.first_line, @1.first_column); 
		$$  = new ObjetoA(ob, id, padre);

		var regla = new Regla("GRAMATICAL","SIMBOLOS-> arroba SIGUIENTE_ARROBA",""); ingresarRegla(regla);
	} 
	| asterisco   {
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+'*'+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.padre+' [label="'+'SIMBOLOS'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'asterisco'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+'*'+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob = new SimbolosXpath(TiposXpath.ASTERISCO,@1.first_line, @1.first_column);
		$$  = new ObjetoA(ob, id, padre);

		var regla = new Regla("GRAMATICAL","SIMBOLOS-> asterisco",""); ingresarRegla(regla);
	}
	| dosPuntosConsecutivos {//antes debe de haber un /id/ o //id/ etc, sino error semantico{
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+".."+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.padre+' [label="'+'SIMBOLOS'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'dosPuntosConsecutivos'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+'..'+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		

		var ob = new SimbolosXpath(TiposXpath.DOSPUNTOSCONSECUTIVOS,@1.first_line, @1.first_column);
		$$  = new ObjetoA(ob, id, padre);

		var regla = new Regla("GRAMATICAL","SIMBOLOS-> dosPuntosConsecutivos",""); ingresarRegla(regla);
	}
	| punto {//antes debe de haber un /id/  //id/ etc, sino error semantico{
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+'.'+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.padre+' [label="'+'SIMBOLOS'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'punto'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+'.'+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		var ob = new SimbolosXpath(TiposXpath.PUNTO,@1.first_line, @1.first_column);
		$$  = new ObjetoA(ob, id, padre);

		var regla = new Regla("GRAMATICAL","SIMBOLOS-> punto",""); ingresarRegla(regla);
	}
	| FUNCION{
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		$$=  new ObjetoA($1.objeto,id, id2);
		
		var regla = new Regla("GRAMATICAL","SIMBOLOS-> FUNCION",""); ingresarRegla(regla);
	}
	| METODOS{
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		$$=  new ObjetoA($1.objeto,id, id2);
		
		var regla = new Regla("GRAMATICAL","SIMBOLOS-> TIPO_ID",""); ingresarRegla(regla);
	}
	| TIPO_ID{
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		$$ =  new ObjetoA($1.objeto,id, id2);
		
		var regla = new Regla("GRAMATICAL","SIMBOLOS-> TIPO_ID",""); ingresarRegla(regla);
	}
;


SIGUIENTE_ARROBA :  //selecciona atributos *-> todos, o todos con un id
	identificador   {
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'SIGUIENTE_ARROBA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'identificador'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
				
		var ob = new Dato(yytext, @1.first_line, @1.first_column); 
		$$  = new ObjetoA(ob, id, padre);

		var regla = new Regla("GRAMATICAL","SIGUIENTE_ARROBA-> identificador",""); ingresarRegla(regla);
	}
	| asterisco   {
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+'*'+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'SIGUIENTE_ARROBA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'asterisco'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+'*'+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob = new SimbolosXpath(TiposXpath.ASTERISCO,@1.first_line, @1.first_column);

		$$  = new ObjetoA(ob, id, padre);

		var regla = new Regla("GRAMATICAL","SIGUIENTE_ARROBA-> asterisco",""); ingresarRegla(regla);
	}
;

FUNCION :
	funcionNode{
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+yytext+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'FUNCION'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'funcionNode'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yytext+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob = new Funcion(TiposXpath.FUNCION_NODE,@1.first_line, @1.first_column);

		$$  = new ObjetoA(ob, id, padre);

		var regla = new Regla("GRAMATICAL","FUNCION-> funcionNode",""); ingresarRegla(regla);
	}
	| funcionText{
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+yytext+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'FUNCION'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'funcionText'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yytext+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob = new Funcion(TiposXpath.FUNCION_TEXT,@1.first_line, @1.first_column);
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","FUNCION-> funcionText",""); ingresarRegla(regla);
	}
	|funcionLast{
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+yytext+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'FUNCION'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'funcionLast'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yy.text+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob = new Funcion(TiposXpath.FUNCION_LAST,@1.first_line, @1.first_column);
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","FUNCION-> funcionLast",""); ingresarRegla(regla);
	}
	|funcionPosition{
		var regla = new Regla("GRAMATICAL","FUNCION-> funcionPosition",""); ingresarRegla(regla);
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+yytext+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'FUNCION'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'funcionPosition'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yytext+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob = new Funcion(TiposXpath.FUNCION_POSITION,@1.first_line, @1.first_column);

		$$  = new ObjetoA(ob, id, padre);

	}
;


METODOS: //no puede venir sin antes especificar un nodo , no a la par de un id, puede venir despues de alguna diagonal o dentro del arreglo
	PALABRA_RESERVADA  dosPuntos dosPuntos SIGUIENTE_METODO {
		var id=++yy.idAST;
		yy.dotAST+= id+' [label="'+'::'+'"];'+'\n'; 
		yy.dotAST += id+'--'+$1.idAST+';'+'\n';
		yy.dotAST += id+'--'+$3.idAST+';'+'\n';

		var padre =++yy.idCST;
		yy.dotCST+= padre+' [label="'+'METODOS'+'"];'+'\n'; 
		var hijo =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'mas'+'"];'+'\n'; 
		var hijo2 =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'::'+'"];'+'\n'; 
		yy.dotCST += padre+'--'+$1.idCST+';'+'\n';
		yy.dotCST += padre+'--'+hijo+';'+'\n';
		yy.dotCST += padre+'--'+$3.idCST+';'+'\n';
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';

		var ob = new Metodo($1.objeto,$4.objeto,@1.first_line, @1.first_column);
		$$  = new ObjetoA(ob, id, padre);

		var regla = new Regla("GRAMATICAL","METODOS-> PALABRA_RESERVADA  dosPuntos dosPuntos SIGUIENTE_METODO",""); ingresarRegla(regla);
	}
;


PALABRA_RESERVADA:
	ancestor1{
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'ancestor1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob=TiposXpath.METODO_ANCESTOR;
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> ancestor1",""); ingresarRegla(regla);
	}
	| ancestor_or_self1	{
		var id =++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'ancestor_or_self1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		var ob =TiposXpath.METODO_ANCESTOR_OR_SELF;
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> ancestor_or_self1",""); ingresarRegla(regla);
	}
	| attribute1{
		
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'attribute1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		var ob=TiposXpath.METODO_ATRIBUTE;
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> attribute1",""); ingresarRegla(regla);
	}
	| child1{
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'child1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		 
		var ob=TiposXpath.METODO_CHILD;
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> child1",""); ingresarRegla(regla);
	}
	| descendant1{
		var id =++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'descendant1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		var ob =TiposXpath.METODO_DESCENDANT;

		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> descendant1",""); ingresarRegla(regla);
	}
	| descendant_or_self1	{
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+yytext+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'descendant_or_self1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yytext+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		var ob =TiposXpath.METODO_METODO_DESCENDANT_OR_SELF;
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> following1",""); ingresarRegla(regla);
	}
	| following1{
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+yytext+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'following1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yytext+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		var ob=TiposXpath.METODO_FOLLOWING;
		$$  = new ObjetoA(ob, id, padre);

		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> following1",""); ingresarRegla(regla);
	}
	| following_sibling1	{
		var ob=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+yytext+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'following_sibling1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yytext+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		 
		var ob=TiposXpath.METODO_FOLLOWING_SIGLING;
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> following_sibling1",""); ingresarRegla(regla);
	}
	| parent1{
		var id =++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+yytext+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'parent1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yytext+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		var ob=TiposXpath.METODO_PARENT;
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> preceding1",""); ingresarRegla(regla);
	}
	| preceding1{
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+yytext+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'preceding1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yytext+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob=TiposXpath.METODO_PRECEDING;
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> preceding1",""); ingresarRegla(regla);
	}
	| preceding_sibling1	{
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+yytext+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'preceding_sibling1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yytext+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob=TiposXpath.METODO_PRECEDING_SIBLING;
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> preceding_sibling1",""); ingresarRegla(regla);
	}
	| self1	{
		var id =++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+yytext+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'PALABRA_RESERVADA'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'self1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+yytext+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		$$[2]= padre;

		var ob= TiposXpath.METODO_SELF;
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","PALABRA_RESERVADA-> self1",""); ingresarRegla(regla);
	}
;

	
SIGUIENTE_METODO:
	FUNCION {
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'SIGUIENTE_METODO'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoA($1.objeto,id, id2);
		$$= objeto;

		var regla = new Regla("GRAMATICAL","SIGUIENTE_METODO-> FUNCION",""); ingresarRegla(regla);
	}
	| TIPO_ID {
		//AST
		var id = $1.idAST;
		//CST
		$$[2]=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'SIGUIENTE_METODO'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.getIdCST+';'+'\n';

		$$ =$1.objeto;
		var regla = new Regla("GRAMATICAL","SIGUIENTE_METODO-> punto",""); ingresarRegla(regla);
	}
	| asterisco {//a partir de aqui verificar que sea logico para ver si se toma o no estas 3 producciones{
		var id =++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'SIGUIENTE_METODO'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'asterisco'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob = new SimbolosXpath(TiposXpath.ASTERISCO,@1.first_line, @1.first_column);
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","SIGUIENTE_METODO-> punto",""); ingresarRegla(regla);
	}
	| punto {
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'SIGUIENTE_METODO'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'punto'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		var ob = new SimbolosXpath(TiposXpath.PUNTO,@1.first_line, @1.first_column);
		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","SIGUIENTE_METODO-> punto","return nuevo tipoSImboloXPATH"); ingresarRegla(regla);
	}
	| dosPuntos {
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'SIGUIENTE_METODO'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'dosPuntos'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var ob= new SimbolosXpath(TiposXpath.DOSPUNTOSCONSECUTIVOS,@1.first_line, @1.first_column);

		$$  = new ObjetoA(ob, id, padre);
		var regla = new Regla("GRAMATICAL","SIGUIENTE_METODO-> dosPuntos",""); ingresarRegla(regla);
	}
;

TIPO_ID :
	identificador  {//bookstore{
		var id=++yy.idAST;
		yy.dotAST+= id+' [label="'+$1+'"];'+'\n'; 

		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= padre+' [label="'+'TIPO_ID'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'identificador'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		console.log('padre+'+ padre);
		
		var idS= new IdSimple($1,@1.first_line, @1.first_column);
		$$  = new ObjetoA(idS, id, padre);
		var regla = new Regla("GRAMATICAL","ARREGLO_ID-> identificador","return idSimple"); ingresarRegla(regla);
	}
	| identificador ARREGLOS_ID  { // booksotre[ operaciones ]{
		var padre1 =++yy.idAST;
		yy.dotAST+= padre1+' [label="'+'TIPO_ID'+'"];'+'\n'; 
		var hijo =++yy.idAST;
		yy.dotAST+= hijo+' [label="'+$1+'"];'+'\n'; 

		yy.dotAST += padre1+'--'+hijo+';'+'\n';
		yy.dotAST += padre1+'--'+$2.idAST+';'+'\n';

		var padre =++yy.idCST;
		yy.dotCST+= padre+' [label="'+'TIPO_ID'+'"];'+'\n'; 
		var hijo =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'identificador'+'"];'+'\n'; 
		var hijo1 =++yy.idCST;
		yy.dotCST+= hijo1+' [label="'+$1+'"];'+'\n'; 
		yy.dotCST += padre+'--'+hijo+';'+'\n';
		yy.dotCST += padre+'--'+$2.idCST+';'+'\n';
		yy.dotCST += hijo+'--'+hijo1+';'+'\n';

		var obj = new IdCompuesto($1,$2.objeto,@1.first_line, @1.first_column);

		$$  = new ObjetoA(obj, padre1, padre);
		var regla = new Regla("GRAMATICAL","ARREGLO_ID-> identificador ARREGLOS_ID",""); ingresarRegla(regla);
	}
;

ARREGLOS_ID : 
	//$1=2			$2=3
	ARREGLOS_ID ARREGLO_ID{
		//AST
		var padre1 =++yy.idAST;
		yy.dotAST+= padre1+' [label="'+'ARREGLOS_ID'+'"];'+'\n'; 

		yy.dotAST += padre1+'--'+$1.idAST+';'+'\n';
		yy.dotAST += padre1+'--'+$2.idAST+';'+'\n';

		//CST		6
		var padre=++yy.idCST;
		yy.dotCST+= padre+' [label="'+'ARREGLOS_ID'+'"];'+'\n'; 
		yy.dotCST += padre+'--'+$1.idCST+';'+'\n';
		yy.dotCST += padre+'--'+$2.idCST+';'+'\n';
		var obj = $1.objeto;
		obj.push($2.objeto); 		
		$$  = new ObjetoA(obj, padre1, padre);
		var regla = new Regla("GRAMATICAL","ARREGLO_ID-> ARREGLOS_ID ARREGLO_ID","agregar Arreglo_ID a arreglos,\n return arrreglos;"); ingresarRegla(regla);
	}
	| ARREGLO_ID {
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'ARREGLOS_ID'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoA($1.objeto,id, id2);
		$$= objeto;

		var regla = new Regla("GRAMATICAL","ARREGLO_ID->  corcheteAbierto OPERACIONES_ARREGLO corcheteCerrado",""); ingresarRegla(regla);
	}
;

ARREGLO_ID:
	corcheteAbierto OPERACIONES_ARREGLO corcheteCerrado{
		//AST
		var id = $2.idAST;
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'F'+'"];'+'\n'; 

		var hijo1 =++yy.idCST;										
		yy.dotCST+= hijo1+' [label="'+'corcheteAbierto'+'"];'+'\n';	
		var hijo12 =++yy.idCST;										
		yy.dotCST+= hijo12+' [label="'+'['+'"];'+'\n';	

		var hijo2 =++yy.idCST;										
		yy.dotCST+= hijo2+' [label="'+'corcheteCerrado'+'"];'+'\n';			
		var hijo22 =++yy.idCST;										
		yy.dotCST+= hijo22+' [label="'+']'+'"];'+'\n';				

		yy.dotCST +=padre+'--'+hijo1+';'+'\n';						
		yy.dotCST += padre+'--'+$2.idCST+';'+'\n';	
		yy.dotCST += padre+'--'+hijo2+';'+'\n';						
		yy.dotCST += hijo1+'--'+hijo12+';'+'\n';			
		yy.dotCST += hijo2+'--'+hijo22+';'+'\n';			

		var ob = new Predicado($2.objeto,@1.first_line, @1.first_column);	
		var objeto = new ObjetoNodo(ob, id, padre);
		$$= objeto;
		var regla = new Regla("GRAMATICAL","ARREGLO_ID->  corcheteAbierto OPERACIONES_ARREGLO corcheteCerrado","return new Predicado"); ingresarRegla(regla);
	}
;

OPERACIONES_ARREGLO:
	OPERACION_LOGICA{
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'ARREGLOS_ID'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoNodo($1.objeto,id, id2);
		$$= objeto;

		var regla = new Regla("GRAMATICAL","OPERACIONES_ARREGLO->  OPERACION_LOGICA ","return OPERACION_LOGICA"); ingresarRegla(regla);
	}
	| OPERACION_RELACIONAL{
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'ARREGLOS_ID'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoNodo($1.objeto,id, id2);
		$$= objeto;

		var regla = new Regla("GRAMATICAL","OPERACIONES_ARREGLO->  OPERACION_RELACIONAL ","return OPERACION_RELACIONAL"); ingresarRegla(regla);
	}
;

OPERACION_LOGICA:
	OPERACION_RELACIONAL SIMBOLOS_LOGICOS OPERACION_RELACIONAL{
		//AST=
		yy.dotAST += $2.idAST+'--'+$1.idAST+';'+'\n';
		yy.dotAST += $2.idAST+'--'+$3.idAST+';'+'\n';
		//CST
		var id =++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'OPERACION_LOGICA'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		yy.dotCST += yy.idCST+'--'+$2.idCST+';'+'\n';
		yy.dotCST += yy.idCST+'--'+$3.idCST+';'+'\n';

		var opL = new OperacionLogica($1.objeto,$3.objeto,$2.objeto,@1.first_line, @1.first_column);
		
		$$ = ObjetoA(opL, $2.idAST, id);;

		var regla = new Regla("GRAMATICAL","OPERACION_LOGICA->  OPERACION_RELACIONAL SIMBOLOS_LOGICOS OPERACION_RELACIONAL",""); ingresarRegla(regla);
	}
;

SIMBOLOS_LOGICOS:
	and1{
		//AST
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS_RELACIONALES'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'and1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		$$ = new ObjetoA( Operador.AND, id, padre);

		var regla = new Regla("GRAMATICAL","SIMBOLOS_LOGICOS->  and1",""); ingresarRegla(regla);
	}
	| or1{
		//AST
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS_RELACIONALES'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'or1'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		$$ = new ObjetoA(Operador.OR , id, padre);

		var regla = new Regla("GRAMATICAL","SIMBOLOS_LOGICOS->  or1",""); ingresarRegla(regla);
	}
;




SIMBOLOS_RELACIONALES:
	mayorque{
		//AST
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS_RELACIONALES'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'mayorque'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		$$ = new ObjetoA($1 , id, padre);

		var regla = new Regla("GRAMATICAL","SIMBOLOS_RELACIONALES->  mayorque",""); ingresarRegla(regla);
	}
	| menorque{
		//AST
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS_RELACIONALES'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'menorque'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		$$ = new ObjetoA($1 , id, padre);
		var regla = new Regla("GRAMATICAL","TIPOIGUALAR-> decimal",""); ingresarRegla(regla);
	}
	| mayorIgual{
		//AST
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS_RELACIONALES'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'mayorIgual'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		$$ = new ObjetoA($1,id, padre);
		var regla = new Regla("GRAMATICAL","TIPOIGUALAR-> decimal",""); ingresarRegla(regla);
	}
	| menorIgual{
		//AST
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS_RELACIONALES'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'menorIgual'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		$$ = new ObjetoA($1,id, padre);
		var regla = new Regla("GRAMATICAL","TIPOIGUALAR-> decimal",""); ingresarRegla(regla);
	}
	| igual{
		//AST
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS_RELACIONALES'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'igual'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		$$ = new ObjetoA($1 ,id , padre);
		var regla = new Regla("GRAMATICAL","TIPOIGUALAR-> decimal",""); ingresarRegla(regla);

	}
	| diferenteQue{
		//AST
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'SIMBOLOS_RELACIONALES'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'diferenteQue'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
	
		$$ = new ObjetoA($1,id, padre);
		var regla = new Regla("GRAMATICAL","TIPOIGUALAR-> decimal",""); ingresarRegla(regla);
	}
;


OPERACION_ARITMETICA :
	OPERACION_ARITMETICA mas T1{
		var padre1 =++yy.idAST;
		yy.dotAST+= padre1+' [label="'+'asterisco'+'"];'+'\n'; 
		yy.dotAST += padre1+'--'+$1.idAST+';'+'\n';
		yy.dotAST += padre1+'--'+$3.idAST+';'+'\n';

		var padre =++yy.idCST;
		yy.dotCST+= padre+' [label="'+'OPERACION_ARITMETICA'+'"];'+'\n'; 
		var hijo =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'asterisco'+'"];'+'\n'; 
		var hijo2 =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'*'+'"];'+'\n'; 
		yy.dotCST += padre+'--'+$1.idCST+';'+'\n';
		yy.dotCST += padre+'--'+hijo+';'+'\n';
		yy.dotCST += padre+'--'+$3.idCST+';'+'\n';
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';

		var opA = new OperacionAritmetica($1.objeto ,$3.objeto ,Operador.SUMA,@1.first_line, @1.first_column);
		var objeto = new ObjetoA(opA,padre1, padre);
		$$ = objeto;
		var regla = new Regla("GRAMATICAL","OPERACION_ARITMETICA-> OPERACION_ARITMETICA mas T1","crear nodos AST; crear nodos CST; Return nuevaOperacion Aritmetica SUMA;"); ingresarRegla(regla);
	}
	| OPERACION_ARITMETICA menos T1{
		var padre1 =++yy.idAST;
		yy.dotAST+= padre1+' [label="'+'asterisco'+'"];'+'\n'; 
		yy.dotAST += padre1+'--'+$1.idAST+';'+'\n';
		yy.dotAST += padre1+'--'+$3.idAST+';'+'\n';

		var padre =++yy.idCST;
		yy.dotCST+= padre+' [label="'+'OPERACION_ARITMETICA'+'"];'+'\n'; 
		var hijo =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'asterisco'+'"];'+'\n'; 
		var hijo2 =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'*'+'"];'+'\n'; 
		yy.dotCST += padre+'--'+$1.idCST+';'+'\n';
		yy.dotCST += padre+'--'+hijo+';'+'\n';
		yy.dotCST += padre+'--'+$3.idCST+';'+'\n';
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';
		
		var opA = new OperacionAritmetica($1.objeto,$3.objeto,Operador.RESTA,@1.first_line, @1.first_column);
		var objeto = new ObjetoA(opA,padre1, padre);
		$$ = objeto;
		var regla = new Regla("GRAMATICAL","OPERACION_ARITMETICA-> OPERACION_ARITMETICA menos T1","crear nodos AST; crear nodos CST; Return nuevaOperacion Aritmetica RESTA;"); ingresarRegla(regla);
	}
	| T1 {
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'OPERACION_ARITMETICA'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoA($1.objeto,id, id2);
		$$= objeto;
		var regla = new Regla("GRAMATICAL","OPERACION_ARITMETICA-> T1 ","crear nodos AST; crear nodos CST; Return T1"); ingresarRegla(regla);
	}
;

T1 : 
	T1 modulo T {
		var padre1 =++yy.idAST;
		yy.dotAST+= padre1+' [label="'+'%'+'"];'+'\n'; 
		yy.dotAST += padre1+'--'+$1.idAST+';'+'\n';
		yy.dotAST += padre1+'--'+$3.idAST+';'+'\n';

		var padre =++yy.idCST;
		yy.dotCST+= padre+' [label="'+'T'+'"];'+'\n'; 
		var hijo =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'modulo'+'"];'+'\n'; 
		var hijo2 =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'%'+'"];'+'\n'; 
		yy.dotCST += padre+'--'+$1.idCST+';'+'\n';
		yy.dotCST += padre+'--'+hijo+';'+'\n';
		yy.dotCST += padre+'--'+$3.idCST+';'+'\n';
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';

		var opA= new OperacionAritmetica($1.objeto ,$3.objeto ,Operador.MODULO,@1.first_line, @1.first_column);
		
		var objeto = new ObjetoA(opA,padre1, padre);
		$$ = objeto;

		var regla = new Regla("GRAMATICAL","T1-> T1 modulo T",""); ingresarRegla(regla);
	}
	| T{
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'T1'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoA($1.objeto,id, id2);
		$$= objeto;

		var regla = new Regla("GRAMATICAL","T1-> T",""); ingresarRegla(regla);
	}
;

T : 
	T asterisco F {
		var padre1 =++yy.idAST;
		yy.dotAST+= padre1+' [label="'+'asterisco'+'"];'+'\n'; 
		yy.dotAST += padre1+'--'+$1.idAST+';'+'\n';
		yy.dotAST += padre1+'--'+$3.idAST+';'+'\n';

		var padre =++yy.idCST;
		yy.dotCST+= padre+' [label="'+'T'+'"];'+'\n'; 
		var hijo =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'asterisco'+'"];'+'\n'; 
		var hijo2 =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'*'+'"];'+'\n'; 
		yy.dotCST += padre+'--'+$1.idCST+';'+'\n';
		yy.dotCST += padre+'--'+hijo+';'+'\n';
		yy.dotCST += padre+'--'+$3.idCST+';'+'\n';
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';
		
		var opA = new OperacionAritmetica($1.objeto,$3.objeto ,Operador.MULTIPLICACION,@1.first_line, @1.first_column);
		var objeto = new ObjetoA(opA,padre1, padre);
		$$ = objeto;
		var regla = new Regla("GRAMATICAL","T-> T asterisco F ",""); ingresarRegla(regla);
	}
	| T dividir F{
		var padre1 =++yy.idAST;
		yy.dotAST+= padre1+' [label="'+'/'+'"];'+'\n'; 
		yy.dotAST += padre1+'--'+$1.idAST+';'+'\n';
		yy.dotAST += padre1+'--'+$3.idAST+';'+'\n';

		var padre =++yy.idCST;
		yy.dotCST+= padre+' [label="'+'T'+'"];'+'\n'; 
		var hijo =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'dividir'+'"];'+'\n'; 
		var hijo2 =++yy.idCST;
		yy.dotCST+= hijo+' [label="'+'/'+'"];'+'\n'; 
		yy.dotCST += padre+'--'+$1.idCST+';'+'\n';
		yy.dotCST += padre+'--'+hijo+';'+'\n';
		yy.dotCST += padre+'--'+$3.idCST+';'+'\n';
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';
		
		var opA = new OperacionAritmetica($1.objeto,$3.objeto,Operador.DIVISION,@1.first_line, @1.first_column);
		var objeto = new ObjetoA(opA,padre1, padre);
		$$ = objeto;
		var regla = new Regla("GRAMATICAL","T-> T dividir F",""); ingresarRegla(regla);
	}
	| F {
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'T'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoA($1.objeto,id, id2);
		$$= objeto;

		var regla = new Regla("GRAMATICAL","T-> F","devolver nodoAAST, crear NodoCST, devolver F;"); ingresarRegla(regla);
	}
;

F : 
	TIPOIGUALAR {
		
		//AST
		var id = $1.idAST;
		//CST
		var id2=++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'F'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoNodo($1.objeto,id, id2);
		$$= objeto;

		var regla = new Regla("GRAMATICAL","F-> TIPOIGUALAR",""); ingresarRegla(regla);
	}
	| parizq OPERACION_ARITMETICA parder {
		//AST
		var id =$2.idAST;
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'F'+'"];'+'\n';  
		var hijo1 =++yy.idCST;										
		yy.dotCST+= hijo1+' [label="'+'parizq'+'"];'+'\n';			 
		var hijo12 =++yy.idCST;										
		yy.dotCST+= hijo12+' [label="'+'('+'"];'+'\n';				
		var hijo2 =++yy.idCST;										
		yy.dotCST+= hijo2+' [label="'+'parder'+'"];'+'\n';			
		var hijo22 =++yy.idCST;										
		yy.dotCST+= hijo22+' [label="'+')'+'"];'+'\n';				

		yy.dotCST +=padre+'--'+hijo1+';'+'\n';						
		yy.dotCST += padre+'--'+$2.idCST+';'+'\n';	
		yy.dotCST += padre+'--'+hijo2+';'+'\n';						
		yy.dotCST += hijo1+'--'+hijo12+';'+'\n';			
		yy.dotCST += hijo2+'--'+hijo22+';'+'\n';		

		$$ = new ObjetoNodo($2.objeto,id, padre);

		var regla = new Regla("GRAMATICAL","F-> parizq OPERACION_ARITMETICA parder",""); ingresarRegla(regla);
	}
;

TIPOIGUALAR:
	entero{
		var id =++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'TIPO_IGUALAR'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'entero'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7

		var dato = new Dato($1, @1.first_line, @1.first_column); 

		$$ = new ObjetoNodo(dato,id, padre);

		var regla = new Regla("GRAMATICAL","TIPOIGUALAR-> entero",""); ingresarRegla(regla);
	}
	| decimal {
		//AST
		var id=++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'TIPO_IGUALAR'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'decimal'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		
		var dato = new Dato($1, @1.first_line, @1.first_column); 
		$$ = new ObjetoA(dato,id, padre);
		var regla = new Regla("GRAMATICAL","TIPOIGUALAR-> decimal",""); ingresarRegla(regla);

	}
	| arroba SIGUIENTE_ARROBA{
		
		var padre2 =++yy.idAST;
		yy.dotAST+= padre2+' [label="'+'SIMBOLOS'+'"];'+'\n'; 
		var hijo =++yy.idAST;
		yy.dotAST+= hijo+' [label="'+'arroba'+'"];'+'\n'; 

		yy.dotAST += padre2+'--'+hijo+';'+'\n';
		yy.dotAST += padre2+'--'+$2.idAST+';'+'\n';
		
		
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'TIPOIGUALAR'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'arroba'+'"];'+'\n';			// yydotCST += 6 [label='arroba'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+'@'+'"];'+'\n';				// yydotCST += 7 [label='@'];

		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += padre+'--'+$2.idCST+';'+'\n';						//	yydotCST+= 5 -- 4
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotcst+= 6 -- 7 

		var arroba = new Arroba($2, @1.first_line, @1.first_column);

		$$ = new ObjetoA(arroba, padre2, padre);

		var regla = new Regla("GRAMATICAL","TIPOIGUALAR-> SIGUIENTE_ARROBA","retorna nuevo objeto(objetoA, idAST,idCST);;"); ingresarRegla(regla);//return 5;
	}
	| cadena{
		//AST
		var id =++yy.idAST;
		yy.dotAST+= yy.idAST+' [label="'+$1+'"];'+'\n'; 
		//CST
		var padre=++yy.idCST;//padre = 5;
		yy.dotCST+= yy.idCST+' [label="'+'TIPO_IGUALAR'+'"];'+'\n';  // yydotCST += 5 [label='TIPOIGUALAR'];
		var hijo =++yy.idCST;										// hijo = 6; 
		yy.dotCST+= hijo+' [label="'+'cadena'+'"];'+'\n';			// yydotCST += 6 [label='cadena'];
		var hijo2 =++yy.idCST;										// hijo2 = 7; 
		yy.dotCST+= hijo2+' [label="'+$1+'"];'+'\n';				// yydotCST += 7 [label='@'];
		yy.dotCST +=padre+'--'+hijo+';'+'\n';						//	yydotCST+= 5 -- 6
		yy.dotCST += hijo+'--'+hijo2+';'+'\n';						//	yydotCST+= 6 -- 7
		var dato = new Dato($1, @1.first_line, @1.first_column); 
		$$ = new ObjetoA(dato,id, padre);
		var regla = new Regla("GRAMATICAL","TIPOIGUALAR-> cadena","retorna objetoA(nuevoDato, idAst, idCst);"); ingresarRegla(regla);
	}
	| CONSULTAS{
		var id =$1.idAST;
		var id2 =++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'TIPO_IGUALAR'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoA($1.objeto,id, id2);

		var regla = new Regla("GRAMATICAL","TIPOIGUALAR-> CONSULTAS",""); ingresarRegla(regla);
		$$ = objeto;
	}
	| METODOS{
		var id =$1.idAST;

		var id2 =++yy.idCST;
		yy.dotCST+= yy.idCST+' [label="'+'TIPO_IGUALAR'+'"];'+'\n'; 
		yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
		var objeto = new ObjetoA($1.objeto,id, id2);

		var regla = new Regla("GRAMATICAL","TIPOIGUALAR-> METODOS",""); ingresarRegla(regla);
		$$ = objeto;
	}
;

OPERACION_RELACIONAL :
		OPERACION_ARITMETICA SIMBOLOS_RELACIONALES OPERACION_ARITMETICA{
			yy.dotAST += $2.idAST+'--'+$1.idAST+';'+'\n';
			yy.dotAST += $2.idAST+'--'+$3.idAST+';'+'\n';
			var id =$2.idAST;

			var padre =++yy.idCST;
			yy.dotCST+= padre+' [label="'+'OPERACION_RELACIONAL'+'"];'+'\n'; 
			yy.dotCST += padre+'--'+$1.idCST+';'+'\n';
			yy.dotCST += padre+'--'+$2.idCST+';'+'\n';
			yy.dotCST += padre+'--'+$3.idCST+';'+'\n';

			var opR = new OperacionRelacional($1.objeto,$3.objeto,$2.objeto,@1.first_line, @1.first_column);
			var objeto = new ObjetoA(opR,id, padre);
			var regla = new Regla("GRAMATICAL","OPERACION_RELACIONAL->  PERACION_ARITMETICA SIMBOLOS_RELACIONALES OPERACION_ARITMETICA","");
			ingresarRegla(regla);
			$$ = objeto;
		}
		| OPERACION_ARITMETICA {
			//AST
			var id = $1.idAST;
			//CST
			var id2=++yy.idCST;
			yy.dotCST+= yy.idCST+' [label="'+'OPERACION_RELACIONAL'+'"];'+'\n'; 
			yy.dotCST += yy.idCST+'--'+$1.idCST+';'+'\n';
			var objeto = new ObjetoA($1.objeto,id, id2);
			$$= objeto;
			var regla = new Regla("GRAMATICAL","OPERACION_RELACIONAL->  OPERACION_ARITMETICA",""); ingresarRegla(regla);
		}
;
