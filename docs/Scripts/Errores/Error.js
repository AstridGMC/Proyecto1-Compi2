"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Error = void 0;
var Error = /** @class */ (function () {
    function Error(linea, columna, tipo, tipo_documento, lexema) {
        this.linea = linea;
        this.columna = columna;
        this.tipo = tipo;
        this.tipo_documento = tipo_documento;
        this.lexema = lexema;
    }
    return Error;
}());
exports.Error = Error;
