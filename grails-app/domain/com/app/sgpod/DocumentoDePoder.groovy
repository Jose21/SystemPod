package com.app.sgpod

/**
* Domain class donde se guardan todos los documentos digitales del modulo de poderes.
*/    
class DocumentoDePoder {
    /**
    * Nombre del archivo digital.    
    */ 
    String nombre
    /**
    * Archivo digital.    
    */ 
    byte[] archivo
    
    static constraints = {
        nombre blank:false
        archivo nullable:false, maxSize:52428800
    }
    
    String toString() {
        "${nombre}"
    }
}
