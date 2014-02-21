package com.app.sgpod


import com.app.security.Usuario
import org.springframework.dao.DataIntegrityViolationException
import com.app.security.Rol
import com.app.security.Usuario
import com.app.security.UsuarioRol
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class CartaDeInstruccionDeOtorgamientoController {
    
    def springSecurityService

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
        def usuarios = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_NOTARIO")).collect {it.usuario}                
        def cartaDeInstruccionDeOtorgamientoInstance = new CartaDeInstruccionDeOtorgamiento(params)
        cartaDeInstruccionDeOtorgamientoInstance.registro = formato.registro
        cartaDeInstruccionDeOtorgamientoInstance.fecha = formato.fecha
        cartaDeInstruccionDeOtorgamientoInstance.contenido = formato.contenido
        
        [cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance, otorgamientoDePoderId : otorgamientoDePoderId, usuarios:usuarios]
    }

    def save() {           
        def cartaDeInstruccionDeOtorgamientoInstance = new CartaDeInstruccionDeOtorgamiento(params)
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.otorgamientoDePoderId as long)                
        def usuarioInstance = Usuario.get(params.asignar.id as long)
        otorgamientoDePoderInstance.asignar = usuarioInstance
            otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
            otorgamientoDePoderInstance.fechaDeEnvio = new Date()
            otorgamientoDePoderInstance.save()        
            cartaDeInstruccionDeOtorgamientoInstance.otorgamientoDePoder = otorgamientoDePoderInstance
                
            if (!cartaDeInstruccionDeOtorgamientoInstance.save(flush: true)) {
                render(view: "create", model: [cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance])
                return
            }
        
            flash.info = "Se ha enviado la Carta de Instrucción al Notario Asignado."
            redirect(controller:"poderes", action: "index")
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

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'Carta De Instrucción De Otorgamiento'), cartaDeInstruccionDeOtorgamientoInstance.id])
        redirect(controller:"otorgamientoDePoder", action: "show", id: otorgamientoDePoderInstance.id)
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
    def regresar(Long id) {
        def cartaDeInstruccionDeOtorgamientoInstance = CartaDeInstruccionDeOtorgamiento.get(id)
        def otorgamientoDePoderInstance = cartaDeInstruccionDeOtorgamientoInstance.otorgamientoDePoder
        redirect(controller:"otorgamientoDePoder", action: "show", id: otorgamientoDePoderInstance.id)
    }
    def imprimir(Long id){
        def cartaDeInstruccionDeOtorgamientoInstance = CartaDeInstruccionDeOtorgamiento.get(params.id as long)
        [ cartaDeInstruccionDeOtorgamientoInstance : cartaDeInstruccionDeOtorgamientoInstance ]
    }
}
