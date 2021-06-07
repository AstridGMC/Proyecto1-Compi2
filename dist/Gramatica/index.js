var gramatica = require('./gramarxml');
function ejecutarCodigo(entrada) {
    var objetos = gramatica.parse(entrada);
    //const ast:AST = new AST(instrucciones);
    //instrucciones.forEach((element:Instruccion) => {
    //    element.ejecutar(entornoGlobal,ast);
    //});

}
ejecutarCodigo("//bookstore/book");
