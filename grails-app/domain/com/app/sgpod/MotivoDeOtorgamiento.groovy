package com.app.sgpod

class MotivoDeOtorgamiento {

    String nombre
    
    static constraints = {
        nombre blank:false
    }
    
    String toString() {
        "${nombre}"
    }
}
