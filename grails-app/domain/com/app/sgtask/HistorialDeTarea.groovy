package com.app.sgtask

import com.app.security.Usuario
import com.app.Historial

/**
* Domain class de historial de tarea que hereda los atributos de la clase Historial.
*/
class HistorialDeTarea extends Historial {
    
    /**
    * Campo que guarda la operacion que se realizo.
    */
    String que
    /**
    * Contiene un atributo de tipo tarea.
    */
    static belongsTo = [ tarea : Tarea ]
    
    static constraints = {
        que nullable:false, 
            inList : [
                "creó un turno", 
                "abrió un turno", 
                "editó un turno", 
                "agregó una nota", 
                "modificó una nota",
                "reasignó un turno", 
                "concluyó un turno"
            ]
        tarea nullable:false
    }
}
