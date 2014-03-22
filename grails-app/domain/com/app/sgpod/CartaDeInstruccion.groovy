package com.app.sgpod
/**
* Domain class para generar la carta de intrucción.
*/
class CartaDeInstruccion {
    /**
    * numero de registro de la carta de instrucción.
    */
    String registro
    
    String fecha
    /**
    * Fecha de la carta de instrucción.
    */
    String contenido
    /**
    * Fecha de creación.
    */
    Date dateCreated
    /**
    * Fecha de última actualización.
    */
    Date lastUpdated
    
    static constraints = {
        registro blank:false
        fecha blank:false
        contenido blank:false, maxSize:1048576
    }
}
