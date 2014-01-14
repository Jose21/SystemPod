package com.app.sgpod

import java.text.SimpleDateFormat
import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class OtorgamientoDePoderController {
    
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [otorgamientoDePoderInstanceList: OtorgamientoDePoder.list(params), otorgamientoDePoderInstanceTotal: OtorgamientoDePoder.count()]
    }

    def create() {
        
        params.registroDeLaSolicitud = new Date()
        
        [otorgamientoDePoderInstance: new OtorgamientoDePoder(params)]
    }

    def save() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        
        //se agrega el que creó el otorgamiento en la bd
        params.creadaPor = springSecurityService.currentUser
        
        if (params.registroDeLaSolicitud) {
            Date registroDeLaSolicitud = sdf.parse(params.registroDeLaSolicitud)
            params.registroDeLaSolicitud = registroDeLaSolicitud
        }
        if (params.fechaDeOtorgamiento) {
            Date fechaDeOtorgamiento = sdf.parse(params.fechaDeOtorgamiento)
            params.fechaDeOtorgamiento = fechaDeOtorgamiento
        }
        def otorgamientoDePoderInstance = new OtorgamientoDePoder(params)
        
        if(otorgamientoDePoderInstance.tags && !otorgamientoDePoderInstance.tags.endsWith(",")){
            otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags + "," 
        }
        if (!otorgamientoDePoderInstance.save(flush: true)) {
            render(view: "create", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
            return
        }
        
        flash.message = message(code: 'default.created.message', args: [message(code: 'poder.label', default: 'Poder'), otorgamientoDePoderInstance.id])
        redirect(action: "edit", id: otorgamientoDePoderInstance.id)
    }

    def show(Long id) {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(id)
        if (!otorgamientoDePoderInstance.asignar){
            flash.warn = "El expediente aún no esta Asignado."
        }else{
            flash.warn = null
        }
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }
        if(otorgamientoDePoderInstance.tags && otorgamientoDePoderInstance.tags.endsWith(",")){              
            otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.substring(0,otorgamientoDePoderInstance.tags.length()-1)
        }
        [otorgamientoDePoderInstance: otorgamientoDePoderInstance]
    }

    def edit(Long id) {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(id)
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }
        if(otorgamientoDePoderInstance.tags && otorgamientoDePoderInstance.tags.endsWith(",")){              
            otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.substring(0,otorgamientoDePoderInstance.tags.length()-1)
        }
        [otorgamientoDePoderInstance: otorgamientoDePoderInstance, anchor : params.anchor?:""]
    }

    def update(Long id, Long version) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(id)
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (otorgamientoDePoderInstance.version > version) {
                otorgamientoDePoderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'poder.label', default: 'Poder')] as Object[],
                          "Another user has updated this Poder while you were editing")
                render(view: "edit", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
                return
            }
        }

        if (params.registroDeLaSolicitud) {
            Date registroDeLaSolicitud = sdf.parse(params.registroDeLaSolicitud)
            params.registroDeLaSolicitud = registroDeLaSolicitud
        }
        if (params.fechaDeOtorgamiento) {
            Date fechaDeOtorgamiento = sdf.parse(params.fechaDeOtorgamiento)
            params.fechaDeOtorgamiento = fechaDeOtorgamiento
        } else {
            params.fechaDeOtorgamiento = null
        }
        
        otorgamientoDePoderInstance.properties = params
        
        //validacion para la busqueda por tags
        if(otorgamientoDePoderInstance.tags && !otorgamientoDePoderInstance.tags.endsWith(",")){
            otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags + "," 
        }
        //end busqueda tags

        if (!otorgamientoDePoderInstance.save(flush: true)) {
            render(view: "edit", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
            return
        }
        if (params.archivo.getSize()!=0) {            
            def documentoDePoderInstance = new DocumentoDePoder(params)
            documentoDePoderInstance.nombre = params.archivo.getOriginalFilename()
            otorgamientoDePoderInstance.addToDocumentos(documentoDePoderInstance)
            if (!otorgamientoDePoderInstance.save(flush: true)) {
                render(view: "create", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
                return
            }
        }
        
        if(otorgamientoDePoderInstance.tags && otorgamientoDePoderInstance.tags.endsWith(",")){              
            otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.substring(0,otorgamientoDePoderInstance.tags.length()-1)
        }
        flash.message = message(code: 'default.updated.message', args: [message(code: 'poder.label', default: 'Poder'), otorgamientoDePoderInstance.id])
        redirect(action: "edit", id: otorgamientoDePoderInstance.id, params : [ anchor : params.anchor ])
    }

    def delete(Long id) {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(id)
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }

        try {
            otorgamientoDePoderInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "show", id: id)
        }
    }
    def deleteArchivo(Long id) {
        def otorgamientoDePoderId = params.otorgamientoDePoderId
        def otorgamientoDePoder = OtorgamientoDePoder.get (otorgamientoDePoderId)
        def documentoDePoder = DocumentoDePoder.get(id)
        otorgamientoDePoder.removeFromDocumentos(documentoDePoder)
        documentoDePoder.delete()
        flash.message = "El archivo se ha eliminado satisfactoriamente."
        redirect(action: "edit", id: otorgamientoDePoderId, params : [ anchor : params.anchor ])
    }
    def existe() {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.id)        
        def cartaDeInstruccion = CartaDeInstruccionDeOtorgamiento.findByOtorgamientoDePoder(otorgamientoDePoderInstance)
        if(!cartaDeInstruccion) {
            redirect(controller: "cartaDeInstruccionDeOtorgamiento", action: "create", params:[id:otorgamientoDePoderInstance.id])
            return   
        } else {
            redirect(controller: "cartaDeInstruccionDeOtorgamiento", action: "edit", params:[id:cartaDeInstruccion.id, otorgamientoDePoderId: otorgamientoDePoderInstance.id])
            return   
        }
    }
    def addApoderado () {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.otorgamientoDePoder.id as long)
        def apoderadoInstance = Apoderado.findByNombre(params."apoderado")
        if (apoderadoInstance) {
            otorgamientoDePoderInstance.addToApoderados(apoderadoInstance)
            if (otorgamientoDePoderInstance.save(flush:true)) {                
                flash.message = "Se ha agregado apoderado a la solicitud."
            } else {
                flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
            }
        } else {
            apoderadoInstance = new Apoderado(nombre:params."apoderado")
            if (apoderadoInstance.save(flush:true)) {  
                otorgamientoDePoderInstance.addToApoderados(apoderadoInstance)
                if (otorgamientoDePoderInstance.save(flush:true)) {                    
                    flash.message = "Se ha agregado apoderado a la solicitud."
                } else {
                    flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
                }                
            } else {
                flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
            }
        }
        redirect(action: "edit", id: otorgamientoDePoderInstance.id, params : [anchor : params.anchor])
    }
    def removeApoderado () {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.otorgamientoDePoder.id as long)        
        def apoderadoInstance = Apoderado.get(params.apoderado.id as long)
        otorgamientoDePoderInstance.removeFromApoderados(apoderadoInstance)        
        flash.message = "El firmante ha sido eliminado."        
        redirect(action: "edit", id: otorgamientoDePoderInstance.id, params : [ anchor : params.anchor ])
    }        
}
