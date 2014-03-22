package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON

class DelegacionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    /**
    * Método apara enlistar los registros existentes en una domain class 
    */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [delegacionInstanceList: Delegacion.list(params), delegacionInstanceTotal: Delegacion.count()]
    }
     /**
    * Este método sirve para la creacion de un registro de tipo delegación.
    */
    def create() {
        [delegacionInstance: new Delegacion(params)]
    }
    /**
    * Método para guardar los registros en el sistema.
    */
    def save() {
        def delegacionInstance = new Delegacion(params)
        if (!delegacionInstance.save(flush: true)) {
            render(view: "create", model: [delegacionInstance: delegacionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'delegacion.label', default: 'Delegacion'), delegacionInstance.id])
        redirect(action: "show", id: delegacionInstance.id)
    }
     /**
    * Método para guardar los registros en el sistema.
    */
    def saveIt() {
        def delegacionInstance = new Delegacion(params)
        delegacionInstance.save(flush: true)
        flash.message = "La delegación fue agregada satisfactoriamente."
        redirect(controller:params.miController, action: params.miAction, id: params.miPoder)
    }
    /**
    * Método para visualizar el registro creado en el sistema.
    */
    def show(Long id) {
        def delegacionInstance = Delegacion.get(id)
        if (!delegacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'delegacion.label', default: 'Delegacion'), id])
            redirect(action: "list")
            return
        }

        [delegacionInstance: delegacionInstance]
    }
    /**
    * Método para editar un registro.
    */
    def edit(Long id) {
        def delegacionInstance = Delegacion.get(id)
        if (!delegacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'delegacion.label', default: 'Delegacion'), id])
            redirect(action: "list")
            return
        }

        [delegacionInstance: delegacionInstance]
    }
    /**
    * Método para actualizar los datos de un registro.
    */
    def update(Long id, Long version) {
        def delegacionInstance = Delegacion.get(id)
        if (!delegacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'delegacion.label', default: 'Delegacion'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (delegacionInstance.version > version) {
                delegacionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'delegacion.label', default: 'Delegacion')] as Object[],
                          "Another user has updated this Delegacion while you were editing")
                render(view: "edit", model: [delegacionInstance: delegacionInstance])
                return
            }
        }

        delegacionInstance.properties = params

        if (!delegacionInstance.save(flush: true)) {
            render(view: "edit", model: [delegacionInstance: delegacionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'delegacion.label', default: 'Delegacion'), delegacionInstance.id])
        redirect(action: "show", id: delegacionInstance.id)
    }
    /**
    * Método para eliminar el registro del sistema.
    */
    def delete(Long id) {
        def delegacionInstance = Delegacion.get(id)
        if (!delegacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'delegacion.label', default: 'Delegacion'), id])
            redirect(action: "list")
            return
        }

        try {
            delegacionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'delegacion.label', default: 'Delegacion'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'delegacion.label', default: 'Delegacion'), id])
            redirect(action: "show", id: id)
        }
    }    
}
