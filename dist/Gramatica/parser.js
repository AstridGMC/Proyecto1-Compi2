var fs = require('fs');
var parser = require('./src/js/gramar-xml');
function ejecutarCodigo(entrada) {
    var objetos = parser.parse(entrada);
}
ejecutarCodigo("<libro>"+
                    "<autor apellido = \"aaa\"  apellido = \"aaa\" >"+
                        "<nombre>eee</nombre>"+
                    "</autor>"+           
                "</libro>"+
                "<libro>"+
                    "<autor>"+
                        "<nombre apellido = \"aaa\"  apellido = \"aaa\">eee</nombre>"+
                    "</autor>"+ 
                "</libro>"+
                "<libro>"+
                    "<autor></autor>"+
                "</libro>"+ 
                "<libro></libro>");
