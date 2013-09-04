package com.app.sgtask

import com.app.security.Usuario
import com.app.Historial

class HistorialDeTarea extends Historial {

    String que
    static belongsTo = [ tarea : Tarea ]
    
    static constraints = {
        que nullable:false, 
            inList : [
                "creó una tarea", 
                "abrió una tarea", 
                "editó una tarea", 
                "agregó una nota", 
                "modificó una nota",
                "reasignó una tarea", 
                "concluyó una tarea"
            ]
        tarea nullable:false
    }
}
