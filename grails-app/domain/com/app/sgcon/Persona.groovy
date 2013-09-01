package com.app.sgcon

class Persona {

    String nombre
    String puesto
    String area
    String email
    String telefono
    String extension
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        nombre blank:false
        puesto nullable:true, blank:true
        area nullable:true, blank:true
        email nullable:true, email:true, blank:true
        telefono nullable:true, blank:true
        extension nullable:true, blank:true
    }
    
    String toString() {
        "${nombre}"
    }
}
