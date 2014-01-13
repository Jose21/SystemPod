package com.app.sgpod

class Notario {

    String nombre
    String numeroDeNotaria
    String direccion
    
    static constraints = {
        nombre blank:false
        numeroDeNotaria blank:false
        direccion nullable:true, blank:true
    }
    
    String toString() {
        "${nombre} - ${numeroDeNotaria}"
    }
}
