package com.app.sgpod

class OtorgamientoDePoder {

    String numeroDeFolio
    Date registroDeLaSolicitud
    
    String nombre
    String puesto
    String contrato
    String tipoDePoder
    Delegacion delegacion
    
    String poderSolicitado
    MotivoDeOtorgamiento motivoDeOtorgamiento
    String solicitadoPor
    
    //Datos que puede complementar en cualquier momento
    Date fechaDeOtorgamiento
    String escrituraPublicaDeOtorgamiento
    String comentarios
    CartaDeInstruccion cartaDeInstruccion
    
    static hasMany = [ documentos : DocumentoDePoder ]
    
    static constraints = {
        
        numeroDeFolio blank:false
        registroDeLaSolicitud nullable:false
        
        nombre blank:false
        puesto blank:false
        contrato blank:false
        tipoDePoder blank:false, inList : ["Interno","Externo"]
        delegacion nullable:false
        
        poderSolicitado blank:false, maxSize:1048576
        motivoDeOtorgamiento nullable:false, maxSize:1048576
        solicitadoPor blank:false
        
        fechaDeOtorgamiento nullable:true
        escrituraPublicaDeOtorgamiento nullable:true, blank:true
        comentarios nullable:true, blank:true, maxSize:1048576
        
        cartaDeInstruccion nullable:true
        documentos nullable:true
    }
}
