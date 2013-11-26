package com.app.sgtask

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class NotaController {

    def historialDeTareaService
    def springSecurityService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [notaInstanceList: Nota.list(params), notaInstanceTotal: Nota.count()]
    }

    def create() {
        session.tareaId = params.tareaId
        [notaInstance: new Nota(params)]
    }

    def save() {
        def tareaId = session.tareaId
        params.agregadaPor = springSecurityService.currentUser
        def notaInstance = new Nota(params)
        notaInstance.tarea = Tarea.get(params.tarea as long)
        
        if (!notaInstance.validate()) {
            notaInstance.errors.each {}
        }
        if (!notaInstance.save(flush: true)) {
            render(view: "create", model: [notaInstance: notaInstance])
            return
        }
        if (params.archivo.getSize()!=0) {            
            def documentoInstance = new Documento(params)
            documentoInstance.nombre = params.archivo.getOriginalFilename()
            notaInstance.addToDocumentos(documentoInstance)
            if (!notaInstance.save(flush: true)) {
                render(view: "create", model: [notaInstance: notaInstance])
                return
            }
        }
        historialDeTareaService.agregar(notaInstance.tarea, springSecurityService.currentUser, "agregó una nota")
        flash.message = message(code: 'default.created.message', args: [message(code: 'nota.label', default: 'Nota'), notaInstance.id])
        redirect(controller:"tarea", action: "show", id: tareaId)
    }

    def show(Long id) {
        def notaInstance = Nota.get(id)
        if (!notaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(action: "list")
            return
        }

        [notaInstance: notaInstance]
    }

    def edit(Long id) {
        def notaInstance = Nota.get(id)
        session.tareaId = params.tareaId
        if (!notaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(action: "list")
            return
        }
        [notaInstance: notaInstance]
    }

    def update(Long id, Long version) {
        def notaInstance = Nota.get(id)
        def tareaId = session.tareaId
        if (!notaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(controller:"tarea",action: "list")
            return
        }

        if (version != null) {
            if (notaInstance.version > version) {
                notaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'nota.label', default: 'Nota')] as Object[],
                          "Another user has updated this Nota while you were editing")
                render(view: "edit", model: [notaInstance: notaInstance])
                return
            }
        }

        notaInstance.properties = params
        println "f"+ params.archivo

        if (!notaInstance.validate()) {
            notaInstance.errors.each {}
        }
        if (!notaInstance.save(flush: true)) {
            render(view: "edit", model: [notaInstance: notaInstance])
            return
        }
        println "ewfwfwferfrewf"+ params.archivo
        if (params.archivo.getSize()!=0) {            
            def documentoInstance = new Documento(params)
            documentoInstance.nombre = params.archivo.getOriginalFilename()
            notaInstance.addToDocumentos(documentoInstance)
            if (!notaInstance.save(flush: true)) {
                render(view: "create", model: [notaInstance: notaInstance])
                return
            }
        }

        historialDeTareaService.agregar(Tarea.get(tareaId as long), springSecurityService.currentUser, "modificó una nota")
        flash.message = message(code: 'default.updated.message', args: [message(code: 'nota.label', default: 'Nota'), notaInstance.id])
        redirect(controller:"tarea", action: "show", id: tareaId)
    }

    def delete(Long id) {
        def notaInstance = Nota.get(id)
        if (!notaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(action: "list")
            return
        }

        try {
            notaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(action: "show", id: id)
        }
    }
}
