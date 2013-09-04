package com.app

import com.app.security.Usuario
import com.app.sgtask.Tarea
import com.app.sgtask.HistorialDeTarea

class HistorialDeTareaService {

    def agregar(Tarea tarea, Usuario quien, String que) {        
        def historialDeTarea = new HistorialDeTarea()
        historialDeTarea.quien = quien
        historialDeTarea.que = que
        historialDeTarea.cuando = new Date()
        historialDeTarea.tarea = tarea        
        historialDeTarea.save(flush:true)        
    }
}
