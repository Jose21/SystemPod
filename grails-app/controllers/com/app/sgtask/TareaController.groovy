package com.app.sgtask

import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat
import com.app.security.Usuario
import grails.plugin.asyncmail.AsynchronousMailService

class TareaController {

    def historialDeTareaService
    def springSecurityService
    AsynchronousMailService asyncMailService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    //TODO desacoplar funcionalidad de correo electronico y pasarlo al servicio
    def reasignar (Long id) {        
        def tareaInstance = Tarea.get(id)
        def asignarA = Usuario.get(params.asignadaA.id)
        if (tareaInstance.asignadaA != asignarA) {
            tareaInstance.asignadaA = asignarA
            if (tareaInstance.save(flush:true)) {
                historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "reasignó una tarea")
                def emailPattern = /[_A-Za-z0-9-]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})/
                //def email = params.alertaPorEmail.trim()
                def email = asignarA.email
                if (email != "") {
                    if (email ==~ emailPattern) { 
                       asyncMailService.sendMail {
                            to email
                            subject "Tienes una nueva tarea asignada."
                            html "<body><b>Te han asignado la tarea con folio ${tareaInstance.id}.</b></body>"
                        }
                    } else {
                        flash.warn = "No se envío el email. El email ingresado (${email}) no es válido."
                    }
                    flash.message = "La tarea " + tareaInstance.id + " fue reasignada satisfactoriamente."
                } else {
                    flash.warn = "No se envió el email de notificación. El usuario seleccionado no tiene una dirección de email asociado."
                    flash.message = "La tarea "+tareaInstance.id+" fue reasignada satisfactoriamente."
                }
                redirect (action:session.opt, id:tareaInstance.id)
            } else {
                flash.error = "La tarea no pudo ser reasiganda. Favor de intentar nuevamente."
                redirect (action:"show", id:tareaInstance.id)
            }
        } else {
            flash.warn = "Ya se encuentra asignada al usuario seleccionado."
            redirect (action:"show", id:tareaInstance.id)
        }
    }
    
    def cerrarTarea (Long id) {
        def tareaInstance = Tarea.get(id)
        tareaInstance.cerrada = true
        if (tareaInstance.save(flush:true)) {
            historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "concluyó una tarea")
            flash.message = "La tarea fue cerrada satisfactoriamente."            
        } else {
            flash.message = "No se pudo cerrar la tarea. Intente nuevamente."
        }
        redirect (action:"show", id:tareaInstance.id)
    }
    
    def hoy() {
        session.opt = params.action
        def taskList = Tarea.findAllByFechaLimiteAndAsignadaA(null, springSecurityService.currentUser);
        render(view: "list", model: [tareaInstanceList: taskList, tareaInstanceTotal: taskList.size()])
    }
    
    def programadas() {
        session.opt = params.action
        def taskList = Tarea.findAllByFechaLimiteGreaterThanEqualsAndAsignadaA(new Date(), springSecurityService.currentUser);
        render(view: "list", model: [tareaInstanceList: taskList, tareaInstanceTotal: taskList.size()])
    }
    
    def retrasadas () {
        session.opt = params.action
        def taskList = Tarea.findAllByFechaLimiteLessThanAndAsignadaA(new Date(), springSecurityService.currentUser);
        render(view: "list", model: [tareaInstanceList: taskList, tareaInstanceTotal: taskList.size()])
    }
    
    def asignadas () {
        session.opt = params.action
        def taskList = Tarea.findAllByAsignadaA(springSecurityService.currentUser);
        render(view: "list", model: [tareaInstanceList: taskList, tareaInstanceTotal: taskList.size()])
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
        [tareaInstance: new Tarea(params)]
    }

    def save() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date fechaLimite = sdf.parse(params.fechaLimite)
        params.fechaLimite = fechaLimite
        params.creadaPor = springSecurityService.currentUser
        params.asignadaA = springSecurityService.currentUser
        def tareaInstance = new Tarea(params)
        if (!tareaInstance.save(flush: true)) {
            render(view: "create", model: [tareaInstance: tareaInstance])
            return
        }

        historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "creó una tarea")        
        flash.message = message(code: 'default.created.message', args: [message(code: 'tarea.label', default: 'Tarea'), tareaInstance.id])
        redirect(action: "show", id: tareaInstance.id)
    }

    def show(Long id) {
        def tareaInstance = Tarea.get(id)
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Tarea'), id])
            redirect(action: "list")
            return
        }
        if (tareaInstance.creadaPor != springSecurityService.currentUser) {
            historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "abrió una tarea")
        }
        [tareaInstance: tareaInstance]
    }

    def edit(Long id) {
        def tareaInstance = Tarea.get(id)
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Tarea'), id])
            redirect(action: "list")
            return
        }

        [tareaInstance: tareaInstance]
    }

    def update(Long id, Long version) {
        
        def tareaInstance = Tarea.get(id)
               
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Tarea'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (tareaInstance.version > version) {
                tareaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'tarea.label', default: 'Tarea')] as Object[],
                          "Another user has updated this Tarea while you were editing")
                render(view: "edit", model: [tareaInstance: tareaInstance])
                return
            }
        }

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date fechaLimite = sdf.parse(params.fechaLimite)
        params.fechaLimite = fechaLimite        
        tareaInstance.properties = params
        
        if (!tareaInstance.save(flush: true)) {
            render(view: "edit", model: [tareaInstance: tareaInstance])
            return
        }

        historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "editó una tarea")
        flash.message = message(code: 'default.updated.message', args: [message(code: 'tarea.label', default: 'Tarea'), tareaInstance.id])
        redirect(action: "show", id: tareaInstance.id)
    }

    def delete(Long id) {
        def tareaInstance = Tarea.get(id)
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Tarea'), id])
            redirect(action: "list")
            return
        }

        try {
            tareaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'tarea.label', default: 'Tarea'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tarea.label', default: 'Tarea'), id])
            redirect(action: "show", id: id)
        }
    }
}
