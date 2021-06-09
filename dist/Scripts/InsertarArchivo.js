var contenidoGeneral ;

var inputElement = document.getElementById("abrir");
inputElement.addEventListener("change", leerArchivo, false);

function ingresarTexto(item) {
    contenido = document.getElementById(item).firstChild.value;
    //console.log(contenido + '88')
}


function leerArchivo(e) {
    
    var archivo = e.target.files[0];
    if (!archivo) {
      return;
    }
    var lector = new FileReader();
    lector.onload = function(e) {
      var contenido = e.target.result;
      mostrarContenido(contenido);
      contenidoGeneral = contenido;
      console.log(contenido);
    };
    lector.readAsText(archivo);
};

function mostrarContenido(contenido){
    var editor = document.getElementById('editor');
    editor.value=contenido;
}

function limpiar(){
    var editor = document.getElementById('editor');
    editor.value="";
}



