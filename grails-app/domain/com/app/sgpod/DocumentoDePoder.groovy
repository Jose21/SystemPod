package com.app.sgpod

class DocumentoDePoder {

    String nombre
    byte[] archivo   
    
    static constraints = {
        nombre blank:false
        archivo nullable:false, maxSize:52428800
    }
    
    String toString() {
        "${nombre}"
    }
}
