package com.app.sgpod

class FormatoDeCartaDeInstruccion {

    String registro
    String fecha
    String contenido
    
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        registro blank:false
        fecha blank:false
        contenido blank:false, maxSize:1048576
    }
}
