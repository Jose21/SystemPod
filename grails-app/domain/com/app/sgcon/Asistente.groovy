package com.app.sgcon

class Asistente {

    Persona persona
    boolean firmante
    Date dateCreated
    Date lastUpdated
    
    static belongsTo = [ convenio : Convenio ]
    
    static constraints = {
        persona nullable:false
        firmante blank:true
        convenio nullable:false
    }
    
    String toString () {
        "${persona.nombre}"
    }
}