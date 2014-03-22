package com.app.sgcon

import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class PersonaController {
    
    def historialDeConvenioService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    /**
    * Metodo apara enlistar los registros existentes en una domain class.
    */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [personaInstanceList: Persona.list(params), personaInstanceTotal: Persona.count()]
    }
    /**
    * Este metodo sirve para la creacion de un registro de Persona.
    */
    def create() {
        [personaInstance: new Persona(params)]
    }
    /**
    * Metodo para guardar los registros en el sistema
    */
    def save() {
        def personaInstance = new Persona(params)
        if (!personaInstance.save(flush: true)) {
            render(view: "create", model: [personaInstance: personaInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'persona.label', default: 'Persona'), personaInstance.id])
        redirect(action: "show", id: personaInstance.id)
    }
    /**
    * Metodo para visualizar el registro creado en el sistema.
    */
    def show(Long id) {
        def personaInstance = Persona.get(id)
        if (!personaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "list")
            return
        }

        [personaInstance: personaInstance]
    }
    /**
    * Metodo para editar un registro.
    */
    def edit(Long id) {
        def personaInstance = Persona.get(id)
        if (!personaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "list")
            return
        }

        [personaInstance: personaInstance]
    }
    /**
    * Metodo para actualizar los datos de un registro.
    */
    def update(Long id, Long version) {
        def personaInstance = Persona.get(id)
        if (!personaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (personaInstance.version > version) {
                personaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'persona.label', default: 'Persona')] as Object[],
                          "Another user has updated this Persona while you were editing")
                render(view: "edit", model: [personaInstance: personaInstance])
                return
            }
        }

        personaInstance.properties = params

        if (!personaInstance.save(flush: true)) {
            render(view: "edit", model: [personaInstance: personaInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'persona.label', default: 'Persona'), personaInstance.id])
        redirect(action: "show", id: personaInstance.id)
    }
    /**
    * Método para complementar los datos de un firmante o responsable de tipo persona.
    */
    def updateIt(Long id, Long version) {
        def personaInstance = Persona.get(id)
        def convenioInstance = Convenio.get(params.convenio.id as long)
        def personaOriginal = new Persona(personaInstance.properties)
        if (version != null) {
            if (personaInstance.version > version) {
                personaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'persona.label', default: 'Persona')] as Object[],
                          "Otro usuario actualizó los datos mientras los estabas editando.")
                redirect(controller:"convenio", action: "edit", id: personaInstance.id)
                return
            }
        }

        personaInstance.properties = params
        if (personaInstance.isDirty()) {  
            historialDeConvenioService.updateItConvenioToHistorial(personaInstance, personaOriginal, convenioInstance, "Se editó el convenio:")
        }

        if (!personaInstance.save(flush: true)) {
            flash.message = ""
            redirect(controller:"convenio", action: "edit", id: personaInstance.id)
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'persona.label', default: 'Persona'), personaInstance.id])
        redirect(controller:"convenio", action: "edit", id: params.convenio.id)
    }
    /**
    * Metodo para eliminar el registro del sistema.
    */
    def delete(Long id) {
        def personaInstance = Persona.get(id)
        if (!personaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "list")
            return
        }

        try {
            personaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'persona.label', default: 'Persona'), id])
            redirect(action: "show", id: id)
        }
    }
    /**
    * Método para busquedas dinamicas de personas ya registradas en el sistema y muestra las coincidencias.
    */
    def ajaxFinder() {
        def found = null
        if (params.term) {            
            def term = params.term
            found = Persona.withCriteria {
                ilike 'nombre', '%' + term + '%'
            }
        }
        render (found?.'nombre' as JSON)
    }
}
