package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException

class MotivoDeRevocacionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [motivoDeRevocacionInstanceList: MotivoDeRevocacion.list(params), motivoDeRevocacionInstanceTotal: MotivoDeRevocacion.count()]
    }

    def create() {
        [motivoDeRevocacionInstance: new MotivoDeRevocacion(params)]
    }

    def save() {
        def motivoDeRevocacionInstance = new MotivoDeRevocacion(params)
        if (!motivoDeRevocacionInstance.save(flush: true)) {
            render(view: "create", model: [motivoDeRevocacionInstance: motivoDeRevocacionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion'), motivoDeRevocacionInstance.id])
        redirect(action: "show", id: motivoDeRevocacionInstance.id)
    }

    def show(Long id) {
        def motivoDeRevocacionInstance = MotivoDeRevocacion.get(id)
        if (!motivoDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        [motivoDeRevocacionInstance: motivoDeRevocacionInstance]
    }

    def edit(Long id) {
        def motivoDeRevocacionInstance = MotivoDeRevocacion.get(id)
        if (!motivoDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'motivoDeRevocacion.label', default: 'MotivoDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        [motivoDeRevocacionInstance: motivoDeRevocacionInstance]
    }

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
}
