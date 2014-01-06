package com.app.sgtask

import com.app.security.Usuario
import com.app.sgcon.Convenio
import com.app.sgpod.OtorgamientoDePoder
import com.app.sgpod.RevocacionDePoder

class Tarea implements Comparable {

    String nombre
    String descripcion
    Date fechaLimite
    boolean cerrada = false
    Date dateCreated
    Date lastUpdated
    Usuario creadaPor
    Usuario responsable
    String alertaVencimiento
    String prioridad
    String tags
    
    Grupo grupo
    
    static belongsTo = [ 
        convenio : Convenio,
        otorgamientoDePoder : OtorgamientoDePoder,
        revocacionDePoder : RevocacionDePoder
    ]
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
        otorgamientoDePoder nullable:true
        revocacionDePoder nullable:true
        usuariosDeTarea nullable:true
        alertaVencimiento blank:false, inList : ["1","2","3","4","5","6","7"]
        prioridad blank:false, inList : ["Normal", "Urgente"]
        tags nullable:true, maxSize:1000
    }
    
    static mapping = {
        autoTimestamp true
    }
    
    int compareTo(Object other) {
        id <=> other.id
    }
}
