package com.app.sgpod

/**
* Domain class que contiene la plantilla principal de la carta de instrucción.
*/
class FormatoDeCartaDeInstruccion {
    /**
    * Registro de la solicitud.
    */
    String registro
    /**
    * Fecha de la carta de instrucción.
    */
    String fecha
    /**
    * Cuerpo de la carta de instrucción.
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
