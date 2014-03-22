package com.app.sgpod
/**
* Domian class hija de la domain class cartaDeInstrucción, que hereda las propiedades de la misma.
*/

class CartaDeInstruccionDeOtorgamiento extends CartaDeInstruccion {
    
    static belongsTo = [ otorgamientoDePoder : OtorgamientoDePoder ]
    
    static constraints = {
        otorgamientoDePoder nullable:false
    }
}
