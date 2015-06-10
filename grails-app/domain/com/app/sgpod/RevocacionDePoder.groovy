package com.app.sgpod

import com.app.security.Usuario
import com.app.sgtask.Tarea

/**
* Domain class Revocación de poder, que hereda los atributos de la domain Poder.
*/
class RevocacionDePoder extends Poder{
    
    /**
    * Motivo de la revocación.
    */
    MotivoDeRevocacion motivoDeRevocacion  
    /**
    * Fecha de revocación.
    */    
    Date fechaDeRevocacion
    /**
    * Tipo de revocacion 
    */
    String tipoDeRevocacion
    /**
    * Bandera que es utilizada cuando se elige el tipo de revocacion si es total o parcial.
    */
    boolean agregarApoderado = true
    /**
    * Bandera que se utiliza para saber si fue agregada manualmente o se hizo sobre un otorgamiento de poder. 
    */
    boolean agregadaManualmente = false
    
    /**
    * Bandera que se utiliza para saber si fue agregada manualmente o se hizo sobre un otorgamiento de poder. 
    */
    String escrituraPublicaRevocacion
    
    /**
    * Esta es la relacóon que tiene con otras tablas en una relacion tipo  1-n.
    */
    static hasMany = [         
        apoderadosEliminar : Apoderado       
    ]
    /**
    *Notificación para rechazo de solicitud
    */
    String notificacionDeRechazo
   
    
    static belongsTo = [ otorgamientoDePoder : OtorgamientoDePoder ]
    
    static constraints = {                
        motivoDeRevocacion nullable:false               
        fechaDeRevocacion nullable:true
        tipoDeRevocacion blank:false, inList : ["Total", "Parcial"]
        agregarApoderado blank:false
        apoderadosEliminar nullable:true
        agregadaManualmente blank:false
        escrituraPublicaRevocacion nullable:true
        otorgamientoDePoder nullable:true
        notificacionDeRechazo nullable:true, maxSize:5000
    }
    
    String toString() {
        "${id}-R"
    }
}
