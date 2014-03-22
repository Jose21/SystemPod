package com.app.sgpod

/**
 * Domain class que pertenece a los apoderados en un otorgamiento o revocacion de poder.
 */
class Apoderado {
    
    /**
    * Nombre del apoderado
    */
    String nombre
    /**
    * Puesto que ejerce.
    */
    String puesto
    /**
    * Institucion a la que pertenece un apoderado.
    */
    String institucion
    /**
    * Correo electronico del apoderado
    */
    String email
    
    static constraints = {
        
        nombre blank:false
        puesto nullable:true, blank:true        
        institucion nullable:true, blank:true
        email nullable:true, email:true, blank:true
    }
}
