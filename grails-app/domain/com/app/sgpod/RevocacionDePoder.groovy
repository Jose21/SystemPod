package com.app.sgpod

import com.app.security.Usuario
import com.app.sgtask.Tarea

class RevocacionDePoder {

    String escrituraPublica
    String nombreDeNotario
    String numeroDeNotario
    
    String nombre
    String puesto
    String contrato
    String tipoDePoder
    String delegacion
    Usuario creadaPor
    
    MotivoDeRevocacion motivoDeRevocacion
    String solicitadoPor
    
    //Datos que puede complementar en cualquier momento
    Usuario asignar
    Date fechaDeRevocacion
    String escrituraPublicaDeRevocacion
    String comentarios
    CartaDeInstruccion cartaDeInstruccion
    
    static hasMany = [ 
        documentos : DocumentoDePoder,
        tareas : Tarea
    ]
    
    static constraints = {
        escrituraPublica blank:false
        nombreDeNotario blank:false
        numeroDeNotario blank:false
        
        nombre blank:false
        puesto blank:false
        contrato blank:false
        tipoDePoder blank:false, inList : ["Interno","Externo"]
        delegacion blank:false
        creadaPor nullable:false
        
        motivoDeRevocacion nullable:false, maxSize:1048576
        solicitadoPor blank:false
        
        asignar nullable:true, blank:true

        fechaDeRevocacion nullable:true
        escrituraPublicaDeRevocacion nullable:true, blank:true
        comentarios nullable:true, blank:true, maxSize:1048576
        
        cartaDeInstruccion nullable:true
        documentos nullable:true
        tareas nullable:true
    }
}
