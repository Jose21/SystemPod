package com.app.sgpod

class RevocacionDePoder {

    String escrituraPublica
    String nombreDeNotario
    String numeroDeNotario
    
    String nombre
    String puesto
    String contrato
    String tipoDePoder
    String delegacion
    
    MotivoDeRevocacion motivoDeRevocacion
    String solicitadoPor
    
    //Datos que puede complementar en cualquier momento
    Date fechaDeRevocacion
    String escrituraPublicaDeRevocacion
    String comentarios
    
    static constraints = {
        escrituraPublica blank:false
        nombreDeNotario blank:false
        numeroDeNotario blank:false
        
        nombre blank:false
        puesto blank:false
        contrato blank:false
        tipoDePoder blank:false, inList : ["Interno","Externo"]
        delegacion blank:false
        
        motivoDeRevocacion nullable:false, maxSize:1048576
        solicitadoPor blank:false

        fechaDeRevocacion nullable:true
        escrituraPublicaDeRevocacion nullable:true, blank:true
        comentarios nullable:true, blank:true, maxSize:1048576
    }
}
