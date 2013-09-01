package com.app.sgtask

import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat

class TareaController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def cerrarTarea (Long id) {
        def tareaInstance = Tarea.get(id)
        tareaInstance.cerrada = true
        if (tareaInstance.save(flush:true)) {
            flash.message = "La tarea fue cerrada satisfactoriamente."
        } else {
            flash.message = "No se pudo cerrar la tarea. Intente nuevamente."
        }
        redirect (action:"show", id:tareaInstance.id)
    }
    
    def hoy() {
        def taskList = Tarea.findAllByFechaLimite(null);
        render(view: "list", model: [tareaInstanceList: taskList, tareaInstanceTotal: taskList.size(), opt:"hoy"])
    }
    
    def programadas() {
        def taskList = Tarea.findAllByFechaLimiteGreaterThanEquals(new Date());
        render(view: "list", model: [tareaInstanceList: taskList, tareaInstanceTotal: taskList.size(), opt:"programadas"])
    }
    
    def retrasadas () {
        def taskList = Tarea.findAllByFechaLimiteLessThan(new Date());
        render(view: "list", model: [tareaInstanceList: taskList, tareaInstanceTotal: taskList.size(), opt:"retrasadas"])
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
        def tareaInstance = new Tarea(params)
        if (!tareaInstance.save(flush: true)) {
            render(view: "create", model: [tareaInstance: tareaInstance])
            return
        }

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
