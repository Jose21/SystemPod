package com.app.sgtask

/**
* Domain class que define un grupo dentro del modulo de covenios.
*/
class Grupo {
    /**
    * Nombre del grupo.
    */
    String nombre
    /**
    * Descripción del grupo actual.
    */
    String descripcion
    
    static constraints = {
        nombre blank:false, maxSize:140
        descripcion blank:true, maxSize:1024
    }
    
    String toString() {
        "${nombre}"
    }
}
