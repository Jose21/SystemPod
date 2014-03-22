package com.app.sgtask

/**
* Domain class que contiene los datos de un docuemento en el modulo de convenios y turnos.
*/
class Documento {
    
    /**
    * Nombre del archivo.
    */
    String nombre
    /**
    * Archivo digital.
    */
    byte[] archivo
    /**
    * Esta propiedad hace referencia que un documento pertenece a una nota.
    */
    static belongsTo = [ nota : Nota ]
    
    static constraints = {
        nombre blank:false
        archivo nullable:false, maxSize:52428800
        nota nullable:false
    }
    
    String toString() {
        "${nombre}"
    }
}
