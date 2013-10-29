package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException

class RevocacionDePoderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [revocacionDePoderInstanceList: RevocacionDePoder.list(params), revocacionDePoderInstanceTotal: RevocacionDePoder.count()]
    }

    def create() {
        [revocacionDePoderInstance: new RevocacionDePoder(params)]
    }

    def save() {
        def revocacionDePoderInstance = new RevocacionDePoder(params)
        if (!revocacionDePoderInstance.save(flush: true)) {
            render(view: "create", model: [revocacionDePoderInstance: revocacionDePoderInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), revocacionDePoderInstance.id])
        redirect(action: "show", id: revocacionDePoderInstance.id)
    }

    def show(Long id) {
        def revocacionDePoderInstance = RevocacionDePoder.get(id)
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }

        [revocacionDePoderInstance: revocacionDePoderInstance]
    }

    def edit(Long id) {
        def revocacionDePoderInstance = RevocacionDePoder.get(id)
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }

        [revocacionDePoderInstance: revocacionDePoderInstance]
    }

    def update(Long id, Long version) {
        def revocacionDePoderInstance = RevocacionDePoder.get(id)
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (revocacionDePoderInstance.version > version) {
                revocacionDePoderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder')] as Object[],
                          "Another user has updated this RevocacionDePoder while you were editing")
                render(view: "edit", model: [revocacionDePoderInstance: revocacionDePoderInstance])
                return
            }
        }

        revocacionDePoderInstance.properties = params

        if (!revocacionDePoderInstance.save(flush: true)) {
            render(view: "edit", model: [revocacionDePoderInstance: revocacionDePoderInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), revocacionDePoderInstance.id])
        redirect(action: "show", id: revocacionDePoderInstance.id)
    }

    def delete(Long id) {
        def revocacionDePoderInstance = RevocacionDePoder.get(id)
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }

        try {
            revocacionDePoderInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "show", id: id)
        }
    }
}
