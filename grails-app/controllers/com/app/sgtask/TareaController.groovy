package com.app.sgtask

import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat
import com.app.security.Usuario
import grails.plugin.asyncmail.AsynchronousMailService
import com.app.NotificacionesService
import grails.plugins.springsecurity.Secured
import groovy.time.TimeDuration
import groovy.time.TimeCategory
import com.app.sgcon.Convenio
import com.app.sgcon.beans.BusquedaBean
import com.pogos.BusquedaBean
import com.app.sgpod.OtorgamientoDePoder
import com.app.sgpod.RevocacionDePoder

@Secured(['IS_AUTHENTICATED_FULLY'])
class TareaController {

    def historialDeTareaService
    def springSecurityService
    AsynchronousMailService asyncMailService
    NotificacionesService notificacionesService
    def exportService
    def grailsApplication
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    
    def hoy() {
        flash.warn = null
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        
        session.opt = params.action
        
        //Mis turnos
        def taskList1 = Tarea.findAllByCerradaAndResponsableAndFechaLimite(false, springSecurityService.currentUser, sdf.parse(sdf.format(new Date())))
        def taskList2 = Tarea.findAllByCerradaAndResponsableAndFechaLimiteIsNull(false, springSecurityService.currentUser)
        def taskList = taskList1 + taskList2
        
        //Compartidos
        def c = Tarea.createCriteria()
        def sharedTaskList = c.list {
            eq ("cerrada", false)
            ne ("responsable", springSecurityService.currentUser)
            ne ("creadaPor", springSecurityService.currentUser)
            or {
                eq ("fechaLimite", sdf.parse(sdf.format(new Date())))
                isNull ("fechaLimite")
            }
            usuariosDeTarea {
                eq ("usuario", springSecurityService.currentUser)
                eq ("owner", false)
            }
        }        
        
        //Turnados
        def turnados = Tarea.findAllByFechaLimiteOrFechaLimiteIsNull(sdf.parse(sdf.format(new Date())))
        turnados = turnados.findAll {
            it.cerrada == false &&
            it.creadaPor == springSecurityService.currentUser &&
            it.responsable != springSecurityService.currentUser
        }       
        
        render (
            view: "list", 
            model: [
                tareaInstanceList: taskList, 
                tareaInstanceTotal: taskList.size(),
                sharedTaskList : sharedTaskList,
                sharedTaskTotal : sharedTaskList.size(),
                turnadosList : turnados,
                turnadosTotal : turnados.size()
            ]
        )
    }
    
    def programadas() {
        flash.warn = null
        session.opt = params.action
        
        //Mis turnos        
        def taskListQuery = Tarea.where {            
            fechaLimite > new Date() &&
            cerrada == false &&
            responsable == springSecurityService.currentUser
        }
        def taskList = taskListQuery.list(sort:"id")
        
        //Compartidos        
        def usuariosDeTarea = UsuarioDeTarea.findAllByUsuarioAndOwner(springSecurityService.currentUser, false)
        def sharedTaskList = usuariosDeTarea*.tarea        
        sharedTaskList = sharedTaskList.findAll {            
            it.fechaLimite > new Date() &&
            it.cerrada == false &&
            it.responsable != springSecurityService.currentUser &&
            it.creadaPor != springSecurityService.currentUser
        }
        
        //Turnados
        def turnadosQuery = Tarea.where {
            fechaLimite > new Date() &&
            cerrada == false &&
            responsable != springSecurityService.currentUser &&
            creadaPor == springSecurityService.currentUser
        }
        def turnados = turnadosQuery.list(sort:"id")
        
        render (
            view: "list", 
            model: [
                tareaInstanceList: taskList, 
                tareaInstanceTotal: taskList.size(),
                sharedTaskList : sharedTaskList,
                sharedTaskTotal : sharedTaskList.size(),
                turnadosList : turnados,
                turnadosTotal : turnados.size()
            ]
        )
    }
    
    def retrasadas () {
        session.opt = params.action
        flash.warn = null
        //Mis turnos        
        def taskListQuery = Tarea.where {
            fechaLimite < (new Date() - 1) &&
            cerrada == false &&
            responsable == springSecurityService.currentUser
        }
        def taskList = taskListQuery.list(sort:"id")
        
        //Compartidos
        def usuariosDeTarea = UsuarioDeTarea.findAllByUsuarioAndOwner(springSecurityService.currentUser, false)
        def sharedTaskList = usuariosDeTarea*.tarea        
        sharedTaskList = sharedTaskList.findAll {
            it.fechaLimite < (new Date() - 1) &&
            it.cerrada == false &&
            it.responsable != springSecurityService.currentUser &&
            it.creadaPor != springSecurityService.currentUser
        }
        
        //Turnados
        def turnadosQuery = Tarea.where {
            fechaLimite < (new Date() - 1) &&
            cerrada == false &&
            responsable != springSecurityService.currentUser &&
            creadaPor == springSecurityService.currentUser
        }
        def turnados = turnadosQuery.list(sort:"id")
        
        render (
            view: "list", 
            model: [
                tareaInstanceList: taskList, 
                tareaInstanceTotal: taskList.size(),
                sharedTaskList : sharedTaskList,
                sharedTaskTotal : sharedTaskList.size(),
                turnadosList : turnados,
                turnadosTotal : turnados.size()
            ]
        )
    }
    
    def concluidas () {
        session.opt = params.action
        
        //Mis turnos        
        def taskListQuery = Tarea.where {
            cerrada == true &&
            responsable == springSecurityService.currentUser
        }
        def taskList = taskListQuery.list(sort:"id")
        
        //Compartidos
        def usuariosDeTarea = UsuarioDeTarea.findAllByUsuarioAndOwner(springSecurityService.currentUser, false)
        def sharedTaskList = usuariosDeTarea*.tarea        
        sharedTaskList = sharedTaskList.findAll {
            it.cerrada == true &&
            it.responsable != springSecurityService.currentUser &&
            it.creadaPor != springSecurityService.currentUser
        }
        
        //Turnados
        def turnadosQuery = Tarea.where {
            cerrada == true &&
            responsable != springSecurityService.currentUser &&
            creadaPor == springSecurityService.currentUser
        }
        def turnados = turnadosQuery.list(sort:"id")
        
        render (
            view: "list", 
            model: [
                tareaInstanceList: taskList, 
                tareaInstanceTotal: taskList.size(),
                sharedTaskList : sharedTaskList,
                sharedTaskTotal : sharedTaskList.size(),
                turnadosList : turnados,
                turnadosTotal : turnados.size()
            ]
        )
    }
    
    def historial (Long id) {
        def tareaInstance = Tarea.get(id)
        [ tareaInstance : tareaInstance, histList : HistorialDeTarea.findAllByTarea(tareaInstance)]
    }
    
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [tareaInstanceList: Tarea.list(params), tareaInstanceTotal: Tarea.count()]
    }

    def create() {
        if (params.idConvenio) {
            session.idConvenio = params.idConvenio as long
        } else {
            session.idConvenio = null
        }
        if (params.idOtorgamientoDePoder) {
            session.idOtorgamientoDePoder = params.idOtorgamientoDePoder as long
        } else {
            session.idOtorgamientoDePoder = null
        }
        if (params.idRevocacionDePoder) {
            session.idRevocacionDePoder = params.idRevocacionDePoder as long
        } else {
            session.idRevocacionDePoder = null
        }
        [tareaInstance: new Tarea(params)]
    }

    def save() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date fechaLimite = null
        if (params.fechaLimite != "") {
            fechaLimite = sdf.parse(params.fechaLimite)
        }
        params.fechaLimite = fechaLimite
        params.creadaPor = springSecurityService.currentUser
        params.asignadaA = springSecurityService.currentUser
        def tareaInstance = new Tarea(params)
        if (!tareaInstance.save(flush: true)) {
            render(view: "create", model: [tareaInstance: tareaInstance])
            return
        }

        //Se agrega el que lo creó como dueño y se le comparte por default
        def creadaPor = new UsuarioDeTarea()
        creadaPor.usuario = springSecurityService.currentUser
        creadaPor.owner = true
        creadaPor.tarea = tareaInstance
        creadaPor.save(flush:true)
        
        //Si el responsable es distinto al creador, se le asigna
        if (params.responsable.id as long != springSecurityService.currentUser.id) {
            def responsable = new UsuarioDeTarea()
            responsable.usuario = Usuario.get(params.responsable.id as long)
            responsable.owner = false
            responsable.tarea = tareaInstance
            if (responsable.save(flush:true)) {
                notificacionesService.tareaAsignada(tareaInstance, responsable.usuario)
            }
        }
        
        //Integración con Convenios
        if (session.idConvenio) {
            def convenioInstance = Convenio.get(session.idConvenio)
            convenioInstance.addToTareas(tareaInstance).save(flush:true)
        }
        //Integración con Otorgamiento De Poder
        if (session.idOtorgamientoDePoder){
            def otorgamientoDePoderInstance = OtorgamientoDePoder.get(session.idOtorgamientoDePoder)
            otorgamientoDePoderInstance.addToTareas(tareaInstance).save(flush:true)
        }
        //Integración con Revocación De Poder
        if (session.idRevocacionDePoder){
            def revocacionDePoderInstance = RevocacionDePoder.get(session.idRevocacionDePoder)
            revocacionDePoderInstance.addToTareas(tareaInstance).save(flush:true)
        }
            
        historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "creó un turno")        
        flash.message = message(code: 'default.created.message', args: [message(code: 'tarea.label', default: 'Turno'), tareaInstance.id])
        redirect(action: "show", id: tareaInstance.id)
    }

    def show(Long id) {
        if (params.idConvenio) {
            session.idConvenio = params.idConvenio as long
        } else {
            session.idConvenio = null
        }
        if (params.idOtorgamientoDePoder) {
            session.idOtorgamientoDePoder = params.idOtorgamientoDePoder as long
        } else {
            session.idOtorgamientoDePoder = null
        }
        if (params.idRevocacionDePoder) {
            session.idRevocacionDePoder = params.idRevocacionDePoder as long
        } else {
            session.idRevocacionDePoder = null
        }
        def tareaInstance = Tarea.get(id)
        def fechaHoy = new Date()
        def fechaLimite = tareaInstance.fechaLimite
        def alertaVencimiento = tareaInstance.alertaVencimiento
        TimeDuration tiempo = TimeCategory.minus(fechaLimite, fechaHoy)
        if(tiempo.days == (alertaVencimiento as int) && !tareaInstance.notas){
            flash.warn = "El Turno aun no ha sido Atendido."
        }else{
            flash.warn = null 
        }
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "list")
            return
        }
        if (tareaInstance.creadaPor != springSecurityService.currentUser) {
            historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "abrió un turno")
        }
        [tareaInstance: tareaInstance, currentUser : springSecurityService.currentUser]
    }

    def edit(Long id) {
        def tareaInstance = Tarea.get(id)
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "list")
            return
        }

        [tareaInstance: tareaInstance]
    }

    def update(Long id, Long version) {
        
        def tareaInstance = Tarea.get(id)
               
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (tareaInstance.version > version) {
                tareaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'tarea.label', default: 'Turno')] as Object[],
                          "Another user has updated this Tarea while you were editing")
                render(view: "edit", model: [tareaInstance: tareaInstance])
                return
            }
        }

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        params.fechaLimite = params.fechaLimite!=""?sdf.parse(params.fechaLimite):null
        tareaInstance.properties = params

        if (!tareaInstance.save(flush: true)) {
            render(view: "edit", model: [tareaInstance: tareaInstance])
            return
        }

        notificacionesService.tareaAsignada(tareaInstance, tareaInstance.creadaPor)    
        historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "editó un turno")
        flash.message = message(code: 'default.updated.message', args: [message(code: 'tarea.label', default: 'Turno'), tareaInstance.id])
        redirect(action: "show", id: tareaInstance.id)
    }

    def delete(Long id) {
        def tareaInstance = Tarea.get(id)
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "list")
            return
        }

        try {
            tareaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "show", id: id)
        }
    }
    
    def share (Long id) {
        def tareaInstance = Tarea.get(id)
        [ tareaInstance : tareaInstance ]
    }
    
    def addUsuarioToTarea(Long id) {
        def tareaInstance = Tarea.get(id)        
        def compartirCon = Usuario.get(params.compartidoCon.id as long)
        def lista = tareaInstance.usuariosDeTarea
        def existe = false
        lista.each {
            if (it.usuario.id == compartirCon.id) {
                existe = true
            }
        }
        if (!existe) {
            def usuarioDeTarea = new UsuarioDeTarea()
            usuarioDeTarea.usuario = compartirCon
            usuarioDeTarea.owner = false
            usuarioDeTarea.tarea = tareaInstance
            if (usuarioDeTarea.save(flush:true)) {            
                notificacionesService.tareaCompartida(tareaInstance, usuarioDeTarea.usuario)
            }
            flash.message = "Tarea compartida satisfactoriamente."
        } else {
            flash.warn = "Ya se encuentra compartida con el usuario seleccionado."
        }
        redirect (action:"share", params : [ id : tareaInstance.id ])
    }
    
    def removeUsuarioFromTarea() {
        def tareaInstance = Tarea.get(params.tareaId as long)
        def usuario = Usuario.get(params.usuarioId as long)
        def usuarioDeTarea = UsuarioDeTarea.findByTareaAndUsuario(tareaInstance, usuario)
        usuarioDeTarea.delete()
        redirect (action:"share", params : [ id : tareaInstance.id ])
    }
    
    def regresar(Long id) {
        redirect(action: "show", id: id)
    }
    
    def cerrarTarea (Long id) {
        def tareaInstance = Tarea.get(id)
        tareaInstance.cerrada = true
        if (tareaInstance.save(flush:true)) {
            def usuariosDeTarea = tareaInstance.usuariosDeTarea
            usuariosDeTarea.each { it ->
                notificacionesService.tareaCerrada(tareaInstance, it.usuario)
            }
            historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "concluyó un turno")
            flash.message = "La tarea fue cerrada satisfactoriamente."            
        } else {
            flash.message = "No se pudo cerrar la tarea. Intente nuevamente."
        }
        redirect (action:"show", id:tareaInstance.id)
    }    
    
    def notificationByEmail () {
        def message = "Tienes una nueva tarea asignada."
        [ tareaInstance : Tarea.get(1), message : message, usuarioInstance : springSecurityService.currentUser ]
    }
    
    def consultaTarea() {
        flash.error = null
        flash.info = null
        flash.message = null
        flash.warn = null
        [porFolioActive:"active"]  
    }
    
    def buscarPorFolio (){
        flash.warn = null
        def porFolioActive = null
        if (params.inActive=="porFolio") {
            porFolioActive = "active"
        }        
        def tareaInstanceList = []
        def inActive = "active"
        if(params.id?.isNumber()){
            tareaInstanceList = Tarea.findAllById(params.id) 
        }else{
            flash.warn = "Valor no válido. El campo debe contener sólo Números Enteros."
        }   
        session.tareaInstanceList = tareaInstanceList
        session.inActive = inActive
        render(
            view: "consultaTarea", 
            model: [
                tareaInstanceList: tareaInstanceList,
                tareaInstanceTotal: tareaInstanceList.size(),
                id: params.id,
                porFolioActive : porFolioActive
                
            ]
        )  
    }
    def buscarPorFechaRegistro () {
        def porFechaRegistroActive = null
        if (params.inActive=="porFechaRegistro") {
            porFechaRegistroActive = "active"
        }        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")       
        def rangoDeFechaRegistro = null
        def fechaInicio = null
        def fechaFin = null
        def busquedaBean = null
        def tareaInstanceList = []
        if (params.rangoDeFechaRegistro != "") {
            flash.warn = null
            rangoDeFechaRegistro = params.rangoDeFechaRegistro
            fechaInicio = sdf.parse(rangoDeFechaRegistro.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFechaRegistro.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            tareaInstanceList = Tarea.findAllByDateCreatedBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        session.tareaInstanceList = tareaInstanceList
        render(
            view: "consultaTarea", 
            model: [
                tareaInstanceList: tareaInstanceList, 
                tareaInstanceTotal: tareaInstanceList.size(),
                busquedaBean : busquedaBean,
                rangoDeFechaRegistro : params.rangoDeFechaRegistro,
                porFechaRegistroActive : porFechaRegistroActive
            ]
        )
    }
    def rangoDeFecha () {
        def rangoDeFechaActive = null
        if (params.inActive=="rangoDeFecha") {
            rangoDeFechaActive = "active"
        }        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")       
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
            tareaInstanceList = Tarea.findAllByFechaLimiteBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin,, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        session.tareaInstanceList = tareaInstanceList
        render(
            view: "consultaTarea", 
            model: [
                tareaInstanceList: tareaInstanceList, 
                tareaInstanceTotal: tareaInstanceList.size(),
                busquedaBean : busquedaBean,
                rangoDeFecha : params.rangoDeFecha,
                rangoDeFechaActive : rangoDeFechaActive
            ]
        )
    }
    def buscarPorNombreResponsables (){
        def nombreResponsablesActive = null
        if (params.inActive=="nombreResponsables") {
            nombreResponsablesActive = "active"
        }         
        def c = Tarea.createCriteria()
        def tareaInstanceList = c.list {
            responsable {
                like("username", "%"+params.username+"%")
            }
            order("id", "asc")
        }
        session.tareaInstanceList = tareaInstanceList
        render(
            view: "consultaTarea", 
            model: [
                tareaInstanceList: tareaInstanceList,
                tareaInstanceTotal: tareaInstanceList.size(),
                nombreResponsablesActive : nombreResponsablesActive       
            ]
        )       
    }
    def generarReporte(){
        def tareaInstanceList = session.tareaInstanceList
        def inActive = session.inActive
        log.info "activo:." + session.inActive
        log.info "total::." + session.tareaInstanceList.size()
        log.info "params::::::::::::::::"+ params
        log.info "tareainstance::::::"+ session.tareaInstanceList
        if (tareaInstanceList.size() != 0) {
            log.info "despues del if::::::"+ tareaInstanceList
            flash.warn = null
            if(params?.format && params.format != "html"){
                response.contentType = grailsApplication.config.grails.mime.types[params.format]
                response.setHeader("Content-disposition", "attachment; filename= Turnos.${params.extension}")
                List fields = ["id", "nombre", "grupo", "dateCreated", "responsable", "descripcion", "prioridad","fechaLimite"]
                Map labels = ["id": "Número de Turno", "nombre": "Nombre","grupo":"Compartida con","dateCreated":"Fecha de Registro",\
                              "responsable":"Responsable","descripcion":"Descripción","prioridad":"Prioridad","fechaLimite":"Fecha Limite del Turno"]
                def upperCase = { domain, value ->
                    return value.toUpperCase()
                }
                Map formatters = [nombre: upperCase]		
                Map parameters = [title: "Reporte De Turnos", "column.widths": [0.2, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4], "title.font.size":12]

                exportService.export(params.format, response.outputStream, session.tareaInstanceList, fields, labels, formatters, parameters)
            }
        }else{
            log.info "<<<aaaaaaaaaaaaaaaaa" 
            flash.warn = "No hay datos para generar reporte."
            
        }
        render(
            view: "consultaTarea", 
            model: [inActive: inActive, tareaInstanceList: tareaInstanceList ]
        )  
    }
    def detalles(Long id){
        def tareaInstance = Tarea.get(id)
        log.info "id de tarea "+ id
        [ tareaInstance : tareaInstance ]
    }
    
}
