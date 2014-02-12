package com.app.sgpod

import java.text.SimpleDateFormat
import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol

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
        
        //se agrega el reponsable para envio de notificaciones        
        def usuarioResolvedorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
        usuarioResolvedorPoderes.each{
            params.responsable = Usuario.get(it.id as long)   
        } 
        
        if (params.registroDeLaSolicitud) {
            Date registroDeLaSolicitud = sdf.parse(params.registroDeLaSolicitud)
            params.registroDeLaSolicitud = registroDeLaSolicitud
        }
        if (params.fechaDeOtorgamiento) {
            Date fechaDeOtorgamiento = sdf.parse(params.fechaDeOtorgamiento)
            params.fechaDeOtorgamiento = fechaDeOtorgamiento
        }
        
        //Se cambian las comas por arrobas
        if(params.tags && !params.tags.endsWith(",")){
            params.tags = params.tags + "@"
        }
        params.tags = params.tags.replaceAll(",", "@")
        
        def otorgamientoDePoderInstance = new OtorgamientoDePoder(params)
        if (!otorgamientoDePoderInstance.save(flush: true)) {
            render(view: "create", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
            return
        }
        flash.message = message(code: 'default.created.message', args: [message(code: 'poder.label', default: 'Poder'), otorgamientoDePoderInstance.id])
        redirect(action: "edit", id: otorgamientoDePoderInstance.id)
    }

    def show(Long id) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        
        def otorgamientoDePoderInstance = OtorgamientoDePoder.read(id)        
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }
        if (otorgamientoDePoderInstance.tags){
            otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.replaceAll("@",",")
            if(otorgamientoDePoderInstance.tags && otorgamientoDePoderInstance.tags.endsWith(",")){
                otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.substring(0,otorgamientoDePoderInstance.tags.length()-1)
            }
        }
        //parametro para ocualtar botones
        def ocultarBoton = false
        if(otorgamientoDePoderInstance.asignar != springSecurityService.currentUser){
            ocultarBoton = true
        }
        //banderas para saber si ya fueron vistos los documentos por el usuario solicitante
        if(otorgamientoDePoderInstance.creadaPor == springSecurityService.currentUser && otorgamientoDePoderInstance.documentos){
            otorgamientoDePoderInstance.voBoCopiaElectronica = true
            otorgamientoDePoderInstance.save()
        }
        if(otorgamientoDePoderInstance.creadaPor == springSecurityService.currentUser && otorgamientoDePoderInstance.notas){
            otorgamientoDePoderInstance.voBoDocumentoFisico = true
            otorgamientoDePoderInstance.save()
        }
                              
        def cartaDeInstruccion = CartaDeInstruccionDeOtorgamiento.findByOtorgamientoDePoder(otorgamientoDePoderInstance)
        
        [otorgamientoDePoderInstance: otorgamientoDePoderInstance, cartaDeInstruccion : cartaDeInstruccion, ocultarBoton:ocultarBoton]                       
    }

    def edit(Long id) {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.read(id)
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }
        if(otorgamientoDePoderInstance.tags){
            otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.replaceAll("@",",")
            if(otorgamientoDePoderInstance.tags && otorgamientoDePoderInstance.tags.endsWith(",")){
                otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.substring(0,otorgamientoDePoderInstance.tags.length()-1)
            }
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
        //se reasigna al resolvedor cuando se envia la copia electronica
        if (params.fechaDeOtorgamiento) {
            Date fechaDeOtorgamiento = sdf.parse(params.fechaDeOtorgamiento)
            params.fechaDeOtorgamiento = fechaDeOtorgamiento
            def usuarioResolvedorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
            usuarioResolvedorPoderes.each{
                otorgamientoDePoderInstance.asignar = Usuario.get(it.id as long)   
            } 
            otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
            otorgamientoDePoderInstance.fechaDeEnvio = new Date()
        } else {
            params.fechaDeOtorgamiento = null
        }
        //end
        //validacion para la busqueda por tags
        if(params.tags && !params.tags.endsWith(",")){
            params.tags = params.tags + "@" 
        }
        if(params.tags){
            params.tags = params.tags.replaceAll(",", "@")
        }
        //end busqueda tags
        otorgamientoDePoderInstance.properties = params        
        if (!otorgamientoDePoderInstance.save(flush: true)) {
            render(view: "edit", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
            return
        }
        if(params.archivo){
            if (params.archivo.getSize()!=0) {            
                def documentoDePoderInstance = new DocumentoDePoder(params)
                documentoDePoderInstance.nombre = params.archivo.getOriginalFilename()
                otorgamientoDePoderInstance.addToDocumentos(documentoDePoderInstance)
                if (!otorgamientoDePoderInstance.save(flush: true)) {
                    render(view: "create", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
                    return
                }
            }
        }
        if(params.tags){
            otorgamientoDePoderInstance = OtorgamientoDePoder.read(id)
            otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.replaceAll("@",",")
            if(otorgamientoDePoderInstance.tags && otorgamientoDePoderInstance.tags.endsWith(",")){              
                otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.substring(0,otorgamientoDePoderInstance.tags.length()-1)
            }
        }
        //se cambia redireccionamiento cuando se envia la copia de escritura al solicitante
        if (params.fechaDeOtorgamiento != null) {
            flash.message = "Se ha enviado con éxito la copia de Escritura al Resolvedor"
            redirect(controller:"poderes", action: "index")            
        }else{            
            flash.message = message(code: 'default.updated.message', args: [message(code: 'poder.label', default: 'Poder'), otorgamientoDePoderInstance.id])
            redirect(action: "edit", id: otorgamientoDePoderInstance.id, params : [ anchor : params.anchor ])
        }
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
            otorgamientoDePoderInstance.addToApoderadosVigentes(apoderadoInstance)
            if (otorgamientoDePoderInstance.save(flush:true)) {                
                flash.message = "Se ha agregado apoderado a la solicitud."
            } else {
                flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
            }
        } else {
            apoderadoInstance = new Apoderado(nombre:params."apoderado")
            if (apoderadoInstance.save(flush:true)) {  
                otorgamientoDePoderInstance.addToApoderados(apoderadoInstance)
                otorgamientoDePoderInstance.addToApoderadosVigentes(apoderadoInstance)
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
        otorgamientoDePoderInstance.removeFromApoderadosVigentes(apoderadoInstance)
        flash.message = "El firmante ha sido eliminado."        
        redirect(action: "edit", id: otorgamientoDePoderInstance.id, params : [ anchor : params.anchor ])
    }
    def asignarA(){
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.idOtorgamientoDePoder as long)
        def usuarioGestorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_GESTOR")).collect {it.usuario}        
        usuarioGestorPoderes.each{
            otorgamientoDePoderInstance.asignar = Usuario.get(it.id as long)   
        }        
        otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
        otorgamientoDePoderInstance.fechaDeEnvio = new Date()
        otorgamientoDePoderInstance.save()
        flash.message = "Se ha enviado con éxito la Solicitud."        
        redirect(controller: "poderes", action: "index")
    }
    
    def entregarCopiaSolicitante(){
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.idOtorgamientoDePoder as long)        
        otorgamientoDePoderInstance.asignar = otorgamientoDePoderInstance.creadaPor
        otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
        //se calcula la fecha de vencimiento sumando el periodo de 730 dias que es el perido de 2 años
        otorgamientoDePoderInstance.fechaVencimiento = otorgamientoDePoderInstance.fechaDeOtorgamiento + 730        
        //end
        otorgamientoDePoderInstance.fechaDeEnvio = new Date()
        otorgamientoDePoderInstance.save()
        flash.message = "Se ha enviado con éxito la Copia Electrónica."        
        redirect(controller: "poderes", action: "index")
    }
    
    def turnarResolvedor(){
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.id as long)
        def usuarioResolvedorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
        usuarioResolvedorPoderes.each{
            otorgamientoDePoderInstance.asignar = Usuario.get(it.id as long)   
        }        
        otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
        otorgamientoDePoderInstance.fechaDeEnvio = new Date()
        otorgamientoDePoderInstance.save()
        flash.message = "Se ha turnado con éxito la Solicitud."        
        redirect(controller: "poderes", action: "index")
    }
}
