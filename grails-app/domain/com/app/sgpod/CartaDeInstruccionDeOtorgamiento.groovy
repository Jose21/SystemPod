package com.app.sgpod

class CartaDeInstruccionDeOtorgamiento extends CartaDeInstruccion {

    static belongsTo = [ otorgamientoDePoder : OtorgamientoDePoder ]
    
    static constraints = {
        otorgamientoDePoder nullable:false
    }
}
