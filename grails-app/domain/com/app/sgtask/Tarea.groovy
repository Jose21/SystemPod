package com.app.sgtask

import com.app.security.Usuario
import com.app.sgcon.Convenio

class Tarea implements Comparable {

    String nombre
    String descripcion
    Date fechaLimite
    boolean cerrada = false
    Date dateCreated
    Date lastUpdated
    Usuario creadaPor
    Usuario responsable
    
    Grupo grupo
    
    static belongsTo = [ convenio : Convenio ]
    static hasMany = [notas : Nota, usuariosDeTarea : UsuarioDeTarea]
    
    static constraints = {
        nombre blank:false, maxSize:140
        descripcion blank:false, maxSize:10240
        fechaLimite nullable:true
        grupo nullable:false
        cerrada blank:false
        notas nullable:true
        creadaPor nullable:false
        responsable nullable:true
        convenio nullable:true
        usuariosDeTarea nullable:true
    }
    
    static mapping = {
        autoTimestamp true
    }
    
    int compareTo(Object other) {
        id <=> other.id
    }
}
