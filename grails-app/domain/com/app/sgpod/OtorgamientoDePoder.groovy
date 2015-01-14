package com.app.sgpod

import com.app.security.Usuario
import com.app.sgtask.Tarea

/**
* Domain class hija de la domain Poder, hereda todas sus propiedades.
*/
class OtorgamientoDePoder extends Poder {
    /**
    * Fecha de cuando se crea la solicitud.
    */
    Date registroDeLaSolicitud
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
    boolean solicitudEnProceso = false
    
    static hasMany = [         
        apoderadosVigentes : Apoderado        
    ]
    
    static constraints = {       
        registroDeLaSolicitud nullable:false
        
        poderSolicitado blank:true, nullable:true, maxSize:1048576
        motivoDeOtorgamiento nullable:false, maxSize:1048576
        //solicitadoPor blank:false
        
        fechaDeOtorgamiento nullable:true       
        fechaVencimiento nullable:true
        voBoCopiaElectronica blank:false
        voBoDocumentoFisico blank:false
        apoderadosVigentes nullable:true
        solicitudEnProceso blank:false
    }
    
    String toString() {
        "${id}-O"
    }
}
