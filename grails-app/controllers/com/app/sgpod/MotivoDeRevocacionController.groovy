package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException

class MotivoDeRevocacionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    /**
    * Método apara enlistar los registros existentes en una domain class 
    */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [motivoDeRevocacionInstanceList: MotivoDeRevocacion.list(params), motivoDeRevocacionInstanceTotal: MotivoDeRevocacion.count()]
    }
    /**
    * Este método sirve para la creacion de un registro de tipo asistente.
    */
    def create() {        
        [motivoDeRevocacionInstance: new MotivoDeRevocacion(params)]
    }
    /**
    * Método para guardar los registros en el sistema.
    */
    def save() {        
        def motivoDeRevocacionInstance = new MotivoDeRevocacion(params)
        if (!motivoDeRevocacionInstance.save(flush: true)) {
            render(view: "create", model: [motivoDeRevocacionInstance: motivoDeRevocacionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion'), motivoDeRevocacionInstance.id])
        redirect(action: "show", id: motivoDeRevocacionInstance.id)
    }
    /**
    * Método para visualizar el registro creado en el sistema.
    */
    def show(Long id) {
        def motivoDeRevocacionInstance = MotivoDeRevocacion.get(id)
        if (!motivoDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        [motivoDeRevocacionInstance: motivoDeRevocacionInstance]
    }
     /**
    * Método para editar un registro.
    */
    def edit(Long id) {
        def motivoDeRevocacionInstance = MotivoDeRevocacion.get(id)
        if (!motivoDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        [motivoDeRevocacionInstance: motivoDeRevocacionInstance]
    }
    /**
    * Método para actualizar los datos de un registro.
    */
    def update(Long id, Long version) {
        def motivoDeRevocacionInstance = MotivoDeRevocacion.get(id)
        if (!motivoDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (motivoDeRevocacionInstance.version > version) {
                motivoDeRevocacionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion')] as Object[],
                          "Another user has updated this MotivoDeRevocacion while you were editing")
                render(view: "edit", model: [motivoDeRevocacionInstance: motivoDeRevocacionInstance])
                return
            }
        }

        motivoDeRevocacionInstance.properties = params

        if (!motivoDeRevocacionInstance.save(flush: true)) {
            render(view: "edit", model: [motivoDeRevocacionInstance: motivoDeRevocacionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion'), motivoDeRevocacionInstance.id])
        redirect(action: "show", id: motivoDeRevocacionInstance.id)
    }
    /**
    * Método para eliminar el registro del sistema.
    */
    def delete(Long id) {
        def motivoDeRevocacionInstance = MotivoDeRevocacion.get(id)
        if (!motivoDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        try {
            motivoDeRevocacionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion'), id])
            redirect(action: "show", id: id)
        }
    }
    /**
    * Método para crear un nuevo motivo de rechazo.
    */
    def nuevoMotivoDeRevocacion() {
        def revocacionDePoderInstance = RevocacionDePoder.get(params.revocacionDePoder.id as long)
         def motivoDeRevocacionInstance = new MotivoDeRevocacion(params)
        if (!motivoDeRevocacionInstance.save(flush: true)) {
            redirect(controller:"revocacionDePoder", action: "edit", id: revocacionDePoderInstance.id)
            return
        }
        
        flash.message = message(code: 'default.updated.message', args: [message(code: 'revocacionDePoder.label', default: 'Motivo de Revocación'), revocacionDePoderInstance.id])
        redirect(controller:"revocacionDePoder", action: "edit", id: params.revocacionDePoder.id, params : [ anchor : params.anchor ])                
    }
}
