package com.app.sgpod

class TipoDePoder {
    
    String nombre
    
    static hasMany = [categorias:CategoriaDeTipoDePoder]

    static constraints = {
    }
}
