package com.app.sgtask

import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat
import com.app.security.Usuario
import grails.plugin.asyncmail.AsynchronousMailService
import com.app.NotificacionesService
import grails.plugins.springsecurity.Secured
import com.app.sgcon.Convenio

@Secured(['IS_AUTHENTICATED_FULLY'])
class TareaController {

    def historialDeTareaService
    def springSecurityService
    AsynchronousMailService asyncMailService
    NotificacionesService notificacionesService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    
    def hoy() {
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
        def tareaInstance = Tarea.get(id)
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
        def porFolioActive = null
        if (params.inActive=="porFolio") {
            porFolioActive = "active"
        }        
        def id = null
        def tareaInstanceList = null
        def inActive = "active"
        id = params.id
        tareaInstanceList = Tarea.get(params.id)
        if (params.id == "") {
            flash.warn = "No existe el folio buscado "
            
        } else {
            
        }
        session.tareaInstanceList = tareaInstanceList
        session.inActive = inActive
        render(
            view: "consultaTarea", 
            model: [
                tareaInstanceList: tareaInstanceList,
                //tareaInstanceTotal: tareaInstanceList.size(),
                id: params.id,
                porFolioActive : porFolioActive
                
            ]
        )  
    }
    
}
