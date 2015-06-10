package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol
import com.app.ses.AmazonSES
import grails.plugins.springsecurity.Secured
import java.text.SimpleDateFormat

@Secured(['IS_AUTHENTICATED_FULLY'])
class CartaDeInstruccionDeRevocacionController {
    
    def springSecurityService
    def bitacoraService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    /**
     * Método apara enlistar los registros existentes en una domain class 
     */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cartaDeInstruccionDeRevocacionInstanceList: CartaDeInstruccionDeRevocacion.list(params), cartaDeInstruccionDeRevocacionInstanceTotal: CartaDeInstruccionDeRevocacion.count()]
    }
    /**
     * Este método sirve para la creacion de un registro de tipo carta de instrucción de revocacion.
     */
    def create() {        
        def revocacionDePoderId = params.id
        def revocacionDePoderInstance = RevocacionDePoder.get(params.id as long)        
        def formato = FormatoDeCartaDeInstruccion.get(2)
        def cartaDeInstruccionDeRevocacionInstance = new CartaDeInstruccionDeRevocacion(params)
        cartaDeInstruccionDeRevocacionInstance.registro = formato.registro
        cartaDeInstruccionDeRevocacionInstance.fecha = formato.fecha
        cartaDeInstruccionDeRevocacionInstance.contenido = formato.contenido
                                        
        if(cartaDeInstruccionDeRevocacionInstance.contenido){
            cartaDeInstruccionDeRevocacionInstance.contenido = cartaDeInstruccionDeRevocacionInstance.contenido.replaceAll("@escrituraPublica@","${revocacionDePoderInstance?.escrituraPublica}")
            cartaDeInstruccionDeRevocacionInstance.contenido = cartaDeInstruccionDeRevocacionInstance.contenido.replaceAll("@notario@","${revocacionDePoderInstance?.notarioCorrespondiente?.notaria_titular}")            
            cartaDeInstruccionDeRevocacionInstance.contenido = cartaDeInstruccionDeRevocacionInstance.contenido.replaceAll("@notarioNumero@","${revocacionDePoderInstance?.notarioCorrespondiente?.notaria_numero}")            
        }               
        def usuarios = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_NOTARIO")).collect {it.usuario}
        usuarios.each{            
            if(it.accountLocked == true){
                usuarios = usuarios - it
            }
        }
        
        def day = new SimpleDateFormat("dd").format(new Date())
        def month = new SimpleDateFormat("MMMM").format(new Date())
        def year = new SimpleDateFormat("yyyy").format(new Date())
        def yearMin = new SimpleDateFormat("yy").format(new Date())
        cartaDeInstruccionDeRevocacionInstance.fecha =formato.fecha +" "+ day + " de " + month + " del " + year   
        cartaDeInstruccionDeRevocacionInstance.registro = formato.registro + revocacionDePoderId + "-R/" + yearMin           
                                       
        [cartaDeInstruccionDeRevocacionInstance: cartaDeInstruccionDeRevocacionInstance, revocacionDePoderId : revocacionDePoderId, usuarios:usuarios]
    }
    /**
     * Método para guardar los registros en el sistema.
     */
    def save() {
        def cartaDeInstruccionDeRevocacionInstance = new CartaDeInstruccionDeRevocacion(params)
        def revocacionDePoderInstance = RevocacionDePoder.get(params.revocacionDePoderId as long)
        revocacionDePoderInstance.asignar = Usuario.get(params.asignar.id as long)
        revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
        revocacionDePoderInstance.fechaDeEnvio = new Date()
        revocacionDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarRevocacion(revocacionDePoderInstance, springSecurityService.currentUser, "Se creó Carta de Instrucción y se envió al Notario")
        cartaDeInstruccionDeRevocacionInstance.revocacionDePoder = revocacionDePoderInstance   
        //notificacion de asignacion al notario
        def fechaDeEnvio = new SimpleDateFormat("dd-MMM-yyyy").format(revocacionDePoderInstance.fechaDeEnvio)   
        AmazonSES enviarEmail = new AmazonSES()                    
        enviarEmail.sendMail(revocacionDePoderInstance.asignar.email, "C. " + revocacionDePoderInstance.asignar.firstName +" "+ revocacionDePoderInstance.asignar.lastName + " Titular de la notaria " + revocacionDePoderInstance.asignar.notaria_numero + " de " +revocacionDePoderInstance.asignar.notaria_entidad, "SGCon: Nueva Carta de Instrucción", "Por medio del presente se le notifica que se le ha asignado una nueva carta de instrucción para el expediente: "+ revocacionDePoderInstance.id +"-R.", revocacionDePoderInstance.id +"-R", "Solicitante: " + revocacionDePoderInstance.creadaPor.firstName +" "+ revocacionDePoderInstance.creadaPor.lastName, "Fecha de Envio: " + fechaDeEnvio)         
        if (!cartaDeInstruccionDeRevocacionInstance.save(flush: true)) {
            render(view: "create", model: [cartaDeInstruccionDeRevocacionInstance: cartaDeInstruccionDeRevocacionInstance])
            return
        }

        flash.info = "Se ha enviado la Carta de Instrucción al Notario Asignado."
        redirect(controller:"poderes", action: "index")
    }
    /**
     * Método para visualizar el registro creado en el sistema.
     */
    def show(Long id) {
        def cartaDeInstruccionDeRevocacionInstance = CartaDeInstruccionDeRevocacion.get(id)
        def revocacionDePoderInstance = cartaDeInstruccionDeRevocacionInstance.revocacionDePoder
        if (!cartaDeInstruccionDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        [cartaDeInstruccionDeRevocacionInstance: cartaDeInstruccionDeRevocacionInstance, revocacionDePoderInstance : revocacionDePoderInstance]
    }
    /**
     * Método para editar un registro.
     */
    def edit(Long id) {
        def cartaDeInstruccionDeRevocacionInstance = CartaDeInstruccionDeRevocacion.get(id)
        def usuarios = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_NOTARIO")).collect {it.usuario}                
        if (!cartaDeInstruccionDeRevocacionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion'), id])
            redirect(action: "list")
            return
        }

        [
            cartaDeInstruccionDeRevocacionInstance: cartaDeInstruccionDeRevocacionInstance,
            revocacionDePoderId : (params.revocacionId),
            usuarios : usuarios
        ]
    }
    /**
     * Método para actualizar los datos de un registro.
     */
    def update(Long id, Long version) {
        def cartaDeInstruccionDeRevocacionInstance = CartaDeInstruccionDeRevocacion.get(id)
        def revocacionDePoderInstance = RevocacionDePoder.get(params.revocacionDePoderId as long)
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

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'Carta De Instrucción De Revocación'), cartaDeInstruccionDeRevocacionInstance.id])
        redirect(controller:"revocacionDePoder", action: "show", id: revocacionDePoderInstance.id)
    }
    /**
     * Método para eliminar el registro del sistema.
     */
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
    /**
     * Método para la nevegación entre pantallas.
     */
    def regresar(Long id) {
        def cartaDeInstruccionDeRevocacionInstance = CartaDeInstruccionDeRevocacion.get(id)
        def revocacionDePoderInstance = cartaDeInstruccionDeRevocacionInstance.revocacionDePoder
        redirect(controller:"revocacionDePoder", action: "show", id: revocacionDePoderInstance.id)
    }
    /**
     * Método para imprimir una carta de instrucción de revocación de poder.
     */
    def imprimir(Long id){
        def cartaDeInstruccionDeRevocacionInstance = CartaDeInstruccionDeRevocacion.get(params.id as long)
        def revocacionDePoderInstance = cartaDeInstruccionDeRevocacionInstance.revocacionDePoder
        [ cartaDeInstruccionDeRevocacionInstance : cartaDeInstruccionDeRevocacionInstance, revocacionDePoderInstance : revocacionDePoderInstance ]
    }
}
