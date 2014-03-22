package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class ConfigurarParametroController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    /**
    * Método apara enlistar los registros existentes en una domain class 
    */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [configurarParametroInstanceList: ConfigurarParametro.list(params), configurarParametroInstanceTotal: ConfigurarParametro.count()]
    }
    /**
    * Este método sirve para la creacion de un registro de tipo parametros.
    */
    def create() {
        [configurarParametroInstance: new ConfigurarParametro(params)]
    }
    /**
    * Método para guardar los registros en el sistema.
    */
    def save() {
        def configurarParametroInstance = new ConfigurarParametro(params)
        if (!configurarParametroInstance.save(flush: true)) {
            render(view: "create", model: [configurarParametroInstance: configurarParametroInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'configurarParametro.label', default: 'ConfigurarParametro'), configurarParametroInstance.id])
        redirect(action: "show", id: configurarParametroInstance.id)
    }
    /**
    * Método para visualizar el registro creado en el sistema.
    */
    def show(Long id) {
        def configurarParametroInstance = ConfigurarParametro.get(id)
        if (!configurarParametroInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'configurarParametro.label', default: 'ConfigurarParametro'), id])
            redirect(action: "list")
            return
        }

        [configurarParametroInstance: configurarParametroInstance]
    }
    /**
    * Método para editar un registro.
    */
    def edit(Long id) {
        def configurarParametroInstance = ConfigurarParametro.get(id)
        if (!configurarParametroInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'configurarParametro.label', default: 'ConfigurarParametro'), id])
            redirect(action: "list")
            return
        }

        [configurarParametroInstance: configurarParametroInstance]
    }
    /**
    * Método para actualizar los datos de un registro.
    */
    def update(Long id, Long version) {
        def configurarParametroInstance = ConfigurarParametro.get(id)
        if (!configurarParametroInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'configurarParametro.label', default: 'ConfigurarParametro'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (configurarParametroInstance.version > version) {
                configurarParametroInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'configurarParametro.label', default: 'ConfigurarParametro')] as Object[],
                          "Another user has updated this ConfigurarParametro while you were editing")
                render(view: "edit", model: [configurarParametroInstance: configurarParametroInstance])
                return
            }
        }
        
        configurarParametroInstance.properties = params                                      
                
        if (!configurarParametroInstance.save(flush: true)) {
            render(view: "edit", model: [configurarParametroInstance: configurarParametroInstance])
            return
        }

        flash.message = "Parametros Configurados Correctamente"
        redirect(action: "show", id: configurarParametroInstance.id)
        
    }
     /**
    * Método para eliminar el registro del sistema.
    */
    def delete(Long id) {
        def configurarParametroInstance = ConfigurarParametro.get(id)
        if (!configurarParametroInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'configurarParametro.label', default: 'ConfigurarParametro'), id])
            redirect(action: "list")
            return
        }

        try {
            configurarParametroInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'configurarParametro.label', default: 'ConfigurarParametro'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'configurarParametro.label', default: 'ConfigurarParametro'), id])
            redirect(action: "show", id: id)
        }
    }
}
