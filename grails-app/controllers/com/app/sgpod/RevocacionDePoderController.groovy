package com.app.sgpod

import java.text.SimpleDateFormat
import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import grails.plugins.springsecurity.Secured
import com.app.security.Usuario
import com.app.sgtask.Documento

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
        def datosDelOtorgamiento = OtorgamientoDePoder.findByEscrituraPublica(params.escrituraPublica)        
        def revocacionDePoderInstance = new RevocacionDePoder(params)
        if(params.escrituraPublica){
            if(!datosDelOtorgamiento?.escrituraPublica){
                flash.warn = "No se ha encontrado una solicitud de Otorgamiento de Poder. >> Intente de nuevo o complemente los datos manualmente."
            }else{
                
                revocacionDePoderInstance.escrituraPublica = datosDelOtorgamiento?.escrituraPublica
                revocacionDePoderInstance.categoriaDeTipoDePoder = datosDelOtorgamiento?.categoriaDeTipoDePoder
                revocacionDePoderInstance.delegacion = datosDelOtorgamiento?.delegacion
                revocacionDePoderInstance.solicitadoPor = datosDelOtorgamiento?.solicitadoPor
                revocacionDePoderInstance.fechaDeRevocacion = datosDelOtorgamiento?.fechaVencimiento
                revocacionDePoderInstance.comentarios = datosDelOtorgamiento?.comentarios
                revocacionDePoderInstance.documentos = datosDelOtorgamiento?.documentos
                revocacionDePoderInstance.apoderados = datosDelOtorgamiento?.apoderados
                revocacionDePoderInstance.agregarApoderado = false
            }
        }
        [revocacionDePoderInstance: revocacionDePoderInstance, otorgamientoDePoderId : datosDelOtorgamiento?.id]        
    }

    def save() {        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");        
        if (params.fechaDeRevocacion) {
            Date fechaDeRevocacion = sdf.parse(params.fechaDeRevocacion)
            params.fechaDeRevocacion = fechaDeRevocacion
        } else {
            params.fechaDeRevocacion = null
        }
        //se agrega el que creó la revocacion en la bd
        params.creadaPor = springSecurityService.currentUser
        
        //Se cambian las comas por arrobas
        if(params.tags && !params.tags.endsWith(",")){
            params.tags = params.tags + "@"
        }
        params.tags = params.tags.replaceAll(",", "@")        
        def revocacionDePoderInstance = new RevocacionDePoder(params)        
        
        params.each(){
            if (it.key.startsWith('apoderado')){                
                def apoderadoId = it.key.replace("apoderado","")                 
                def apoderadoInstance = Apoderado.get(apoderadoId as long)
                revocacionDePoderInstance.addToApoderados(apoderadoInstance)
            }
        }
        
        params.each(){
            if (it.key.startsWith('documento')){                
                def documentoId = it.key.replace("documento","")                 
                def documentoInstance = DocumentoDePoder.get(documentoId as long)
                revocacionDePoderInstance.addToDocumentos(documentoInstance)
            }
        } 
        //se guardan los archivos adjuntos cuando se crea una solicitud manualmente
        if (params.archivo.getSize()!=0) {            
            def documentoInstance = new DocumentoDePoder(params)
            documentoInstance.nombre = params.archivo.getOriginalFilename()
            revocacionDePoderInstance.addToDocumentos(documentoInstance)
            
        }
                        
        if (!revocacionDePoderInstance.save(flush: true)) {
            render(view: "create", model: [revocacionDePoderInstance: revocacionDePoderInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), revocacionDePoderInstance.id])
        redirect(action: "edit", id: revocacionDePoderInstance.id)
    }

    def show(Long id) {
        def revocacionDePoderInstance = RevocacionDePoder.read(id)
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }
        if(revocacionDePoderInstance.tags){
            revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.replaceAll("@",",")
            if(revocacionDePoderInstance.tags && revocacionDePoderInstance.tags.endsWith(",")){
                revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.substring(0,revocacionDePoderInstance.tags.length()-1)
            }
        }
        //parametro para ocualtar botones
        def ocultarBoton = false
        if(revocacionDePoderInstance.asignar != springSecurityService.currentUser){
            ocultarBoton = true
        }
        def cartaDeInstruccion = CartaDeInstruccionDeRevocacion.findByRevocacionDePoder(revocacionDePoderInstance)
        
        [revocacionDePoderInstance: revocacionDePoderInstance, ocultarBoton : ocultarBoton, cartaDeInstruccion : cartaDeInstruccion ]
    }

    def edit(Long id) {
        def revocacionDePoderInstance = RevocacionDePoder.read(id)        
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }
        if(revocacionDePoderInstance.tags){
            revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.replaceAll("@",",")
            if(revocacionDePoderInstance.tags && revocacionDePoderInstance.tags.endsWith(",")){
                revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.substring(0,revocacionDePoderInstance.tags.length()-1)
            }
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
        
        if(revocacionDePoderInstance.tags){
            //validacion para la busqueda por tags
            if(params.tags && !params.tags.endsWith(",")){
                params.tags = params.tags + "@" 
            }
            params.tags = params.tags.replaceAll(",", "@")
            revocacionDePoderInstance.properties = params
        }
        if (!revocacionDePoderInstance.save(flush: true)) {
            render(view: "edit", model: [revocacionDePoderInstance: revocacionDePoderInstance])
            return
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
        if(revocacionDePoderInstance.tags){
            revocacionDePoderInstance = RevocacionDePoder.read(id)
            revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.replaceAll("@",",")
            if(revocacionDePoderInstance.tags && revocacionDePoderInstance.tags.endsWith(",")){              
                revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.substring(0,revocacionDePoderInstance.tags.length()-1)
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
    def existeCarta() {
        def revocacionDePoderInstance = RevocacionDePoder.get(params.id)       
        def cartaDeInstruccion = CartaDeInstruccionDeRevocacion.findByRevocacionDePoder(revocacionDePoderInstance)
        if(!cartaDeInstruccion) {
            redirect(controller: "cartaDeInstruccionDeRevocacion", action: "create", params:[id:revocacionDePoderInstance.id])
            return   
        } else {
            redirect(controller: "cartaDeInstruccionDeRevocacion", action: "show", params:[id:cartaDeInstruccion.id, revocacionId: revocacionDePoderInstance.id])
            return   
        }
    }
    
    def ajaxFinder() {
        def found = null
        if (params.term) {            
            def term = params.term
            found = OtorgamientoDePoder.withCriteria {
                ilike 'escrituraPublica', '%' + term + '%'
            }
        }
        render (found?.'escrituraPublica' as JSON)
    }
    
    def buscarEscrituraPublica(){        
        def datosDelOtorgamiento = OtorgamientoDePoder.findByEscrituraPublica(params.escrituraPublica)                
        def revocacionDePoderInstance = new RevocacionDePoder(params)
        revocacionDePoderInstance.escrituraPublica = datosDelOtorgamiento.escrituraPublica
        revocacionDePoderInstance.categoriaDeTipoDePoder = datosDelOtorgamiento.categoriaDeTipoDePoder
        revocacionDePoderInstance.delegacion = datosDelOtorgamiento.delegacion
        
        [revocacionDePoderInstance: revocacionDePoderInstance, otorgamientoDePoderId : datosDelOtorgamiento?.id]
    }
    
    def removeApoderado () {
        def revocacionDePoderInstance = RevocacionDePoder.get(params.revocacionDePoder.id as long)        
        def apoderadoInstance = Apoderado.get(params.apoderado.id as long)
        revocacionDePoderInstance.removeFromApoderados(apoderadoInstance)        
        flash.message = "El apoderado fue omitido"        
        redirect(action: "edit", id: revocacionDePoderInstance.id)
    }
    def addApoderado () {
        def revocacionDePoderInstance = RevocacionDePoder.get(params.revocacionDePoder.id as long)
        def apoderadoInstance = Apoderado.findByNombre(params."apoderado")
        if (apoderadoInstance) {
            revocacionDePoderInstance.addToApoderados(apoderadoInstance)
            if (revocacionDePoderInstance.save(flush:true)) {                
                flash.message = "Se ha agregado apoderado a la solicitud."
            } else {
                flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
            }
        } else {
            apoderadoInstance = new Apoderado(nombre:params."apoderado")
            if (apoderadoInstance.save(flush:true)) {  
                revocacionDePoderInstance.addToApoderados(apoderadoInstance)
                if (revocacionDePoderInstance.save(flush:true)) {                    
                    flash.message = "Se ha agregado apoderado a la solicitud."
                } else {
                    flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
                }                
            } else {
                flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
            }
        }
        redirect(action: "edit", id: revocacionDePoderInstance.id, params : [anchor : params.anchor])
    }
    def asignarA(){
        def revocacionDePoderInstance = RevocacionDePoder.get(params.idRevocacionDePoder as long)
        revocacionDePoderInstance.asignar = Usuario.get(1 as long)
        revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
        revocacionDePoderInstance.save()
        flash.message = "Se ha enviado con éxito la Solicitud."        
        redirect(controller: "poderes", action: "index")
    }
    def entregarCopiaSolicitante(){
        def revocacionDePoderInstance = RevocacionDePoder.get(params.idRevocacionDePoder as long)        
        revocacionDePoderInstance.asignar = revocacionDePoderInstance.creadaPor
        revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
        
        revocacionDePoderInstance.save()
        flash.message = "Se ha enviado con éxito la Copia Electrónica."        
        redirect(controller: "poderes", action: "index")
    }
}
