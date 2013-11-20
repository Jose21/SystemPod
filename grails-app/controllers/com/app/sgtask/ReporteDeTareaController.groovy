package com.app.sgtask

import com.pogos.TurnosPorFechaBean
import java.text.SimpleDateFormat
import com.app.sgtask.UsuarioDeTarea
import com.app.sgtask.Tarea
import com.pogos.BusquedaBean
import grails.plugins.springsecurity.Secured


@Secured(['IS_AUTHENTICATED_FULLY'])
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
        println "XXXX"+params.barra
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
        
        //Total Prioridad Urgente
        def totalPrioridadUrgenteQuery = Tarea.where {
            prioridad == "Urgente"
        }
        def totalPrioridadUrgente = totalPrioridadUrgenteQuery.list(sort:"id")
        turnosPorFechaBean.totalPrioridadUrgente = totalPrioridadUrgente.size()
        
        //Total Prioridad Normal
        def totalPrioridadNormalQuery = Tarea.where {
            prioridad == "Normal"
        }
        def totalPrioridadNormal = totalPrioridadNormalQuery.list(sort:"id")
        turnosPorFechaBean.totalPrioridadNormal = totalPrioridadNormal.size()
              
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
        
        //Resueltos Prioridad Urgente
        def resueltosPrioridadUrgenteQuery = Tarea.where {            
            cerrada == true &&
            prioridad == "Urgente"
        }
        def resueltosPrioridadUrgente = resueltosPrioridadUrgenteQuery.list(sort:"id")
        turnosPorFechaBean.resueltosPrioridadUrgente = resueltosPrioridadUrgente.size()
        
        //Resueltos Prioridad Normal
        def resueltosPrioridadNormalQuery = Tarea.where {            
            cerrada == true &&
            prioridad == "Normal"
        }
        def resueltosPrioridadNormal = resueltosPrioridadNormalQuery.list(sort:"id")
        turnosPorFechaBean.resueltosPrioridadNormal = resueltosPrioridadNormal.size()
        
        //Pendientes Mis Turnos
        def pendientesMisTurnosQuery = Tarea.where {            
            cerrada == false &&
            responsable.id == springSecurityService.currentUser.id
        }
        def pendientesMisTurnos = pendientesMisTurnosQuery.list(sort:"id")
        log.info "mis turnos pendientes" + pendientesMisTurnos
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
        
        //Pendientes Prioridad Urgente
        def pendientesPrioridadUrgenteQuery = Tarea.where {            
            cerrada == false &&
            prioridad == "Urgente"
        }
        def pendientesPrioridadUrgente = pendientesPrioridadUrgenteQuery.list(sort:"id")
        turnosPorFechaBean.pendientesPrioridadUrgente = pendientesPrioridadUrgente.size()
        
        //Pendientes Prioridad Normal
        def pendientesPrioridadNormalQuery = Tarea.where {            
            cerrada == false &&
            prioridad == "Normal"
        }
        def pendientesPrioridadNormal = pendientesPrioridadNormalQuery.list(sort:"id")
        turnosPorFechaBean.pendientesPrioridadNormal = pendientesPrioridadNormal.size()
                
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
        
        //Atrasados Prioridad Urgente
        def atrasadosPrioridadUrgenteQuery = Tarea.where {            
            fechaLimite < (new Date() - 1) &&
            cerrada == false &&
            prioridad == "Urgente"
        }
        def atrasadosPrioridadUrgente = atrasadosPrioridadUrgenteQuery.list(sort:"id")
        turnosPorFechaBean.atrasadosPrioridadUrgente = atrasadosPrioridadUrgente.size()
        
        //Atrasados Prioridad Normal
        def atrasadosPrioridadNormalQuery = Tarea.where {            
            fechaLimite < (new Date() - 1) &&
            cerrada == false &&
            prioridad == "Normal"
        }
        def atrasadosPrioridadNormal = atrasadosPrioridadNormalQuery.list(sort:"id")
        turnosPorFechaBean.atrasadosPrioridadNormal = atrasadosPrioridadNormal.size()
        
        if(params.barra == "Total"){
            turnosPorFechaBean.misTurnos = totalMisTurnos
            turnosPorFechaBean.compartidos = totalCompartidos
            turnosPorFechaBean.turnados = totalTurnados
            turnosPorFechaBean.prioridadUrgente = totalPrioridadUrgente
            turnosPorFechaBean.prioridadNormal = totalPrioridadNormal
        } else if(params.barra == "Resueltos"){
            turnosPorFechaBean.misTurnos = resueltosMisTurnos
            turnosPorFechaBean.compartidos = resueltosCompartidos
            turnosPorFechaBean.turnados = resueltosTurnados
            turnosPorFechaBean.prioridadUrgente = resueltosPrioridadUrgente
            turnosPorFechaBean.prioridadNormal = resueltosPrioridadNormal
        }else  if(params.barra == "Pendientes"){
            turnosPorFechaBean.misTurnos = pendientesMisTurnos
            turnosPorFechaBean.compartidos = pendientesCompartidos
            turnosPorFechaBean.turnados = pendientesTurnados
            turnosPorFechaBean.prioridadUrgente = pendientesPrioridadUrgente
            turnosPorFechaBean.prioridadNormal = pendientesPrioridadNormal
        } else if(params.barra == "Atrasados"){
            turnosPorFechaBean.misTurnos = atrasadosMisTurnos
            turnosPorFechaBean.compartidos = atrasadosCompartidos
            turnosPorFechaBean.turnados = atrasadosTurnados
            turnosPorFechaBean.prioridadUrgente = atrasadosPrioridadUrgente
            turnosPorFechaBean.prioridadNormal = atrasadosPrioridadNormal
        }
        
        [ turnosPorFechaBean : turnosPorFechaBean ]
    }
    
    //Busqueda para generar listado de turnos en Reportes ejecutivos
    
    def turnosResueltos(){
        log.info "Lllamando al metodo turnosResuletos"
        def resueltosListQuery = Tarea.where {
            cerrada == true
        }
        def resueltosList = resueltosListQuery.list(sort:"id")
        log.info "Encontrados" + resueltosList.size
        def respuesta = "{turnosResueltos:"+ (resueltosList as JSON) + "}"
        log.info "respuesta:" +  respuesta
        render respuesta
    }
    
    
    def turnosPendientes(){
        def tareaInstanceListQuery = Tarea.where {
            cerrada == false
        }
        def tareaInstanceList = tareaInstanceListQuery.list(sort:"id")
        log.info "Encontrados" + tareaInstanceList
        //def respuesta = "{\"turnosPendientes\": "+ (pendientesList as JSON) + "}"
        //log.info "respuesta:" +  respuesta
        //render respuesta
        render(
            view: "totalDeTurnos", 
            model: [
                tareaInstanceList : tareaInstanceList      
            ]
        )     
    }
}
