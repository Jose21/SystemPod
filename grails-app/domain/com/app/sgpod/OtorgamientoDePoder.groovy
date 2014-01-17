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
    String escrituraPublicaDeOtorgamiento
    Date fechaVencimiento
    
    static constraints = {       
        registroDeLaSolicitud nullable:false
        
        poderSolicitado blank:false, maxSize:1048576
        motivoDeOtorgamiento nullable:false, maxSize:1048576
        solicitadoPor blank:false
        
        fechaDeOtorgamiento nullable:true
        escrituraPublicaDeOtorgamiento nullable:true, blank:true
        fechaVencimiento nullable:true
    }
    
    String toString() {
        "${id}-O"
    }
}
