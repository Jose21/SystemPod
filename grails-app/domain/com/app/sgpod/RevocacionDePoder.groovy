package com.app.sgpod

import com.app.security.Usuario
import com.app.sgtask.Tarea

class RevocacionDePoder extends Poder{
    
    
    MotivoDeRevocacion motivoDeRevocacion
    String solicitadoPor    
    //Datos que puede complementar en cualquier momento    
    Date fechaDeRevocacion
    String tipoDeRevocacion
    
    static constraints = {                
        motivoDeRevocacion nullable:true, maxSize:1048576
        solicitadoPor blank:false        
        fechaDeRevocacion nullable:true
        tipoDeRevocacion blank:false, inList : ["Total", "Parcial"]
    }
    
    String toString() {
        "${id}-R"
    }
}
