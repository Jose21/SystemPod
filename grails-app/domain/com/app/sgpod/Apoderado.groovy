package com.app.sgpod

class Apoderado {
    
    String nombre
    String puesto
    String institucion
    String email

    static constraints = {
        
        nombre blank:false
        puesto nullable:true, blank:true        
        institucion nullable:true, blank:true
        email nullable:true, email:true, blank:true
    }
}
