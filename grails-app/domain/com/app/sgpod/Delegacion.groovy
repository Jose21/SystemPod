package com.app.sgpod

/**
* Domain class para la delagación a la que pertenecen los usuario solicitantes en el sistema.    
*/

class Delegacion {
    /**
    * Nombre de la delagación.    
    */    
    String nombre
    
    static constraints = {
        nombre blank:false
    }
    
    String toString () {
        "${nombre}"
    }
}
