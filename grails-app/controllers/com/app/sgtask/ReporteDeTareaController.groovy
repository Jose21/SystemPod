package com.app.sgtask

import com.pogos.TurnosPorFechaBean
import java.text.SimpleDateFormat
import com.app.sgtask.UsuarioDeTarea
import com.app.sgtask.Tarea
import com.pogos.BusquedaBean

class ReporteDeTareaController {

    def springSecurityService
    
    def turnosPorFechaInit () {
        render (view:"turnosPorFecha")
    }
    
    def turnosPorFecha () {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        
        def turnosPorFechaBean = new TurnosPorFechaBean()
        def rangoDeFecha = null
        def fechaInicio = null
        def fechaFin = null
        def busquedaBean = null
        def tareaInstanceList = []
        
        if (params.rangoDeFecha != "") {
            flash.warn = null
            rangoDeFecha = params.rangoDeFecha
            fechaInicio = sdf.parse(rangoDeFecha.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFecha.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin            
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        [ turnosPorFechaBean : turnosPorFechaBean ]
    }
    
    def totalDeTurnos () {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        
        def turnosPorFechaBean = new TurnosPorFechaBean()
        
        //Total Mis turnos
        def totalMisTurnosQuery = Tarea.where {            
            responsable.id == springSecurityService.currentUser.id
        }
        def totalMisTurnos = totalMisTurnosQuery.list(sort:"id")
        turnosPorFechaBean.totalMisTurnos = totalMisTurnos.size()
                
        //Total Compartidos
        def usuariosDeTarea = UsuarioDeTarea.findAllByUsuarioAndOwner(springSecurityService.currentUser, false)
        def totalCompartidos = usuariosDeTarea*.tarea        
        totalCompartidos = totalCompartidos.findAll {
            it.responsable.id != springSecurityService.currentUser.id &&
            it.creadaPor.id != springSecurityService.currentUser.id
        }
        turnosPorFechaBean.totalCompartidos = totalCompartidos.size()
        
        //Total Turnados
        def totalTurnadosQuery = Tarea.where {
            creadaPor.id == springSecurityService.currentUser.id &&
            responsable.id != springSecurityService.currentUser.id
        }
        def totalTurnados = totalTurnadosQuery.list(sort:"id")  
        turnosPorFechaBean.totalTurnados = totalTurnados.size()
        
        //Resueltos Mis turnos
        def resueltosMisTurnosQuery = Tarea.where {            
            cerrada == true &&
            responsable.id == springSecurityService.currentUser.id
        }
        def resueltosMisTurnos = resueltosMisTurnosQuery.list(sort:"id")
        turnosPorFechaBean.resueltosMisTurnos = resueltosMisTurnos.size()
        
        //Resueltos Compartidos
        usuariosDeTarea = UsuarioDeTarea.findAllByUsuarioAndOwner(springSecurityService.currentUser, false)
        def resueltosCompartidos = usuariosDeTarea*.tarea        
        resueltosCompartidos = resueltosCompartidos.findAll {
            it.cerrada == true &&
            it.responsable.id != springSecurityService.currentUser.id &&
            it.creadaPor.id != springSecurityService.currentUser.id
        }
        turnosPorFechaBean.resueltosCompartidos = resueltosCompartidos.size()
        
        //Resueltos Turnados
        def resueltosTurnadosQuery = Tarea.where {
            cerrada == true &&
            creadaPor.id == springSecurityService.currentUser.id &&
            responsable.id != springSecurityService.currentUser.id
        }
        def resueltosTurnados = resueltosTurnadosQuery.list(sort:"id")  
        turnosPorFechaBean.resueltosTurnados = resueltosTurnados.size()
        
        //Pendientes Mis Turnos
        def pendientesMisTurnosQuery = Tarea.where {            
            cerrada == false &&
            responsable.id == springSecurityService.currentUser.id
        }
        def pendientesMisTurnos = pendientesMisTurnosQuery.list(sort:"id")
        turnosPorFechaBean.pendientesMisTurnos = pendientesMisTurnos.size()
        //Pendientes Compartidos
        usuariosDeTarea = UsuarioDeTarea.findAllByUsuarioAndOwner(springSecurityService.currentUser, false)
        def pendientesCompartidos = usuariosDeTarea*.tarea        
        pendientesCompartidos = pendientesCompartidos.findAll {
            it.responsable.id != springSecurityService.currentUser.id &&
            it.creadaPor.id != springSecurityService.currentUser.id
        }
        turnosPorFechaBean.pendientesCompartidos = pendientesCompartidos.size()
        
        //Pendientes Turnados
        def pendientesTurnadosQuery = Tarea.where {
            cerrada == true &&
            creadaPor.id == springSecurityService.currentUser.id &&
            responsable.id != springSecurityService.currentUser.id
        }
        def pendientesTurnados = pendientesTurnadosQuery.list(sort:"id")  
        turnosPorFechaBean.pendientesTurnados = pendientesTurnados.size()
        
        //Atrasados Mis Turnos
        def atrasadosMisTurnosQuery = Tarea.where {            
            fechaLimite < (new Date() - 1) &&
            cerrada == false &&
            responsable.id == springSecurityService.currentUser.id
        }
        def atrasadosMisTurnos = atrasadosMisTurnosQuery.list(sort:"id")
        turnosPorFechaBean.atrasadosMisTurnos = atrasadosMisTurnos.size()
        
        //Atrasados Compartidos
        usuariosDeTarea = UsuarioDeTarea.findAllByUsuarioAndOwner(springSecurityService.currentUser, false)
        def atrasadosCompartidos = usuariosDeTarea*.tarea        
        atrasadosCompartidos = atrasadosCompartidos.findAll {
            it.fechaLimite < (new Date() - 1) &&
            it.cerrada == false &&
            it.responsable.id != springSecurityService.currentUser.id &&
            it.creadaPor.id != springSecurityService.currentUser.id
        }
        turnosPorFechaBean.atrasadosCompartidos = atrasadosCompartidos.size()
        
        //Atrasados Turnos
        def atrasadosTurnadosQuery = Tarea.where {
            fechaLimite < (new Date() - 1) &&
            cerrada == false &&
            responsable != springSecurityService.currentUser &&
            creadaPor == springSecurityService.currentUser
        }
        def atrasadosTurnados = atrasadosTurnadosQuery.list(sort:"id")
        turnosPorFechaBean.atrasadosTurnados = atrasadosTurnados.size()
        
        [ turnosPorFechaBean : turnosPorFechaBean ]
    }
}
