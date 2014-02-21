package com.app.sgtask

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import com.app.sgpod.RevocacionDePoder
import com.app.sgpod.OtorgamientoDePoder
import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol


@Secured(['IS_AUTHENTICATED_FULLY'])
class NotaController {

    def historialDeTareaService
    def springSecurityService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [notaInstanceList: Nota.list(params), notaInstanceTotal: Nota.count()]
    }

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

    def save() {
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
        }                
        //integracion con poderes //revocacion de poder
        //enviar copia electrónica
        if (session.revocacionDePoderId) {
            if(params.archivo.getSize()!=0){                
                def revocacionDePoderInstance = RevocacionDePoder.get(session.revocacionDePoderId)
                //se eliminan los apoderados de la solicitud en la variable apoderadosVigentes de OtorgamientoDePoder
                def otorgamientoDePoderInstance = OtorgamientoDePoder.findByEscrituraPublica(revocacionDePoderInstance.escrituraPublica)
                otorgamientoDePoderInstance.apoderadosVigentes = otorgamientoDePoderInstance.apoderadosVigentes - revocacionDePoderInstance.apoderadosEliminar
                otorgamientoDePoderInstance.save()
            
                def usuarioResolvedorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
                usuarioResolvedorPoderes.each{
                    revocacionDePoderInstance.asignar = Usuario.get(it.id as long)   
                }     
                revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
                revocacionDePoderInstance.fechaDeEnvio = new Date()
                revocacionDePoderInstance.addToNotas(notaInstance).save(flush:true)
            }else{
                flash.error = "Debe Adjuntar el Archivo Electrónico."
                redirect(action: "create", params: [revocacionDePoderId: session.revocacionDePoderId])
                return
            }            
        }
        //integracion con otorgamiento de poder
        //notificacion al enviar un documento físico
        if (session.otorgamientoDePoderId) {
            if(params.archivo.getSize()!=0){
                def otorgamientoDePoderInstance = OtorgamientoDePoder.get(session.otorgamientoDePoderId)                                                
                otorgamientoDePoderInstance.addToNotas(notaInstance).save(flush:true)                   
            }else{
                flash.error = "Debe Adjuntar el Archivo Electrónico."
                redirect(action: "create", params: [otorgamientoDePoderId: session.otorgamientoDePoderId])
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

    def show(Long id) {
        def notaInstance = Nota.get(id)
        if (!notaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'nota.label', default: 'Nota'), id])
            redirect(action: "list")
            return
        }

        [notaInstance: notaInstance]
    }

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
        println "f"+ params.archivo

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
