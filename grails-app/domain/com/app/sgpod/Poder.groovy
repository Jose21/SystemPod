package com.app.sgpod

import com.app.security.Usuario
import com.app.sgtask.Tarea
import com.app.sgtask.Nota

class Poder {

    CategoriaDeTipoDePoder categoriaDeTipoDePoder
    Delegacion delegacion
    Usuario creadaPor
    String escrituraPublica
    
    Usuario asignar
    Usuario asignadaPor
    String comentarios
    CartaDeInstruccion cartaDeInstruccion
    String tags
    Usuario responsable
    Date fechaDeEnvio
    
    static hasMany = [ 
        documentos : DocumentoDePoder,
        tareas : Tarea,
        apoderados : Apoderado,
        notas : Nota
    ]
    
    static constraints = {
        
        categoriaDeTipoDePoder blank:false
        delegacion nullable:false
        creadaPor nullable:false
        escrituraPublica nullable:true, blank:true
        
        comentarios nullable:true, blank:true, maxSize:1048576
        
        asignar nullable:true, blank:true
        asignadaPor nullable:true, blank:true
        cartaDeInstruccion nullable:true
        documentos nullable:true
        tareas nullable:true
        tags nullable:true, maxSize:1000
        apoderados nullable:true
        responsable nullable:true,blank:true
        notas nullable:true
        fechaDeEnvio nullable:true
    }
    
    String toString() {
        "${id}"
    }
}
