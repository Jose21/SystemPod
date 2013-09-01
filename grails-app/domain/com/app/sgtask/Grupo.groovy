package com.app.sgtask

class Grupo {

    String nombre
    String descripcion
    
    static constraints = {
        nombre blank:false, maxSize:140
        descripcion blank:true, maxSize:1024
    }
    
    String toString() {
        "${nombre}"
    }
}
