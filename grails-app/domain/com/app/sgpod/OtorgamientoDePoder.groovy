package com.app.sgpod

import com.app.security.Usuario
import com.app.sgtask.Tarea

/**
* Domain class hija de la domain Poder, hereda todas sus propiedades.
*/
class OtorgamientoDePoder extends Poder {    
    /**
    * Poder que es solicitado.
    */
    String poderSolicitado
    /**
    * Motivo del otorgamiento.
    */
    MotivoDeOtorgamiento motivoDeOtorgamiento
    /**
    * Nombre de quien solicita el poder.
    */
    //String solicitadoPor
        
    /**
    * Fecha del otorgamiento.
    */
    Date fechaDeOtorgamiento
    /**
    * Fecha de vencimiento.
    */
    Date fechaVencimiento
    /**
    * Bandera para saber si el usuario solicitante ya vio la copia electronica que se le envio.
    */
    boolean voBoCopiaElectronica = false
    /**
    * Bandera para saber si el usuario solicitante ya vio la prueba de envio de documento físico.
    */
    boolean voBoDocumentoFisico = false
    /**
    * Bandera para saber si hay una solicitud en proceso de un mismo poder.
    */
    boolean solicitudEnProceso 
    
     /**
    * Agregar documento de justificacion de poder especial.
    */
     byte[] documentoPoderEspecial
     String nombreDocumentoPoderEspecial
             
    static hasMany = [         
        apoderadosVigentes : Apoderado       
    ]
    
    static constraints = {       
        
        
        poderSolicitado blank:true, nullable:true, maxSize:1048576
        motivoDeOtorgamiento nullable:false, maxSize:1048576
        //solicitadoPor blank:false
        
        fechaDeOtorgamiento nullable:true       
        fechaVencimiento nullable:true
        voBoCopiaElectronica blank:false
        voBoDocumentoFisico blank:false
        apoderadosVigentes nullable:true
        solicitudEnProceso blank:false
        documentoPoderEspecial nullable:true, maxSize:52428800
        nombreDocumentoPoderEspecial nullable:true, maxSize:1000                 
    }
    
    String toString() {
        "${id}-O"
    }
}
