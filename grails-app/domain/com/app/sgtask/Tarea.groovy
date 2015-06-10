package com.app.sgtask

import com.app.security.Usuario
import com.app.sgcon.Convenio
import com.app.sgpod.OtorgamientoDePoder
import com.app.sgpod.RevocacionDePoder

/**
* Domain class que contiene las propiedades de una Tarea.
*/
class Tarea implements Comparable {
    /**
    * Nombre del turno
    */
    String nombre
    /**
    * Descripción del turno.
    */
    String descripcion
    /**
    * Fecha límite.
    */
    Date fechaLimite
    /**
    * Bandera para dar por cerrada un turno.
    */
    boolean cerrada = false
    /**
    * Fecha de creación.
    */
    Date dateCreated
    /**
    * Fecha de última actualización.
    */
    Date lastUpdated
    /**
    * Usuario creador del turno.
    */
    Usuario creadaPor
    /**
    * Usuario responsable de atender el turno.
    */
    Usuario responsable
    /**
    * Dias para la alerta de vencimiento
    */
    String alertaVencimiento
    /**
    * Tipo de prioridad
    */
    String prioridad
    /**
    * Palabras clave para busquedas avazadas.
    */
    String tags
    /**
    * Propiedad de tipo grupo.
    */
    Grupo grupo
    /**
    * Integración con convenios, otorgamiento y revocacion de poder.
    */
   
    /**
    *Baja lógica
    *
    */
    boolean eliminado = null
    boolean check_responsable = null
    
    static belongsTo = [ 
        convenio : Convenio,
        otorgamientoDePoder : OtorgamientoDePoder,
        revocacionDePoder : RevocacionDePoder
    ]
    /**
    * Esta es la relación que tiene con otras tablas de tipo  1-n.
    */
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
        alertaVencimiento blank:false, inList : ["0","1","2","3","4","5","6","7"]
        prioridad blank:false, inList : ["Normal", "Urgente"]
        tags nullable:true, maxSize:1000
        eliminado nullable:true
        check_responsable nullable:true
    }
    
    static mapping = {
        autoTimestamp true
    }
    
    int compareTo(Object other) {
        id <=> other.id
    }
}
