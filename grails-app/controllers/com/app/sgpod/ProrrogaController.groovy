package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class ProrrogaController {
    def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [prorrogaInstanceList: Prorroga.list(params), prorrogaInstanceTotal: Prorroga.count()]
    }

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

    def save() {  
        params.creadoPor = springSecurityService.currentUser            
        params.fechaDeEnvio = new Date()
        def prorrogaInstance = new Prorroga(params)                 
        
        if (session.otorgamientoDePoderId) {                                                                                        
            def otorgamientoDePoderInstance = OtorgamientoDePoder.get(session.otorgamientoDePoderId)            
            otorgamientoDePoderInstance.addToProrrogas(prorrogaInstance).save()
            prorrogaInstance.asignadoA = otorgamientoDePoderInstance.creadaPor
            //prorrogaInstance.save()
        }
        if (session.revocacionDePoderId) {                                                                                       
            def revocacionDePoderInstance = RevocacionDePoder.get(session.revocacionDePoderId)            
            revocacionDePoderInstance.addToProrrogas(prorrogaInstance).save()
            prorrogaInstance.asignadoA = revocacionDePoderInstance.creadaPor
            //prorrogaInstance.save()
        }
        if (!prorrogaInstance.save(flush: true)) {
            render(view: "create", model: [prorrogaInstance: prorrogaInstance])
            return
        }

        flash.info = "Se ha enviado con éxito la Prorroga."        
        redirect(controller: "poderes", action: "index")
    }

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

    def edit(Long id) {
        def prorrogaInstance = Prorroga.get(id)
        if (!prorrogaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'prorroga.label', default: 'Prorroga'), id])
            redirect(action: "list")
            return
        }

        [prorrogaInstance: prorrogaInstance]
    }

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
}
