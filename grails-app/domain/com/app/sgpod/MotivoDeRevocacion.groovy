package com.app.sgpod

class MotivoDeRevocacion {

    String nombre
    
    static constraints = {
        nombre blank:false
    }
    
    String toString() {
        "${nombre}"
    }
}
