package com.app.sgpod

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class ApoderadoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    /**
    * Metodo que sirve para enlistar los registros existentes en una domain class 
    */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [apoderadoInstanceList: Apoderado.list(params), apoderadoInstanceTotal: Apoderado.count()]
    }
    /**
    * Este metodo sirve para la creacion de un registro de tipo apoderado.
    */
    def create() {
        [apoderadoInstance: new Apoderado(params)]
    }
    /**
    * Metodo para guardar los registros en el sistema.
    */
    def save() {
        def apoderadoInstance = new Apoderado(params)
        if (!apoderadoInstance.save(flush: true)) {
            render(view: "create", model: [apoderadoInstance: apoderadoInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'apoderado.label', default: 'Apoderado'), apoderadoInstance.id])
        redirect(action: "show", id: apoderadoInstance.id)
    }
    /**
    * Metodo para visualizar el registro creado en el sistema.
    */
    def show(Long id) {
        def apoderadoInstance = Apoderado.get(id)
        if (!apoderadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apoderado.label', default: 'Apoderado'), id])
            redirect(action: "list")
            return
        }

        [apoderadoInstance: apoderadoInstance]
    }
     /**
    * Metodo para editar un registro.
    */
    def edit(Long id) {
        def apoderadoInstance = Apoderado.get(id)
        if (!apoderadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apoderado.label', default: 'Apoderado'), id])
            redirect(action: "list")
            return
        }

        [apoderadoInstance: apoderadoInstance]
    }
    /**
    * Metodo para actualizar los datos de un registro
    */
    def update(Long id, Long version) {
        def apoderadoInstance = Apoderado.get(id)
        if (!apoderadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apoderado.label', default: 'Apoderado'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (apoderadoInstance.version > version) {
                apoderadoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'apoderado.label', default: 'Apoderado')] as Object[],
                          "Another user has updated this Apoderado while you were editing")
                render(view: "edit", model: [apoderadoInstance: apoderadoInstance])
                return
            }
        }

        apoderadoInstance.properties = params

        if (!apoderadoInstance.save(flush: true)) {
            render(view: "edit", model: [apoderadoInstance: apoderadoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'apoderado.label', default: 'Apoderado'), apoderadoInstance.id])
        redirect(action: "show", id: apoderadoInstance.id)
    }
    /**
    * Metodo para eliminar el registro del sistema.
    */
    def delete(Long id) {
        def apoderadoInstance = Apoderado.get(id)
        if (!apoderadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'apoderado.label', default: 'Apoderado'), id])
            redirect(action: "list")
            return
        }

        try {
            apoderadoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'apoderado.label', default: 'Apoderado'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'apoderado.label', default: 'Apoderado'), id])
            redirect(action: "show", id: id)
        }
    }
    /**
    * Metodo para actualizar los datos de un apoderado en las solicitudes de otorgamiento y revicación de poder.
    */
    def updateIt(Long id, Long version) { 
        println "params: " + params
        def apoderadoInstance = Apoderado.get(id)
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.otorgamientoDePoder.id as long)
        if (version != null) {
            if (apoderadoInstance.version > version) {
                apoderadoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'apoderado.label', default: 'Apoderado')] as Object[],
                          "Otro usuario actualizó los datos mientras los estabas editando.")
                redirect(controller:"otorgamientoDePoder", action: "edit", id: apoderadoInstance.id)
                return
            }
        }

        apoderadoInstance.properties = params        
        if (!apoderadoInstance.save(flush: true)) {
            flash.message = ""
            redirect(controller:"otorgamientoDePoder", action: "edit", id: apoderadoInstance.id)
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'apoderado.label', default: 'Apoderado'), apoderadoInstance.id])
        redirect(controller:"otorgamientoDePoder", action: "edit", id: params.otorgamientoDePoder.id)
    }
    /**
    * Metodo para actualizar una revocacion.
    */
    def updateItRevocacion(Long id, Long version) {        
        def apoderadoInstance = Apoderado.get(id)
        def revocacionDePoderInstance = RevocacionDePoder.get(params.revocacionDePoder.id as long)
        if (version != null) {
            if (apoderadoInstance.version > version) {
                apoderadoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'apoderado.label', default: 'Apoderado')] as Object[],
                          "Otro usuario actualizó los datos mientras los estabas editando.")
                redirect(controller:"revocacionDePoder", action: "edit", id: apoderadoInstance.id)
                return
            }
        }

        apoderadoInstance.properties = params        
        if (!apoderadoInstance.save(flush: true)) {
            flash.message = ""
            redirect(controller:"revocacionDePoder", action: "edit", id: apoderadoInstance.id)
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'apoderado.label', default: 'Apoderado'), apoderadoInstance.id])
        redirect(controller:"revocacionDePoder", action: "edit", id: params.revocacionDePoder.id)
    }
    /**
    * Metodo que realiza busquedas ajax para mostrar coincidencias al ingresar un nombre de apoderado.
    */
    def ajaxFinder() {
        def found = null
        if (params.term) {            
            def term = params.term
            found = Apoderado.withCriteria {
                ilike 'nombre', '%' + term + '%'
            }
        }
        render (found?.'nombre' as JSON)
    }
}
