package com.app.sgcon

class StatusDelConvenio {

    String nombre
    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        nombre blank: false
    }
    
    String toString() {
        "${nombre}"
    }
}
