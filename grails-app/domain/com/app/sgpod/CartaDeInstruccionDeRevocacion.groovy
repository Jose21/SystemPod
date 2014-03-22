package com.app.sgpod

/**
* Domian class hija de la domain class cartaDeInstrucción, que hereda las propiedades de la misma.
*/
class CartaDeInstruccionDeRevocacion extends CartaDeInstruccion {

    static belongsTo = [ revocacionDePoder : RevocacionDePoder ]
    
    static constraints = {
        revocacionDePoder nullable:false
    }
}
