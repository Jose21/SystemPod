package com.app.sgpod

import com.app.security.Usuario
import com.app.sgtask.Tarea

class RevocacionDePoder extends Poder{

    String escrituraPublica
    Notario notario
    
    MotivoDeRevocacion motivoDeRevocacion
    String solicitadoPor
    
    //Datos que puede complementar en cualquier momento
    
    Date fechaDeRevocacion
    String escrituraPublicaDeRevocacion
    
    static constraints = {
        escrituraPublica blank:false
        notario nullable:false
        
        motivoDeRevocacion nullable:false, maxSize:1048576
        solicitadoPor blank:false
        
        fechaDeRevocacion nullable:true
        escrituraPublicaDeRevocacion nullable:true, blank:true
        comentarios nullable:true, blank:true, maxSize:1048576                
    }
    
    String toString() {
        "${id}-R"
    }
}
