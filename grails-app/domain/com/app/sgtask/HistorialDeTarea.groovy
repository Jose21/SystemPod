package com.app.sgtask

import com.app.security.Usuario
import com.app.Historial

class HistorialDeTarea extends Historial {

    String que
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
