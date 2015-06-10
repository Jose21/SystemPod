package com.app.sgtask


import com.app.security.Usuario
import com.app.sgpod.Poder

/**
* Domain class donde se definen todos los campos sobre una nota, esta se crea en un turno.
*/
class Nota {
    /**
    * Título descriptivo de la nota.
    */
    String titulo
    /**
    * Descripción breve de la nota.
    */
    String descripcion 
    /**
    * Fecha de creación.
    */
    Date dateCreated
    /**
    * Última actualizacion
    */
    Date lastUpdated
    /**
    * Que usuario agrego la nota.
    */
    Usuario agregadaPor
    
    /**
    * Integración con el modulo de turnos y poderes.
    */
    static belongsTo = [ tarea : Tarea, poder : Poder ]
    
    /**
    * Relación de tipo 1-n , con la domain class Documento.
    */
    static hasMany = [ documentos : Documento ]
    
    static constraints = {
        titulo blank:false
        descripcion blank:true, nullable:true, maxSize:10240
        tarea nullable:true
        documentos nullable:true
        agregadaPor nullable:false
        poder nullable:true        
    }
    
    static mapping = {
        autoTimestamp true
    }
}
