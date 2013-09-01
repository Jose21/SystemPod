package com.app.sgtask

class Nota {

    String titulo
    String descripcion 
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [ tarea : Tarea ]
    
    static hasMany = [ documentos : Documento ]
    
    static constraints = {
        titulo blank:false
        descripcion blank:true, maxSize:10240
        tarea nullable:true
        documentos nullable:true
    }
    
    static mapping = {
        autoTimestamp true
    }
}
