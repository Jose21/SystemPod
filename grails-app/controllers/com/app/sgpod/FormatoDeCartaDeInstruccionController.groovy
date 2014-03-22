package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException

class FormatoDeCartaDeInstruccionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    /**
    * Método apara enlistar los registros existentes en una domain class 
    */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [formatoDeCartaDeInstruccionInstanceList: FormatoDeCartaDeInstruccion.list(params), formatoDeCartaDeInstruccionInstanceTotal: FormatoDeCartaDeInstruccion.count()]
    }
    /**
    * Este método sirve para la creacion de un registro de tipo formato de carta de instrucción.
    */
    def create() {
        [formatoDeCartaDeInstruccionInstance: new FormatoDeCartaDeInstruccion(params)]
    }
    /**
    * Método para guardar los registros en el sistema.
    */
    def save() {
        def formatoDeCartaDeInstruccionInstance = new FormatoDeCartaDeInstruccion(params)
        if (!formatoDeCartaDeInstruccionInstance.save(flush: true)) {
            render(view: "create", model: [formatoDeCartaDeInstruccionInstance: formatoDeCartaDeInstruccionInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'formatoDeCartaDeInstruccion.label', default: 'FormatoDeCartaDeInstruccion'), formatoDeCartaDeInstruccionInstance.id])
        redirect(action: "show", id: formatoDeCartaDeInstruccionInstance.id)
    }
     /**
    * Método para visualizar el registro creado en el sistema.
    */
    def show(Long id) {
        def formatoDeCartaDeInstruccionInstance = FormatoDeCartaDeInstruccion.get(id)
        if (!formatoDeCartaDeInstruccionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'formatoDeCartaDeInstruccion.label', default: 'FormatoDeCartaDeInstruccion'), id])
            redirect(action: "list")
            return
        }

        [formatoDeCartaDeInstruccionInstance: formatoDeCartaDeInstruccionInstance]
    }
     /**
    * Método para editar un registro.
    */
    def edit(Long id) {
        def formatoDeCartaDeInstruccionInstance = FormatoDeCartaDeInstruccion.get(id)
        if (!formatoDeCartaDeInstruccionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'formatoDeCartaDeInstruccion.label', default: 'FormatoDeCartaDeInstruccion'), id])
            redirect(action: "list")
            return
        }

        [formatoDeCartaDeInstruccionInstance: formatoDeCartaDeInstruccionInstance]
    }
     /**
    * Método para actualizar los datos de un registro.
    */
    def update(Long id, Long version) {
        def formatoDeCartaDeInstruccionInstance = FormatoDeCartaDeInstruccion.get(id)
        if (!formatoDeCartaDeInstruccionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'formatoDeCartaDeInstruccion.label', default: 'FormatoDeCartaDeInstruccion'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (formatoDeCartaDeInstruccionInstance.version > version) {
                formatoDeCartaDeInstruccionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'formatoDeCartaDeInstruccion.label', default: 'FormatoDeCartaDeInstruccion')] as Object[],
                          "Another user has updated this FormatoDeCartaDeInstruccion while you were editing")
                render(view: "edit", model: [formatoDeCartaDeInstruccionInstance: formatoDeCartaDeInstruccionInstance])
                return
            }
        }

        formatoDeCartaDeInstruccionInstance.properties = params

        if (!formatoDeCartaDeInstruccionInstance.save(flush: true)) {
            render(view: "edit", model: [formatoDeCartaDeInstruccionInstance: formatoDeCartaDeInstruccionInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'formatoDeCartaDeInstruccion.label', default: 'FormatoDeCartaDeInstruccion'), formatoDeCartaDeInstruccionInstance.id])
        redirect(action: "show", id: formatoDeCartaDeInstruccionInstance.id)
    }
    /**
    * Método para eliminar el registro del sistema.
    */
    def delete(Long id) {
        def formatoDeCartaDeInstruccionInstance = FormatoDeCartaDeInstruccion.get(id)
        if (!formatoDeCartaDeInstruccionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'formatoDeCartaDeInstruccion.label', default: 'FormatoDeCartaDeInstruccion'), id])
            redirect(action: "list")
            return
        }

        try {
            formatoDeCartaDeInstruccionInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'formatoDeCartaDeInstruccion.label', default: 'FormatoDeCartaDeInstruccion'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'formatoDeCartaDeInstruccion.label', default: 'FormatoDeCartaDeInstruccion'), id])
            redirect(action: "show", id: id)
        }
    }
}
