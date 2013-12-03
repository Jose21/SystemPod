package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException

class CartaDeInstruccionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cartaDeInstruccionInstanceList: CartaDeInstruccion.list(params), cartaDeInstruccionInstanceTotal: CartaDeInstruccion.count()]
    }

    def create() {
        [cartaDeInstruccionInstance: new CartaDeInstruccion(params)]
    }

    def save() {
        def cartaDeInstruccionInstance = new CartaDeInstruccion(params)
        if (!cartaDeInstruccionInstance.save(flush: true)) {
            render(view: "create", model: [cartaDeInstruccionInstance: cartaDeInstruccionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion'), cartaDeInstruccionInstance.id])
        redirect(action: "show", id: cartaDeInstruccionInstance.id)
    }

    def show(Long id) {
        def cartaDeInstruccionInstance = CartaDeInstruccion.get(id)
        if (!cartaDeInstruccionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion'), id])
            redirect(action: "list")
            return
        }

        [cartaDeInstruccionInstance: cartaDeInstruccionInstance]
    }

    def edit(Long id) {
        def cartaDeInstruccionInstance = CartaDeInstruccion.get(id)
        if (!cartaDeInstruccionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion'), id])
            redirect(action: "list")
            return
        }

        [cartaDeInstruccionInstance: cartaDeInstruccionInstance]
    }

    def update(Long id, Long version) {
        def cartaDeInstruccionInstance = CartaDeInstruccion.get(id)
        if (!cartaDeInstruccionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (cartaDeInstruccionInstance.version > version) {
                cartaDeInstruccionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion')] as Object[],
                          "Another user has updated this CartaDeInstruccion while you were editing")
                render(view: "edit", model: [cartaDeInstruccionInstance: cartaDeInstruccionInstance])
                return
            }
        }

        cartaDeInstruccionInstance.properties = params

        if (!cartaDeInstruccionInstance.save(flush: true)) {
            render(view: "edit", model: [cartaDeInstruccionInstance: cartaDeInstruccionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion'), cartaDeInstruccionInstance.id])
        redirect(action: "show", id: cartaDeInstruccionInstance.id)
    }

    def delete(Long id) {
        def cartaDeInstruccionInstance = CartaDeInstruccion.get(id)
        if (!cartaDeInstruccionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion'), id])
            redirect(action: "list")
            return
        }

        try {
            cartaDeInstruccionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion'), id])
            redirect(action: "show", id: id)
        }
    }
}
