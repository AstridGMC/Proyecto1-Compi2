export class Regla{
  tipo: Tipo_Regla;
  produccion: string;
  reglaSemantica: string;

  constructor(tipo: Tipo_Regla, produccion: string, reglaSemantica:string) {
    this.tipo = tipo;
    this.produccion = produccion;
    this.reglaSemantica = reglaSemantica;
  }

}

export enum Tipo_Regla {
  SUMA,
  RESTA,
  MULTIPLICACION,
  DIVISION,
  MODULO,
  MENOS_UNARIO,
  MAYOR_QUE,
  MENOR_QUE,
  IGUAL_IGUAL,
  DIFERENTE_QUE,
  OR,
  AND,
  NOT,
  MAYOR_IGUA_QUE,
  MENOR_IGUA_QUE,
  DESCONOCIDO
}