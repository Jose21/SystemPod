package com.app.sgtask

class Documento {

    String nombre
    byte[] archivo
    
    static belongsTo = [ nota : Nota ]
    
    static constraints = {
        nombre blank:false
        archivo nullable:false, maxSize:5242880
        nota nullable:false
    }
    
    String toString() {
        "${nombre}"
    }
}
