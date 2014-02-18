package com.app.sgpod

import com.app.security.Usuario
import com.app.sgtask.Tarea

class OtorgamientoDePoder extends Poder {

    Date registroDeLaSolicitud

    String poderSolicitado
    MotivoDeOtorgamiento motivoDeOtorgamiento
    String solicitadoPor
    
    //Datos que puede complementar en cualquier momento
    
    Date fechaDeOtorgamiento    
    Date fechaVencimiento
    boolean voBoCopiaElectronica = false
    boolean voBoDocumentoFisico = false
    
    static hasMany = [         
        apoderadosVigentes : Apoderado        
    ]
    
    static constraints = {       
        registroDeLaSolicitud nullable:false
        
        poderSolicitado blank:true, nullable:true, maxSize:1048576
        motivoDeOtorgamiento nullable:false, maxSize:1048576
        solicitadoPor blank:false
        
        fechaDeOtorgamiento nullable:true       
        fechaVencimiento nullable:true
        voBoCopiaElectronica blank:false
        voBoDocumentoFisico blank:false
        apoderadosVigentes nullable:true
    }
    
    String toString() {
        "${id}-O"
    }
}
