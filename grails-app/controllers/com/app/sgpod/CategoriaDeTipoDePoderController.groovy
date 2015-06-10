package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class CategoriaDeTipoDePoderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [categoriaDeTipoDePoderInstanceList: CategoriaDeTipoDePoder.list(params), categoriaDeTipoDePoderInstanceTotal: CategoriaDeTipoDePoder.count()]
    }

    def create() {
        [categoriaDeTipoDePoderInstance: new CategoriaDeTipoDePoder(params)]
    }

    def save() {
        def categoriaDeTipoDePoderInstance = new CategoriaDeTipoDePoder(params)
        if (!categoriaDeTipoDePoderInstance.save(flush: true)) {
            render(view: "create", model: [categoriaDeTipoDePoderInstance: categoriaDeTipoDePoderInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'categoriaDeTipoDePoder.label', default: 'CategoriaDeTipoDePoder'), categoriaDeTipoDePoderInstance.id])
        redirect(action: "show", id: categoriaDeTipoDePoderInstance.id)
    }

    def show(Long id) {
        def categoriaDeTipoDePoderInstance = CategoriaDeTipoDePoder.get(id)
        if (!categoriaDeTipoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'categoriaDeTipoDePoder.label', default: 'CategoriaDeTipoDePoder'), id])
            redirect(action: "list")
            return
        }

        [categoriaDeTipoDePoderInstance: categoriaDeTipoDePoderInstance]
    }

    def edit(Long id) {
        def categoriaDeTipoDePoderInstance = CategoriaDeTipoDePoder.get(id)
        if (!categoriaDeTipoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'categoriaDeTipoDePoder.label', default: 'CategoriaDeTipoDePoder'), id])
            redirect(action: "list")
            return
        }

        [categoriaDeTipoDePoderInstance: categoriaDeTipoDePoderInstance]
    }

    def update(Long id, Long version) {
        def categoriaDeTipoDePoderInstance = CategoriaDeTipoDePoder.get(id)
        if (!categoriaDeTipoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'categoriaDeTipoDePoder.label', default: 'CategoriaDeTipoDePoder'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (categoriaDeTipoDePoderInstance.version > version) {
                categoriaDeTipoDePoderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'categoriaDeTipoDePoder.label', default: 'CategoriaDeTipoDePoder')] as Object[],
                          "Another user has updated this CategoriaDeTipoDePoder while you were editing")
                render(view: "edit", model: [categoriaDeTipoDePoderInstance: categoriaDeTipoDePoderInstance])
                return
            }
        }

        categoriaDeTipoDePoderInstance.properties = params

        if (!categoriaDeTipoDePoderInstance.save(flush: true)) {
            render(view: "edit", model: [categoriaDeTipoDePoderInstance: categoriaDeTipoDePoderInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'categoriaDeTipoDePoder.label', default: 'CategoriaDeTipoDePoder'), categoriaDeTipoDePoderInstance.id])
        redirect(action: "show", id: categoriaDeTipoDePoderInstance.id)
    }

    def delete(Long id) {
        def categoriaDeTipoDePoderInstance = CategoriaDeTipoDePoder.get(id)
        if (!categoriaDeTipoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'categoriaDeTipoDePoder.label', default: 'CategoriaDeTipoDePoder'), id])
            redirect(action: "list")
            return
        }

        try {
            categoriaDeTipoDePoderInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'categoriaDeTipoDePoder.label', default: 'CategoriaDeTipoDePoder'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'categoriaDeTipoDePoder.label', default: 'CategoriaDeTipoDePoder'), id])
            redirect(action: "show", id: id)
        }
    }
}
