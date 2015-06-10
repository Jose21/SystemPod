package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import com.app.security.UsuarioRol
import com.app.security.Usuario
import com.app.security.Rol

@Secured(['IS_AUTHENTICATED_FULLY'])
class DocumentoDeProyectoController {
    
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [documentoDeProyectoInstanceList: DocumentoDeProyecto.list(params), documentoDeProyectoInstanceTotal: DocumentoDeProyecto.count()]
    }

    def create() {
        if (params.idOtorgamiento) {
            session.idOtorgamiento = params.idOtorgamiento as long
            def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.idOtorgamiento as long)                                           
        }else {
            session.idOtorgamiento = null
        }
        [documentoDeProyectoInstance: new DocumentoDeProyecto(params)]
    }

    def save() {        
        params.poder = Poder.get(session.idOtorgamiento)        
        def documentoDeProyectoInstance = new DocumentoDeProyecto(params)
        def file = request.getFile('documento')
        def filename = file.getOriginalFilename() 
        
        documentoDeProyectoInstance.fechaDeEnvio = new Date()
        documentoDeProyectoInstance.asignadoPor = springSecurityService.currentUser        
        def usuarioResolvedor = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
        usuarioResolvedor.each{
            documentoDeProyectoInstance.asignadoA = Usuario.get(it.id as long)   
        }           
        
        if (!documentoDeProyectoInstance.save(flush: true)) {
            render(view: "create", model: [documentoDeProyectoInstance: documentoDeProyectoInstance])
            return
        }
        def documentoInstance = new DocumentoDePoder(archivo:file,nombre:filename)
        documentoInstance.save()
        params.poder.documentoDeProyecto = documentoDeProyectoInstance
        params.poder.save()
        documentoDeProyectoInstance.addToDocumentos(documentoInstance)
        flash.info = "Se ha enviado el Proyecto al usuario Resolvedor."
        redirect(controller: "poderes", action: "index") 
    }

    def show(Long id) {
        def documentoDeProyectoInstance = DocumentoDeProyecto.get(id)                                
        def otorgamientoDePoderInstance = OtorgamientoDePoder.findAllByDocumentoDeProyecto(documentoDeProyectoInstance)
                                        
        if (!documentoDeProyectoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documentoDeProyecto.label', default: 'DocumentoDeProyecto'), id])
            redirect(action: "list")
            return
        }

        [documentoDeProyectoInstance: documentoDeProyectoInstance, otorgamientoDePoderInstance : otorgamientoDePoderInstance ]
    }

    def edit(Long id) {
        def documentoDeProyectoInstance = DocumentoDeProyecto.get(id)
        if (!documentoDeProyectoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documentoDeProyecto.label', default: 'DocumentoDeProyecto'), id])
            redirect(action: "list")
            return
        }

        [documentoDeProyectoInstance: documentoDeProyectoInstance]
    }

    def update(Long id, Long version) {
        def documentoDeProyectoInstance = DocumentoDeProyecto.get(id)
        if (!documentoDeProyectoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documentoDeProyecto.label', default: 'DocumentoDeProyecto'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (documentoDeProyectoInstance.version > version) {
                documentoDeProyectoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'documentoDeProyecto.label', default: 'DocumentoDeProyecto')] as Object[],
                          "Another user has updated this DocumentoDeProyecto while you were editing")
                render(view: "edit", model: [documentoDeProyectoInstance: documentoDeProyectoInstance])
                return
            }
        }

        documentoDeProyectoInstance.properties = params

        if (!documentoDeProyectoInstance.save(flush: true)) {
            render(view: "edit", model: [documentoDeProyectoInstance: documentoDeProyectoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'documentoDeProyecto.label', default: 'DocumentoDeProyecto'), documentoDeProyectoInstance.id])
        redirect(action: "show", id: documentoDeProyectoInstance.id)
    }

    def delete(Long id) {
        def documentoDeProyectoInstance = DocumentoDeProyecto.get(id)
        if (!documentoDeProyectoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documentoDeProyecto.label', default: 'DocumentoDeProyecto'), id])
            redirect(action: "list")
            return
        }

        try {
            documentoDeProyectoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'documentoDeProyecto.label', default: 'DocumentoDeProyecto'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'documentoDeProyecto.label', default: 'DocumentoDeProyecto'), id])
            redirect(action: "show", id: id)
        }
    }
    def enviarCancelacion(Long id){                 
        def documentoDeProyectoInstance = DocumentoDeProyecto.get(params.documentoDeProyecto.id as long)                
        documentoDeProyectoInstance.motivosDeRechazo = params.motivosDeRechazo
        documentoDeProyectoInstance.fechaDeEnvio = new Date()
        documentoDeProyectoInstance.asignadoA = documentoDeProyectoInstance.asignadoPor
        documentoDeProyectoInstance.asignadoPor = springSecurityService.currentUser         
        documentoDeProyectoInstance.save()
        
        flash.message = "Se han enviado los motivos de rechazo."        
        redirect(controller: "poderes", action: "index")                
    }
    
    def aceptarVoBo(Long id){        
        def documentoDeProyectoInstance = DocumentoDeProyecto.get(params.id as long) 
        def otorgamientoDePoderInstance = OtorgamientoDePoder.findAllByDocumentoDeProyecto(documentoDeProyectoInstance)
        
        documentoDeProyectoInstance.fechaDeEnvio = new Date()
        documentoDeProyectoInstance.asignadoA = documentoDeProyectoInstance.asignadoPor
        documentoDeProyectoInstance.asignadoPor = springSecurityService.currentUser         
        documentoDeProyectoInstance.voboCartaDeInstruccion = true
        documentoDeProyectoInstance.save()
        
        flash.message = "Se ha enviado la notificacion de VoBo."        
        redirect(controller: "poderes", action: "index")     
    }
}
