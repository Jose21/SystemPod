package com.app.sgpod

class CategoriaDeTipoDePoder {
    
    String nombre
    
    static belongsTo = [tipoDePoder:TipoDePoder]

    static constraints = {
    }
}
