package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException

class CartaDeInstruccionDeRevocacionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cartaDeInstruccionDeRevocacionInstanceList: CartaDeInstruccionDeRevocacion.list(params), cartaDeInstruccionDeRevocacionInstanceTotal: CartaDeInstruccionDeRevocacion.count()]
    }

    def create() {
        def revocacionDePoderId = params.id
        def formato = FormatoDeCartaDeInstruccion.get(1)
        def cartaDeInstruccionDeRevocacionInstance = new CartaDeInstruccionDeRevocacion(params)
        cartaDeInstruccionDeRevocacionInstance.registro = formato.registro
        cartaDeInstruccionDeRevocacionInstance.fecha = formato.fecha
        cartaDeInstruccionDeRevocacionInstance.contenido = formato.contenido
        
        [cartaDeInstruccionDeRevocacionInstance: cartaDeInstruccionDeRevocacionInstance, revocacionDePoderId : revocacionDePoderId]
    }

    def save() {
        def cartaDeInstruccionDeRevocacionInstance = new CartaDeInstruccionDeRevocacion(params)
        if (!cartaDeInstruccionDeRevocacionInstance.save(flush: true)) {
            render(view: "create", model: [cartaDeInstruccionDeRevocacionInstance: cartaDeInstruccionDeRevocacionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion'), cartaDeInstruccionDeRevocacionInstance.id])
        redirect(controller:"revocacionDePoder", action: "edit", id: cartaDeInstruccionDeRevocacionInstance.id)
    }

    def show(Long id) {
        def cartaDeInstruccionDeRevocacionInstance = CartaDeInstruccionDeRevocacion.get(id)
        if (!cartaDeInstruccionDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        [cartaDeInstruccionDeRevocacionInstance: cartaDeInstruccionDeRevocacionInstance]
    }

    def edit(Long id) {
        def revocacionDePoderId = params.id
        def cartaDeInstruccionDeRevocacionInstance = CartaDeInstruccionDeRevocacion.get(id)
        if (!cartaDeInstruccionDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        [cartaDeInstruccionDeRevocacionInstance: cartaDeInstruccionDeRevocacionInstance, revocacionDePoderId : (params.revocacionId)]
    }

    def update(Long id, Long version) {
        def cartaDeInstruccionDeRevocacionInstance = CartaDeInstruccionDeRevocacion.get(id)
        if (!cartaDeInstruccionDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (cartaDeInstruccionDeRevocacionInstance.version > version) {
                cartaDeInstruccionDeRevocacionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion')] as Object[],
                          "Another user has updated this CartaDeInstruccionDeRevocacion while you were editing")
                render(view: "edit", model: [cartaDeInstruccionDeRevocacionInstance: cartaDeInstruccionDeRevocacionInstance])
                return
            }
        }

        cartaDeInstruccionDeRevocacionInstance.properties = params

        if (!cartaDeInstruccionDeRevocacionInstance.save(flush: true)) {
            render(view: "edit", model: [cartaDeInstruccionDeRevocacionInstance: cartaDeInstruccionDeRevocacionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion'), cartaDeInstruccionDeRevocacionInstance.id])
        redirect(controller:"revocacionDePoder", action: "edit", id: cartaDeInstruccionDeRevocacionInstance.id)
    }

    def delete(Long id) {
        def cartaDeInstruccionDeRevocacionInstance = CartaDeInstruccionDeRevocacion.get(id)
        if (!cartaDeInstruccionDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        try {
            cartaDeInstruccionDeRevocacionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion'), id])
            redirect(action: "show", id: id)
        }
    }
}
