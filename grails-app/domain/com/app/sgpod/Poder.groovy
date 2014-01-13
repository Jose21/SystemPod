package com.app.sgpod

import com.app.security.Usuario
import com.app.sgtask.Tarea

class Poder {

    String nombre
    String puesto
    String contrato
    String tipoDePoder
    Delegacion delegacion
    Usuario creadaPor
    
    Usuario asignar
    String comentarios
    CartaDeInstruccion cartaDeInstruccion
    String tags
    
    static hasMany = [ 
        documentos : DocumentoDePoder,
        tareas : Tarea
    ]
    
    static constraints = {
        
        nombre blank:false
        puesto blank:false
        contrato blank:false
        tipoDePoder blank:false, inList : ["Interno","Externo"]
        delegacion nullable:false
        creadaPor nullable:false
        
        comentarios nullable:true, blank:true, maxSize:1048576
        
        asignar nullable:true, blank:true
        
        cartaDeInstruccion nullable:true
        documentos nullable:true
        tareas nullable:true
        tags nullable:true, maxSize:1000
    }
    
    String toString() {
        "${id}"
    }
}
