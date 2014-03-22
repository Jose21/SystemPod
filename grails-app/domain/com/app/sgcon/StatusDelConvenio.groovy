package com.app.sgcon

/**
* Domain class que ayuda a saber el status del convenio. 
*/
class StatusDelConvenio {
    /**
    * nombre del status
    */
    String nombre
    /**
    * Fecha de creación.
    */
    Date dateCreated
    /**
    * Fecha de la última actualización.
    */
    Date lastUpdated
    
    static constraints = {
        nombre blank: false, unique:true
    }
    
    String toString() {
        "${nombre}"
    }
}
