package com.app.sgtask

import com.app.security.Usuario

class UsuarioDeTarea {

    Usuario usuario
    boolean owner
    
    static belongsTo = [ tarea : Tarea ]
    
    static constraints = {
        usuario nullable:false
        owner blank:false
        tarea nullable:false
    }
    
    String toString() {
        "${usuario.username}"
    }
}
