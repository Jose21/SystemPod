package com.app.sgpod

import java.text.SimpleDateFormat
import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class RevocacionDePoderController {
    
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [revocacionDePoderInstanceList: RevocacionDePoder.list(params), revocacionDePoderInstanceTotal: RevocacionDePoder.count()]
    }

    def create() {
        [revocacionDePoderInstance: new RevocacionDePoder(params)]
    }

    def save() {
        //se agrega el que creó la revocacion en la bd
        params.creadaPor = springSecurityService.currentUser
        
        def revocacionDePoderInstance = new RevocacionDePoder(params)
        
        if(revocacionDePoderInstance.tags && !revocacionDePoderInstance.tags.endsWith(",")){
            revocacionDePoderInstance.tags = revocacionDePoderInstance.tags + "," 
        }
        
        if (!revocacionDePoderInstance.save(flush: true)) {
            render(view: "create", model: [revocacionDePoderInstance: revocacionDePoderInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), revocacionDePoderInstance.id])
        redirect(action: "edit", id: revocacionDePoderInstance.id)
    }

    def show(Long id) {
        def revocacionDePoderInstance = RevocacionDePoder.get(id)
        if (!revocacionDePoderInstance.asignar){
            flash.warn = "El expediente aún no esta Asignado."
        }else{
            flash.warn = null
        }
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }
        if(revocacionDePoderInstance.tags && revocacionDePoderInstance.tags.endsWith(",")){              
            revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.substring(0,revocacionDePoderInstance.tags.length()-1)
        }
        [revocacionDePoderInstance: revocacionDePoderInstance]
    }

    def edit(Long id) {
        def revocacionDePoderInstance = RevocacionDePoder.get(id)
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }
        if(revocacionDePoderInstance.tags && revocacionDePoderInstance.tags.endsWith(",")){              
            revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.substring(0,revocacionDePoderInstance.tags.length()-1)
        }
        [revocacionDePoderInstance: revocacionDePoderInstance, anchor : params.anchor?:""]
    }

    def update(Long id, Long version) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        def revocacionDePoderInstance = RevocacionDePoder.get(id)
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (revocacionDePoderInstance.version > version) {
                revocacionDePoderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder')] as Object[],
                          "Another user has updated this RevocacionDePoder while you were editing")
                render(view: "edit", model: [revocacionDePoderInstance: revocacionDePoderInstance])
                return
            }
        }

        if (params.fechaDeRevocacion) {
            Date fechaDeRevocacion = sdf.parse(params.fechaDeRevocacion)
            params.fechaDeRevocacion = fechaDeRevocacion
        } else {
            params.fechaDeRevocacion = null
        }
        revocacionDePoderInstance.properties = params
        
        if(revocacionDePoderInstance.tags && !revocacionDePoderInstance.tags.endsWith(",")){
            revocacionDePoderInstance.tags = revocacionDePoderInstance.tags + "," 
        }

        if (!revocacionDePoderInstance.save(flush: true)) {
            render(view: "edit", model: [revocacionDePoderInstance: revocacionDePoderInstance])
            return
        }
        
        if(revocacionDePoderInstance.tags && revocacionDePoderInstance.tags.endsWith(",")){              
            revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.substring(0,revocacionDePoderInstance.tags.length()-1)
        }
        
        if (params.archivo.getSize()!=0) {            
            def documentoDePoderInstance = new DocumentoDePoder(params)
            documentoDePoderInstance.nombre = params.archivo.getOriginalFilename()
            revocacionDePoderInstance.addToDocumentos(documentoDePoderInstance)
            if (!revocacionDePoderInstance.save(flush: true)) {
                render(view: "create", model: [revocacionDePoderInstance: revocacionDePoderInstance])
                return
            }
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), revocacionDePoderInstance.id])
        redirect(action: "edit", id: revocacionDePoderInstance.id, params : [ anchor : params.anchor])
    }

    def delete(Long id) {
        def revocacionDePoderInstance = RevocacionDePoder.get(id)
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }

        try {
            revocacionDePoderInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "show", id: id)
        }
    }
    def deleteArchivo(Long id) {
        def revocacionDePoderId = params.revocacionDePoderId
        def revocacionDePoder = RevocacionDePoder.get (revocacionDePoderId)
        def documentoDePoder = DocumentoDePoder.get(id)
        revocacionDePoder.removeFromDocumentos(documentoDePoder)
        documentoDePoder.delete()
        flash.message = "El archivo se ha eliminado satisfactoriamente."
        redirect(action: "edit", id: revocacionDePoderId, params : [ anchor : params.anchor ])
    }
    
    def existe() {
        def revocacionDePoderInstance = RevocacionDePoder.get(params.id)       
        def cartaDeInstruccion = CartaDeInstruccionDeRevocacion.findByRevocacionDePoder(revocacionDePoderInstance)
        if(!cartaDeInstruccion) {
            redirect(controller: "cartaDeInstruccionDeRevocacion", action: "create", params:[id:revocacionDePoderInstance.id])
            return   
        } else {
            redirect(controller: "cartaDeInstruccionDeRevocacion", action: "edit", params:[id:cartaDeInstruccion.id, revocacionId: revocacionDePoderInstance.id])
            return   
        }
    }
}
