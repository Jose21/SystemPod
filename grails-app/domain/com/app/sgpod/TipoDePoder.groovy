package com.app.sgpod

/**
*  Domain class que define el tipo de poder en una solicitud.
*/
class TipoDePoder {
    
    /**
    * Nombre del tipo de poder.
    */
    String nombre
    /**
    * Esta es la relación que tiene con otras tablas en una relacion tipo  1-n.
    */
    static hasMany = [categorias:CategoriaDeTipoDePoder]

    static constraints = {
    }
}
