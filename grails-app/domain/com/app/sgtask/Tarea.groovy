package com.app.sgtask

class Tarea {

    String nombre
    String descripcion
    Date fechaLimite
    boolean cerrada = false
    Date dateCreated
    Date lastUpdated
    
    Grupo grupo
    
    static hasMany = [notas : Nota]
    
    static constraints = {
        nombre blank:false, maxSize:140
        descripcion blank:false, maxSize:10240
        fechaLimite nullable:true, blank:true
        grupo nullable:false
        cerrada blank:false
        notas nullable:true
    }
    
    static mapping = {
        autoTimestamp true
    }
}
