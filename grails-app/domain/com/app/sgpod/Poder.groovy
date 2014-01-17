package com.app.sgpod

import com.app.security.Usuario
import com.app.sgtask.Tarea

class Poder {

    String tipoDePoder
    Delegacion delegacion
    Usuario creadaPor
    
    Usuario asignar
    Usuario asignadaPor
    String comentarios
    CartaDeInstruccion cartaDeInstruccion
    String tags
    
    static hasMany = [ 
        documentos : DocumentoDePoder,
        tareas : Tarea,
        apoderados : Apoderado
    ]
    
    static constraints = {
        
        tipoDePoder blank:false, inList : ["Interno","Externo"]
        delegacion nullable:false
        creadaPor nullable:false
        
        comentarios nullable:true, blank:true, maxSize:1048576
        
        asignar nullable:true, blank:true
        asignadaPor nullable:true, blank:true
        cartaDeInstruccion nullable:true
        documentos nullable:true
        tareas nullable:true
        tags nullable:true, maxSize:1000
        apoderados nullable:true
    }
    
    String toString() {
        "${id}"
    }
}
