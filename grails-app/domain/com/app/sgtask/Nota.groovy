package com.app.sgtask

import com.app.security.Usuario

class Nota {

    String titulo
    String descripcion 
    Date dateCreated
    Date lastUpdated
    Usuario agregadaPor
    
    static belongsTo = [ tarea : Tarea ]
    
    static hasMany = [ documentos : Documento ]
    
    static constraints = {
        titulo blank:false
        descripcion blank:true, maxSize:10240
        tarea nullable:true
        documentos nullable:true
        agregadaPor nullable:false
    }
    
    static mapping = {
        autoTimestamp true
    }
}
