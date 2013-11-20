package com.app.sgpod

class CartaDeInstruccionDeRevocacion extends CartaDeInstruccion {

    static belongsTo = [ revocacionDePoder : RevocacionDePoder ]
    
    static constraints = {
        revocacionDePoder nullable:false
    }
}
