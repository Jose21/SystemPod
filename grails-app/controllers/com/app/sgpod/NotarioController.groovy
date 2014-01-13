package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException

class NotarioController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [notarioInstanceList: Notario.list(params), notarioInstanceTotal: Notario.count()]
    }

    def create() {
        [notarioInstance: new Notario(params)]
    }

    def save() {
        def notarioInstance = new Notario(params)
        if (!notarioInstance.save(flush: true)) {
            render(view: "create", model: [notarioInstance: notarioInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'notario.label', default: 'Notario'), notarioInstance.id])
        redirect(action: "show", id: notarioInstance.id)
    }

    def show(Long id) {
        def notarioInstance = Notario.get(id)
        if (!notarioInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'notario.label', default: 'Notario'), id])
            redirect(action: "list")
            return
        }

        [notarioInstance: notarioInstance]
    }

    def edit(Long id) {
        def notarioInstance = Notario.get(id)
        if (!notarioInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'notario.label', default: 'Notario'), id])
            redirect(action: "list")
            return
        }

        [notarioInstance: notarioInstance]
    }

    def update(Long id, Long version) {
        def notarioInstance = Notario.get(id)
        if (!notarioInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'notario.label', default: 'Notario'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (notarioInstance.version > version) {
                notarioInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'notario.label', default: 'Notario')] as Object[],
                          "Another user has updated this Notario while you were editing")
                render(view: "edit", model: [notarioInstance: notarioInstance])
                return
            }
        }

        notarioInstance.properties = params

        if (!notarioInstance.save(flush: true)) {
            render(view: "edit", model: [notarioInstance: notarioInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'notario.label', default: 'Notario'), notarioInstance.id])
        redirect(action: "show", id: notarioInstance.id)
    }

    def delete(Long id) {
        def notarioInstance = Notario.get(id)
        if (!notarioInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'notario.label', default: 'Notario'), id])
            redirect(action: "list")
            return
        }

        try {
            notarioInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'notario.label', default: 'Notario'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'notario.label', default: 'Notario'), id])
            redirect(action: "show", id: id)
        }
    }
}
