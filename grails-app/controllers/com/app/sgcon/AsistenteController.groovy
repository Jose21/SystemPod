package com.app.sgcon

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class AsistenteController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    /**
    * Método apara enlistar los registros existentes en una domain class 
    */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [asistenteInstanceList: Asistente.list(params), asistenteInstanceTotal: Asistente.count()]
    }
    /**
    * Este método sirve para la creacion de un registro de tipo asistente.
    */
    def create() {
        [asistenteInstance: new Asistente(params)]
    }
    /**
    * Método para guardar los registros en el sistema.
    */

    def save() {
        def asistenteInstance = new Asistente(params)
        if (!asistenteInstance.save(flush: true)) {
            render(view: "create", model: [asistenteInstance: asistenteInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'asistente.label', default: 'Asistente'), asistenteInstance.id])
        redirect(action: "show", id: asistenteInstance.id)
    }
    /**
    * Método para visualizar el registro creado en el sistema.
    */

    def show(Long id) {
        def asistenteInstance = Asistente.get(id)
        if (!asistenteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'asistente.label', default: 'Asistente'), id])
            redirect(action: "list")
            return
        }

        [asistenteInstance: asistenteInstance]
    }
    /**
    * Método para editar un registro.
    */

    def edit(Long id) {
        def asistenteInstance = Asistente.get(id)
        if (!asistenteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'asistente.label', default: 'Asistente'), id])
            redirect(action: "list")
            return
        }

        [asistenteInstance: asistenteInstance]
    }
    /**
    * Método para actualizar los datos de un registro.
    */

    def update(Long id, Long version) {
        def asistenteInstance = Asistente.get(id)
        if (!asistenteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'asistente.label', default: 'Asistente'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (asistenteInstance.version > version) {
                asistenteInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'asistente.label', default: 'Asistente')] as Object[],
                          "Another user has updated this Asistente while you were editing")
                render(view: "edit", model: [asistenteInstance: asistenteInstance])
                return
            }
        }

        asistenteInstance.properties = params

        if (!asistenteInstance.save(flush: true)) {
            render(view: "edit", model: [asistenteInstance: asistenteInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'asistente.label', default: 'Asistente'), asistenteInstance.id])
        redirect(controller:"convenio", action: "edit", id: params.convenio.id)
    }
    /**
    * Método para eliminar el registro del sistema.
    */

    def delete(Long id) {
        def asistenteInstance = Asistente.get(id)
        if (!asistenteInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'asistente.label', default: 'Asistente'), id])
            redirect(action: "list")
            return
        }

        try {
            asistenteInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'asistente.label', default: 'Asistente'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'asistente.label', default: 'Asistente'), id])
            redirect(action: "show", id: id)
        }
    }
}
