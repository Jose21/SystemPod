package com.app.sgtask

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import java.text.SimpleDateFormat
import com.app.sgpod.RevocacionDePoder
import com.app.sgpod.OtorgamientoDePoder
import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol
import com.app.ses.AmazonSES


@Secured(['IS_AUTHENTICATED_FULLY'])
class NotaController {

    def historialDeTareaService
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
        [notaInstanceList: Nota.list(params), notaInstanceTotal: Nota.count()]
    }
    /**
     * Este método sirve para la creacion de un registro de tipo nota.
     */
    def create() {   
        if(params.tareaId){
            session.tareaId = params.tareaId as long
        }else{
            session.tareaId = null
        }
        if(params.revocacionDePoderId){
            session.revocacionDePoderId = params.revocacionDePoderId as long  
        }else{
            session.revocacionDePoderId = null
        }
        if(params.otorgamientoDePoderId){
            session.otorgamientoDePoderId = params.otorgamientoDePoderId as long  
        }else{
            session.otorgamientoDePoderId = null
        }
        [notaInstance: new Nota(params)]
    }
    /**
     * Método para guardar los registros en el sistema.
     */
    def save() {   
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        params.agregadaPor = springSecurityService.currentUser
        def notaInstance = new Nota(params)
        if(session.tareaId){
            def tareaId = session.tareaId                   
            notaInstance.tarea = Tarea.get(params.tarea as long)
            if (!notaInstance.validate()) {
                notaInstance.errors.each {}
            }
            if (!notaInstance.save(flush: true)) {                
                render(view: "create", model: [notaInstance: notaInstance])
                return                                              
            }
            def usuariosDeTarea =  notaInstance.tarea.usuariosDeTarea        
            usuariosDeTarea.each { it ->
                //notificacionesService.tareaCerrada(tareaInstance, it.usuario)
                String stringId =  notaInstance.tarea.id
                AmazonSES enviarEmail = new AmazonSES()
                enviarEmail.sendMail(it.usuario.email, it.usuario.firstName +" "+ it.usuario.lastName, "SGCon: El turno ${ notaInstance.tarea.id} ha sido modificado.", "Se ha agregado una nueva nota al Turno.", stringId, "Nota creada por: " + notaInstance.tarea.creadaPor.firstName +" "+  notaInstance.tarea.creadaPor.lastName, "Titulo de la nota: " + notaInstance?.titulo)                
            }
        }                
        //integracion con poderes //revocacion de poder
        //enviar copia electrónica
        if (session.revocacionDePoderId) {
            if(params.archivo.getSize()!=0){                
                def revocacionDePoderInstance = RevocacionDePoder.get(session.revocacionDePoderId)
                //se eliminan los apoderados de la solicitud en la variable apoderadosVigentes de OtorgamientoDePoder
                def otorgamientoDePoderInstance = OtorgamientoDePoder.findByEscrituraPublica(revocacionDePoderInstance.escrituraPublica)                
                if(otorgamientoDePoderInstance){
                    otorgamientoDePoderInstance.apoderadosVigentes = otorgamientoDePoderInstance.apoderadosVigentes - revocacionDePoderInstance.apoderadosEliminar
                    otorgamientoDePoderInstance.solicitudEnProceso = false
                    otorgamientoDePoderInstance.save()
                    //se cambia el status de los apoderados para c/u de los apoderados
                    revocacionDePoderInstance.apoderadosEliminar.each{apoderado ->
                        apoderado.statusDePoder = 'Revocado'
                        apoderado.save()
                    }
                    //se guardan datos en la bitacora
                    bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se realizó una Revocacion de Poder")
                }
            
                def usuarioResolvedorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
                usuarioResolvedorPoderes.each{
                    revocacionDePoderInstance.asignar = Usuario.get(it.id as long)   
                }  
                Date fechaDeRevocacion = sdf.parse(params.fechaDeRevocacion)
                params.fechaDeRevocacion = fechaDeRevocacion
                revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
                revocacionDePoderInstance.fechaDeEnvio = new Date()
                revocacionDePoderInstance.escrituraPublicaRevocacion = params.escrituraPublicaRevocacion
                revocacionDePoderInstance.fechaDeRevocacion = params.fechaDeRevocacion
                revocacionDePoderInstance.notarioCorrespondiente = springSecurityService.currentUser
                revocacionDePoderInstance.addToNotas(notaInstance).save(flush:true)
                //se guardan datos en la bitacora
                bitacoraService.agregarRevocacion(revocacionDePoderInstance, springSecurityService.currentUser, "Se envió la copia Electrónica con el número de Escritura Pública")
                
            }else{
                flash.error = "Debe Adjuntar el Archivo Electrónico."
                redirect(action: "create", params: [revocacionDePoderId: session.revocacionDePoderId])
                return
            }            
        }
        
        if (params.archivo.getSize()!=0) {            
            def documentoInstance = new Documento(params)
            documentoInstance.nombre = params.archivo.getOriginalFilename()
            notaInstance.addToDocumentos(documentoInstance)
            if (!notaInstance.save(flush: true)) {
                render(view: "create", model: [notaInstance: notaInstance])
                return
            }
        }
        if(session.otorgamientoDePoderId){           
            def otorgamientoDePoderInstance = OtorgamientoDePoder.get(session.otorgamientoDePoderId as long)
            otorgamientoDePoderInstance.addToNotas(notaInstance).save(flush:true)
            //se guardan datos en la bitacora
            bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se notificó el envio de Documento Físico")
            flash.info = "Se ha enviado la Notificación al Solicitante."
            redirect(controller: "poderes", action: "index") 
        }else if(session.revocacionDePoderId){
            flash.info = "Se ha enviado el Testimonio de Escritura Pública al Usuario Resolvedor."
            redirect(controller: "poderes", action: "index") 
        }else{
            historialDeTareaService.agregar(notaInstance.tarea, springSecurityService.currentUser, "agregó una nota")
            flash.message = message(code: 'default.created.message', args: [message(code: 'nota.label', default: 'Nota'), notaInstance.id])
            redirect(controller:"tarea", action: "show", id: session.tareaId)
        }              
    }
    /**
     * Método para visualizar el registro creado en el sistema.
     */
    def show(Long id) {
        def notaInstance = Nota.get(id)
        if (!notaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(action: "list")
            return
        }

        [notaInstance: notaInstance]
    }
    /**
     * Método para editar un registro.
     */
    def edit(Long id) {
        def notaInstance = Nota.get(id)
        session.tareaId = params.tareaId
        if (!notaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(action: "list")
            return
        }
        [notaInstance: notaInstance]
    }
    /**
     * Método para actualizar los datos de un registro.
     */
    def update(Long id, Long version) {
        def notaInstance = Nota.get(id)
        def tareaId = session.tareaId
        if (!notaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(controller:"tarea",action: "list")
            return
        }

        if (version != null) {
            if (notaInstance.version > version) {
                notaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'nota.label', default: 'Nota')] as Object[],
                          "Another user has updated this Nota while you were editing")
                render(view: "edit", model: [notaInstance: notaInstance])
                return
            }
        }

        notaInstance.properties = params        

        if (!notaInstance.validate()) {
            notaInstance.errors.each {}
        }
        if (!notaInstance.save(flush: true)) {
            render(view: "edit", model: [notaInstance: notaInstance])
            return
        }        
        if (params.archivo.getSize()!=0) {            
            def documentoInstance = new Documento(params)
            documentoInstance.nombre = params.archivo.getOriginalFilename()
            notaInstance.addToDocumentos(documentoInstance)
            if (!notaInstance.save(flush: true)) {
                render(view: "create", model: [notaInstance: notaInstance])
                return
            }
        }

        historialDeTareaService.agregar(Tarea.get(tareaId as long), springSecurityService.currentUser, "modificó una nota")
        flash.message = message(code: 'default.updated.message', args: [message(code: 'nota.label', default: 'Nota'), notaInstance.id])
        redirect(controller:"tarea", action: "show", id: tareaId)
    }
    /**
     * Método para eliminar el registro del sistema.
     */
    def delete(Long id) {
        def notaInstance = Nota.get(id)
        if (!notaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(action: "list")
            return
        }

        try {
            notaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(action: "show", id: id)
        }
    }
}
