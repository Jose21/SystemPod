package com.app.sgpod


import com.app.security.Usuario
import org.springframework.dao.DataIntegrityViolationException
import com.app.security.Rol
import com.app.security.Usuario
import com.app.security.UsuarioRol
import grails.plugins.springsecurity.Secured
import java.text.SimpleDateFormat
import com.app.ses.AmazonSES

@Secured(['IS_AUTHENTICATED_FULLY'])
class CartaDeInstruccionDeOtorgamientoController {
    
    def springSecurityService
    def bitacoraService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    /**
     * Metodo apara enlistar los registros existentes en una domain class 
     */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cartaDeInstruccionDeOtorgamientoInstanceList: CartaDeInstruccionDeOtorgamiento.list(params), cartaDeInstruccionDeOtorgamientoInstanceTotal: CartaDeInstruccionDeOtorgamiento.count()]
    }
    /**
     * Este metodo sirve para la creacion de un registro de tipo carta de instrucción de otorgamiento.
     */
    def create() {        
        def otorgamientoDePoderId = params.id        
        def formato = FormatoDeCartaDeInstruccion.get(1)        
        def usuarios = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_NOTARIO")).collect {it.usuario}          
        usuarios.each{            
            if(it.accountLocked == true){
                usuarios = usuarios - it
            }
        }
        def cartaDeInstruccionDeOtorgamientoInstance = new CartaDeInstruccionDeOtorgamiento(params)
        cartaDeInstruccionDeOtorgamientoInstance.registro = formato.registro
        cartaDeInstruccionDeOtorgamientoInstance.fecha = formato.fecha
        cartaDeInstruccionDeOtorgamientoInstance.contenido = formato.contenido
        
        def day = new SimpleDateFormat("dd").format(new Date())
        def month = new SimpleDateFormat("MMMM").format(new Date())
        def year = new SimpleDateFormat("yyyy").format(new Date())
        def yearMin = new SimpleDateFormat("yy").format(new Date())
        cartaDeInstruccionDeOtorgamientoInstance.fecha = formato.fecha +" "+ day + " de " + month + " del " + year             
        cartaDeInstruccionDeOtorgamientoInstance.registro = formato.registro + otorgamientoDePoderId + "-O/" + yearMin           
        [cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance, otorgamientoDePoderId : otorgamientoDePoderId, usuarios:usuarios]
    }
    /**
     * Metodo para guardar los registros en el sistema.
     */
    def save() {           
        def cartaDeInstruccionDeOtorgamientoInstance = new CartaDeInstruccionDeOtorgamiento(params)
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.otorgamientoDePoderId as long)                
        def usuarioInstance = Usuario.get(params.asignar.id as long)
        otorgamientoDePoderInstance.asignar = usuarioInstance
        otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
        otorgamientoDePoderInstance.fechaDeEnvio = new Date()
        otorgamientoDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se creó Carta de Instrucción y se envió al Notario")
        cartaDeInstruccionDeOtorgamientoInstance.otorgamientoDePoder = otorgamientoDePoderInstance
        //notificacion de asignacion al notario
        def fechaDeEnvio = new SimpleDateFormat("dd-MMM-yyyy").format(otorgamientoDePoderInstance.fechaDeEnvio)   
        AmazonSES enviarEmail = new AmazonSES()                    
        enviarEmail.sendMail(otorgamientoDePoderInstance.asignar.email, "C. " + otorgamientoDePoderInstance.asignar.firstName +" "+ otorgamientoDePoderInstance.asignar.lastName + " Titular de la notaria " + otorgamientoDePoderInstance.asignar.notaria_numero + " de " +otorgamientoDePoderInstance.asignar.notaria_entidad , "SGCon: Nueva Carta de Instrucción", "Por medio del presente se le notifica que se le ha asignado una nueva carta de instrucción para el expediente: "+ otorgamientoDePoderInstance.id +"-O.", otorgamientoDePoderInstance.id +"-O", "Solicitante: " + otorgamientoDePoderInstance.creadaPor.firstName +" "+ otorgamientoDePoderInstance.creadaPor.lastName, "Fecha de Envio: " + fechaDeEnvio) 
                
        if (!cartaDeInstruccionDeOtorgamientoInstance.save(flush: true)) {
            render(view: "create", model: [cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance])
            return
        }
        
        flash.info = "Se ha enviado la Carta de Instrucción al Notario Asignado."
        redirect(controller:"poderes", action: "index")
    }
    /**
     * Metodo para visualizar el registro creado en el sistema.
     */

    def show(Long id) {
        def cartaDeInstruccionDeOtorgamientoInstance = CartaDeInstruccionDeOtorgamiento.get(id)
        def otorgamientoDePoderInstance = cartaDeInstruccionDeOtorgamientoInstance.otorgamientoDePoder
        if (!cartaDeInstruccionDeOtorgamientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento'), id])
            redirect(action: "list")
            return
        }

        [cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance, otorgamientoDePoderInstance : otorgamientoDePoderInstance]
    }
    /**
     * Metodo para editar un registro.
     */
    def edit(Long id) {
        def cartaDeInstruccionDeOtorgamientoInstance = CartaDeInstruccionDeOtorgamiento.get(id)
        def usuarios = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_NOTARIO")).collect {it.usuario}                
        if (!cartaDeInstruccionDeOtorgamientoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento'), id])
            redirect(action: "list")
            return
        }

        [
            cartaDeInstruccionDeOtorgamientoInstance: cartaDeInstruccionDeOtorgamientoInstance,
            otorgamientoDePoderId : (params.otorgamientoDePoderId),
            usuarios : usuarios
        ]
    }
    /**
     * Metodo para actualizar los datos de un registro
     */

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
    /**
     * Metodo para eliminar el registro del sistema.
     */
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
    /**
     * Metodo para la navegacion entre pantallas.
     */
    def regresar(Long id) {
        def cartaDeInstruccionDeOtorgamientoInstance = CartaDeInstruccionDeOtorgamiento.get(id)
        def otorgamientoDePoderInstance = cartaDeInstruccionDeOtorgamientoInstance.otorgamientoDePoder
        redirect(controller:"otorgamientoDePoder", action: "show", id: otorgamientoDePoderInstance.id)
    }
    /**
     * Metodo para imorimir la carta de instrucción.
     */
    def imprimir(Long id){
        def cartaDeInstruccionDeOtorgamientoInstance = CartaDeInstruccionDeOtorgamiento.get(params.id as long)
        def otorgamientoDePoderInstance = cartaDeInstruccionDeOtorgamientoInstance.otorgamientoDePoder
        [ cartaDeInstruccionDeOtorgamientoInstance : cartaDeInstruccionDeOtorgamientoInstance,  otorgamientoDePoderInstance : otorgamientoDePoderInstance]
    }
}
