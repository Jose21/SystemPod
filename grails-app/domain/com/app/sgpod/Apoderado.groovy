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
    
    CargoApoderado cargoApoderado
    
    String statusDePoder
    
    String numeroIN
    
    static constraints = {
        
        nombre blank:false
        puesto nullable:true, blank:true        
        institucion nullable:true, blank:true
        email nullable:true, email:true, blank:true
        cargoApoderado nullable:true
        statusDePoder nullable:true, inList : ["Revocado", "En trámite de revocación","En trámite de otorgamiento", "Cancelado", "Vencido","Vigente"]
        numeroIN nullable:true
    }
}
