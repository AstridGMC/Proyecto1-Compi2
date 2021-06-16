var gramatica = require('./gramarxmldes');
function ejecutarCodigo(entrada) {
    var objetos = gramatica.parse(entrada);
    //const ast:AST = new AST(instrucciones);
    //instrucciones.forEach((element:Instruccion) => {
    //    element.ejecutar(entornoGlobal,ast);
    //});


}
ejecutarCodigo(`
<biblioteca>
<libro>
<!-- hola -->
  <titulo> La vida esta en otra parte</titulo>
  <autor>Milan Kundera</autor>
  <fechaPublicacion año="1973"/>
</libro>
<libro>
  <titulo>Pantaleon y las visitadoras</titulo>
  <autor fechaNacimiento="28/03/1936">Mario Vargas Llosa</autor>
  <fechaPublicacion/>
</libro>
<libro>
  <titulo>Conversacion en la catedral</titulo>
  <autor fechaNacimiento="28/03/1936">Mario Vargas Llosa</autor>
  <fechaPublicacion año="1969"/>
</libro>
</biblioteca>
`);