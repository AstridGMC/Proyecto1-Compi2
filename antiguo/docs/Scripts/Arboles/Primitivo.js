"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Primitivo = void 0;
var Primitivo = /** @class */ (function () {
    function Primitivo(valor, linea, columna) {
        this.linea = linea;
        this.columna = columna;
        this.valor = valor;
    }
    Primitivo.prototype.getValor = function () {
        return this.valor;
    };
    Primitivo.prototype.getLinea = function () {
        return this.linea;
    };
    Primitivo.prototype.getColumna = function () {
        return this.columna;
    };
    Primitivo.prototype.getTipo = function (ent, arbol) {
        var valor = this.getValorImplicito(ent, arbol);
        /*if (typeof(valor) === 'boolean')
        {
            return Tipo.BOOL;
        }*/
        if (typeof (valor) === 'string') {
            return Tipo_1.Tipo.STRING;
        }
        else if (typeof (valor) === 'number') {
            if (this.isInt(Number(valor))) {
                return Tipo_1.Tipo.INT;
            }
            return Tipo_1.Tipo.DOUBLE;
        }
        return Tipo_1.Tipo.STRUCT;
    };
    Primitivo.prototype.getValorImplicito = function (ent, arbol) {
        return this.valor;
    };
    Primitivo.prototype.isInt = function (n) {
        return Number(n) === n && n % 1 === 0;
    };
    return Primitivo;
}());
exports.Primitivo = Primitivo;
