package com.app.sgpod

class Poder {

    String numeroDeFolio
    Date registroDeLaSolicitud
    String tipoDePoder
    String delegacion
    String puesto
    String contrato
    String poderSolicitado
    MotivoDeOtorgamiento motivoDeOtorgamiento
    String solicitadoPor
    
    //Datos que puede complementar en cualquier momento
    Date fechaDeOtorgamientoDePoder
    String escrituraPublicaDeOtorgamiento
    String comentarios
    
    static constraints = {
        
        numeroDeFolio blank:false
        registroDeLaSolicitud nullable:false
        tipoDePoder blank:false, inList : ["Interno","Externo"]
        delegacion blank:false
        puesto blank:false
        contrato blank:false
        poderSolicitado blank:false, maxSize:1048576
        motivoDeOtorgamiento nullable:false
        solicitadoPor blank:false
        
        fechaDeOtorgamientoDePoder nullable:true
        escrituraPublicaDeOtorgamiento nullable:true, blank:true
        comentarios nullable:true, blank:true
        
    }
}
