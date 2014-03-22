package com.app.sgpod

/**
* Doamin class del motivo de otorgamiento.
*/
class MotivoDeOtorgamiento {
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
