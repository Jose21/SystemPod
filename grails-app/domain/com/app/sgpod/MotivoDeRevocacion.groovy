package com.app.sgpod

/**
* Doamin class del motivo de revocacion.
*/
class MotivoDeRevocacion {
    
    /**
    * nombre del motivo
    */
    String nombre
    
    static constraints = {
        nombre blank:false
    }
    
    String toString() {
        "${nombre}"
    }
}
