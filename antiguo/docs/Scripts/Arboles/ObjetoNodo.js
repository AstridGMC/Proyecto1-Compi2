"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ObjetoNodo = void 0;
var Entorno_1 = require("../Arboles/Entorno");
var ObjetoNodo = /** @class */ (function () {
    function ObjetoNodo(id, texto, linea, columna, listaAtributos, listaO) {
        this.identificador = id;
        this.texto = texto;
        this.linea = linea;
        this.columna = columna;
        this.listaAtributos = listaAtributos;
        this.listaObjetos = listaO;
        this.entorno = new Entorno_1.Entorno(null);
    }
    return ObjetoNodo;
}());
exports.ObjetoNodo = ObjetoNodo;
