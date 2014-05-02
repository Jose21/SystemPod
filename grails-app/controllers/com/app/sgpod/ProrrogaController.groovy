package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import java.text.SimpleDateFormat

@Secured(['IS_AUTHENTICATED_FULLY'])
class ProrrogaController {
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
        [prorrogaInstanceList: Prorroga.list(params), prorrogaInstanceTotal: Prorroga.count()]
    }
    /**
    * Este método sirve para la creacion de un registro de tipo prorroga.
    */
    def create() {        
        if(params.otorgamientoDePoderId){
            session.otorgamientoDePoderId = params.otorgamientoDePoderId as long  
        }else{
            session.otorgamientoDePoderId = null
        }
        if(params.revocacionDePoderId){
            session.revocacionDePoderId = params.revocacionDePoderId as long  
        }else{
            session.revocacionDePoderId = null
        }    
        [prorrogaInstance: new Prorroga(params)]
    }
    /**
    * Método para guardar los registros en el sistema.
    */
    def save() {  
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        params.creadoPor = springSecurityService.currentUser            
        params.fechaDeEnvio = new Date()
        
        if (params.fechaProrroga) {
            Date fechaProrroga = sdf.parse(params.fechaProrroga)
            params.fechaProrroga = fechaProrroga
        }
        
        def prorrogaInstance = new Prorroga(params)                 
        
        if (session.otorgamientoDePoderId) {                                                                                        
            def otorgamientoDePoderInstance = OtorgamientoDePoder.get(session.otorgamientoDePoderId)            
            otorgamientoDePoderInstance.addToProrrogas(prorrogaInstance).save()
            prorrogaInstance.asignadoA = otorgamientoDePoderInstance.creadaPor
            //se guardan datos en la bitacora
            bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se agregó una Prorroga")
        }
        if (session.revocacionDePoderId) {                                                                                       
            def revocacionDePoderInstance = RevocacionDePoder.get(session.revocacionDePoderId)            
            revocacionDePoderInstance.addToProrrogas(prorrogaInstance).save()
            prorrogaInstance.asignadoA = revocacionDePoderInstance.creadaPor
            //se guardan datos en la bitacora
            bitacoraService.agregarRevocacion(revocacionDePoderInstance, springSecurityService.currentUser, "Se agregó una Prorroga")
        }
        if (!prorrogaInstance.save(flush: true)) {
            render(view: "create", model: [prorrogaInstance: prorrogaInstance])
            return
        }

        flash.info = "Se ha enviado con éxito la Prorroga."        
        redirect(controller: "poderes", action: "index")
    }
    /**
    * Método para visualizar el registro creado en el sistema.
    */
    def show(Long id) {
        def prorrogaInstance = Prorroga.get(id)
        def otorgamientoDePoderInstance = null
        def otorgamientosList = OtorgamientoDePoder.list()               
        def criteria = OtorgamientoDePoder.createCriteria()
        def results = criteria.list {
            prorrogas {
                inList("id", prorrogaInstance.id)
            }
        }
        results.each{ it ->
            otorgamientoDePoderInstance = it
        } 
        
        def revocacionDePoderInstance = null
        def revocacionesList = RevocacionDePoder.list()               
        def criteria2 = RevocacionDePoder.createCriteria()
        def results2 = criteria2.list {
            prorrogas {
                inList("id", prorrogaInstance.id)
            }
        }
        results2.each{ it ->
            revocacionDePoderInstance = it
        }         
        
        if (!prorrogaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'prorroga.label', default: 'Prorroga'), id])
            redirect(action: "list")
            return
        }

        [prorrogaInstance: prorrogaInstance, otorgamientoDePoderInstance : otorgamientoDePoderInstance, revocacionDePoderInstance : revocacionDePoderInstance]
    }
    /**
    * Método para editar un registro.
    */
    def edit(Long id) {
        def prorrogaInstance = Prorroga.get(id)
        if (!prorrogaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'prorroga.label', default: 'Prorroga'), id])
            redirect(action: "list")
            return
        }

        [prorrogaInstance: prorrogaInstance]
    }
    /**
    * Método para actualizar los datos de un registro.
    */
    def update(Long id, Long version) {
        def prorrogaInstance = Prorroga.get(id)
        if (!prorrogaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'prorroga.label', default: 'Prorroga'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (prorrogaInstance.version > version) {
                prorrogaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'prorroga.label', default: 'Prorroga')] as Object[],
                          "Another user has updated this Prorroga while you were editing")
                render(view: "edit", model: [prorrogaInstance: prorrogaInstance])
                return
            }
        }

        prorrogaInstance.properties = params

        if (!prorrogaInstance.save(flush: true)) {
            render(view: "edit", model: [prorrogaInstance: prorrogaInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'prorroga.label', default: 'Prorroga'), prorrogaInstance.id])
        redirect(action: "show", id: prorrogaInstance.id)
    }
     /**
    * Método para eliminar el registro del sistema.
    */
    def delete(Long id) {
        def prorrogaInstance = Prorroga.get(id)
        if (!prorrogaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'prorroga.label', default: 'Prorroga'), id])
            redirect(action: "list")
            return
        }

        try {
            prorrogaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'prorroga.label', default: 'Prorroga'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'prorroga.label', default: 'Prorroga'), id])
            redirect(action: "show", id: id)
        }
    }
    def ocultar(Long id){         
        def prorrogaInstance = Prorroga.get(params.id as long)                
        prorrogaInstance.ocultado = true
        prorrogaInstance.save()        
        flash.message = "Se ha Ocultado la Prorroga."        
        redirect(controller: "poderes", action: "index")
        
        [ prorrogaInstance : prorrogaInstance ]
    }
}
