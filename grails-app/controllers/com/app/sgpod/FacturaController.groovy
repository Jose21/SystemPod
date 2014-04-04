package com.app.sgpod

import com.app.sgtask.Documento
import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import java.text.SimpleDateFormat
import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol

@Secured(['IS_AUTHENTICATED_FULLY'])
class FacturaController {
    
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    /**
     * Método apara enlistar los registros existentes en una domain class 
     */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [facturaInstanceList: Factura.list(params), facturaInstanceTotal: Factura.count()]
    }
    /**
     * Este método sirve para la creacion de un registro de tipo factura.
     */
    def create() {
        [facturaInstance: new Factura(params)]
    }
    /**
     * Método para guardar los registros en el sistema.
     */
    def save() {        
        def facturaInstance = new Factura(params)                        
        if(params.archivo){
            if (params.archivo?.getSize()!=0) {            
                def documentoInstance = new DocumentoDePoder(params)
                documentoInstance.nombre = params.archivo.getOriginalFilename()
                facturaInstance.addToDocumentos(documentoInstance)                            
            }
        }
        if(params.archivo2){
            if (params.archivo2?.getSize()!=0) {            
                def documentoInstance = new DocumentoDePoder(params)
                documentoInstance.nombre = params.archivo2.getOriginalFilename()
                facturaInstance.addToDocumentos(documentoInstance)                            
            }
        }
        if(params.archivo3){
            if (params.archivo3?.getSize()!=0) {            
                def documentoInstance = new DocumentoDePoder(params)
                documentoInstance.nombre = params.archivo3.getOriginalFilename()
                facturaInstance.addToDocumentos(documentoInstance)                            
            }
        }
        
        def usuarioFacturas = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
        usuarioFacturas.each{
            facturaInstance.asignadoA = Usuario.get(it.id as long)   
        }
        facturaInstance.asignadoPor = springSecurityService.currentUser
        facturaInstance.creadaPor = springSecurityService.currentUser
        facturaInstance.fechaDeEnvio = new Date()
        
        if (!facturaInstance.save(flush: true)) {
            render(view: "create", model: [facturaInstance: facturaInstance])
            return
        }

        flash.message = "Se ha enviado con éxito la Factura."        
        redirect(controller: "poderes", action: "index")
    }
    /**
     * Método para visualizar el registro creado en el sistema.
     */
    def show(Long id) {
        def facturaInstance = Factura.get(id)
        
        def otorgamientosList = OtorgamientoDePoder.findAllByFactura(facturaInstance)
        def revocacionesList = RevocacionDePoder.findAllByFactura(facturaInstance) 
        
        //parametro para ocualtar botones
        def ocultarBoton = false
        if(facturaInstance.asignadoA != springSecurityService.currentUser){
            ocultarBoton = true
        }
        
        if (!facturaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'factura.label', default: 'Factura'), id])
            redirect(action: "list")
            return
        }

        [
            facturaInstance: facturaInstance,
            otorgamientosList : otorgamientosList,
            revocacionesList : revocacionesList,
            ocultarBoton : ocultarBoton 
        ]
    }
    /**
     * Método para editar un registro.
     */
    def edit(Long id) {
        def facturaInstance = Factura.get(id)
        if (!facturaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'factura.label', default: 'Factura'), id])
            redirect(action: "list")
            return
        }

        [facturaInstance: facturaInstance]
    }
    /**
     * Método para actualizar los datos de un registro.
     */
    def update(Long id, Long version) {
        def facturaInstance = Factura.get(id)
        if (!facturaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'factura.label', default: 'Factura'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (facturaInstance.version > version) {
                facturaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'factura.label', default: 'Factura')] as Object[],
                          "Another user has updated this Factura while you were editing")
                render(view: "edit", model: [facturaInstance: facturaInstance])
                return
            }
        }

        facturaInstance.properties = params

        if (!facturaInstance.save(flush: true)) {
            render(view: "edit", model: [facturaInstance: facturaInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'factura.label', default: 'Factura'), facturaInstance.id])
        redirect(action: "show", id: facturaInstance.id)
    }
    /**
     * Método para eliminar el registro del sistema.
     */
    def delete(Long id) {
        def facturaInstance = Factura.get(id)
        if (!facturaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'factura.label', default: 'Factura'), id])
            redirect(action: "list")
            return
        }

        try {
            facturaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'factura.label', default: 'Factura'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'factura.label', default: 'Factura'), id])
            redirect(action: "show", id: id)
        }
    }
    /**
     * Método para mostrar las solicitudes que no estan asignadas.
     */
    def asignarSolicitud(Long id) {
        def facturaInstance = Factura.get(id)        
        
        def c = OtorgamientoDePoder.createCriteria()
        def otorgamientosList = c.list {
            eq ("facturado", false)
            isNotNull ("escrituraPublica")
        }        
        def d = RevocacionDePoder.createCriteria()
        def revocacionesList = d.list {
            eq ("facturado", false)
            isNotEmpty ("notas")
        }
        
        if (!facturaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'factura.label', default: 'Factura'), id])
            redirect(action: "list")
            return
        }

        [
            facturaInstance: facturaInstance,
            otorgamientosList : otorgamientosList,
            revocacionesList : revocacionesList
        ]
    }
    /**
     * Método para asignar las solicitudes y enviar la factura.
     */
    def asignarFactura(){          
        def facturaInstance = Factura.get(params.facturaInstance.id) 
        
        if(params.otorgamientoDePoderList){            
            def solicitudSelects = params.list('otorgamientoDePoderList')        
            def selectedSolicitudes = OtorgamientoDePoder.getAll(solicitudSelects)                                                          
                            
            selectedSolicitudes.each(){ it ->                                
                it.factura = facturaInstance
                it.facturado = true
                it.save()                
            }                        
        }
        if(params.revocacionDePoderList){            
            def solicitudSelects = params.list('revocacionDePoderList')        
            def selectedSolicitudes = RevocacionDePoder.getAll(solicitudSelects)                                                          
                            
            selectedSolicitudes.each(){ it ->                                
                it.factura = facturaInstance
                it.facturado = true
                it.save()                
            }                        
        }else if (!params.otorgamientoDePoderList && !params.revocacionDePoderList){                
            flash.error = "Debe Elegir al menos una Solicitud."
            redirect(action: "asignarSolicitud", params: [id : facturaInstance.id])
            return            
        }
        
        
        def usuarioFacturas = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_FACTURAS")).collect {it.usuario}        
        usuarioFacturas.each{
            facturaInstance.asignadoA = Usuario.get(it.id as long)   
            facturaInstance.save()
        }
            
        facturaInstance.asignadoPor = springSecurityService.currentUser
        facturaInstance.fechaDeEnvio = new Date()
        facturaInstance.save()
        
        redirect(controller: "poderes", action: "index")       
    }
    /**
     * Método para guardar la fecha de pago y enviar la factura.
     */
    def saveFecha(){
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");        
        def facturaInstance = Factura.get(params.factura.id) 
        Date fechaDePago = sdf.parse(params.fechaDePago) 
        params.fechaDePago = fechaDePago
        facturaInstance.fechaDePago = params.fechaDePago
        facturaInstance.asignadoPor = springSecurityService.currentUser
        def usuarioResolvedor = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
        usuarioResolvedor.each{
            facturaInstance.asignadoA = Usuario.get(it.id as long)               
        }        
        facturaInstance.fechaDeEnvio = new Date()
        if(params.numeroDeCesta){
            facturaInstance.numeroDeCesta = params.numeroDeCesta 
        }
        
        flash.info = "Se ha enviado con éxito la información."        
        
        if (!facturaInstance.save(flush: true)) {
            render(view: "create", model: [facturaInstance: facturaInstance])
            return
        }               
        redirect(controller:"poderes", action: "index")
    }
    /**
     * Método para guardar comentario de rechazo y enviar la factura.
     */
    def saveComentario(){                
        def facturaInstance = Factura.get(params.factura.id)         
        facturaInstance.comentarioDeRechazo = params.comentarioDeRechazo
        facturaInstance.asignadoPor = springSecurityService.currentUser
        facturaInstance.asignadoA = facturaInstance.creadaPor
        facturaInstance.fechaDeEnvio = new Date()                
        
        flash.info = "Se ha enviado con éxito la información."        
        
        if (!facturaInstance.save(flush: true)) {
            render(view: "create", model: [facturaInstance: facturaInstance])
            return
        }               
        redirect(controller:"poderes", action: "index")
    }
    def saveListaDocumentos(){                        
        def facturaInstance = Factura.get(params.factura.id)
        if(params.archivoCotizacion){
            facturaInstance.documentoCotizacion = true
        }else{
            facturaInstance.documentoCotizacion = false
        }
        if(params.archivoPdf){
            facturaInstance.documentoPdf = true
        }else{
            facturaInstance.documentoPdf = false
        }
        if(params.archivoXml){
            facturaInstance.documentoXml = true
        }else{
            facturaInstance.documentoXml = false
        }        
        facturaInstance.save()
        flash.info = "Datos guardados correctamente."
        redirect(action: "show", id: facturaInstance.id)
        
    }
}
