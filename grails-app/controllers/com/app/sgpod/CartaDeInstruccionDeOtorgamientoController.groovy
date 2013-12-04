package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException

class CartaDeInstruccionDeOtorgamientoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cartaDeInstruccionDeOtorgamientoInstanceList: CartaDeInstruccionDeOtorgamiento.list(params), cartaDeInstruccionDeOtorgamientoInstanceTotal: CartaDeInstruccionDeOtorgamiento.count()]
    }

    def create() {
        def otorgamientoDePoderId = params.id
        def formato = FormatoDeCartaDeInstruccion.get(1)
        
        def cartaDeInstruccionDeOtorgamientoInstance = new CartaDeInstruccionDeOtorgamiento(params)
        cartaDeInstruccionDeOtorgamientoInstance.registro = formato.registro
        cartaDeInstruccionDeOtorgamientoInstance.fecha = formato.fecha
        cartaDeInstruccionDeOtorgamientoInstance.contenido = formato.contenido
        
        [cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance, otorgamientoDePoderId : otorgamientoDePoderId]
    }

    def save() {
        def cartaDeInstruccionDeOtorgamientoInstance = new CartaDeInstruccionDeOtorgamiento(params)
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.otorgamientoDePoderId as long)
        cartaDeInstruccionDeOtorgamientoInstance.otorgamientoDePoder = otorgamientoDePoderInstance
        
        if (!cartaDeInstruccionDeOtorgamientoInstance.save(flush: true)) {
            render(view: "create", model: [cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance])
            return
        }
        
        flash.message = message(code: 'default.created.message', args: [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento'), cartaDeInstruccionDeOtorgamientoInstance.id])
        redirect(controller:"otorgamientoDePoder", action: "edit", id: otorgamientoDePoderInstance.id)
    }

    def show(Long id) {
        def cartaDeInstruccionDeOtorgamientoInstance = CartaDeInstruccionDeOtorgamiento.get(id)
        if (!cartaDeInstruccionDeOtorgamientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento'), id])
            redirect(action: "list")
            return
        }

        [cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance]
    }

    def edit(Long id) {
        def cartaDeInstruccionDeOtorgamientoInstance = CartaDeInstruccionDeOtorgamiento.get(id)
        if (!cartaDeInstruccionDeOtorgamientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento'), id])
            redirect(action: "list")
            return
        }

        [cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance, otorgamientoDePoderId : (params.otorgamientoDePoderId)]
    }

    def update(Long id, Long version) {
        def cartaDeInstruccionDeOtorgamientoInstance = CartaDeInstruccionDeOtorgamiento.get(id)
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.otorgamientoDePoderId as long)
        if (!cartaDeInstruccionDeOtorgamientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (cartaDeInstruccionDeOtorgamientoInstance.version > version) {
                cartaDeInstruccionDeOtorgamientoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento')] as Object[],
                          "Another user has updated this CartaDeInstruccionDeOtorgamiento while you were editing")
                render(view: "edit", model: [cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance])
                return
            }
        }

        cartaDeInstruccionDeOtorgamientoInstance.properties = params
        cartaDeInstruccionDeOtorgamientoInstance.otorgamientoDePoder = otorgamientoDePoderInstance

        if (!cartaDeInstruccionDeOtorgamientoInstance.save(flush: true)) {
            render(view: "edit", model: [cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento'), cartaDeInstruccionDeOtorgamientoInstance.id])
        redirect(controller:"otorgamientoDePoder", action: "edit", id: otorgamientoDePoderInstance.id)
    }

    def delete(Long id) {
        def cartaDeInstruccionDeOtorgamientoInstance = CartaDeInstruccionDeOtorgamiento.get(id)
        if (!cartaDeInstruccionDeOtorgamientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento'), id])
            redirect(action: "list")
            return
        }

        try {
            cartaDeInstruccionDeOtorgamientoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento'), id])
            redirect(action: "show", id: id)
        }
    }
}