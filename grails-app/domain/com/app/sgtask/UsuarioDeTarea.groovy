package com.app.sgtask

import com.app.security.Usuario
/**
* Domain class que hace referencia al usuario de una tarea, y nos ayuda para compartir la misma.
*/
class UsuarioDeTarea {
    /**
    * Tiene una propiedad usuario de tipo usuario.
    */
    Usuario usuario
    /**
    * Identificador si es él creador de la tarea o no.
    */
    boolean owner
    /**
    * Integración con tareas.
    */
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
