package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class TipoDePoderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [tipoDePoderInstanceList: TipoDePoder.list(params), tipoDePoderInstanceTotal: TipoDePoder.count()]
    }

    def create() {
        [tipoDePoderInstance: new TipoDePoder(params)]
    }

    def save() {
        def tipoDePoderInstance = new TipoDePoder(params)
        if (!tipoDePoderInstance.save(flush: true)) {
            render(view: "create", model: [tipoDePoderInstance: tipoDePoderInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'tipoDePoder.label', default: 'TipoDePoder'), tipoDePoderInstance.id])
        redirect(action: "show", id: tipoDePoderInstance.id)
    }

    def show(Long id) {
        def tipoDePoderInstance = TipoDePoder.get(id)
        if (!tipoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoDePoder.label', default: 'TipoDePoder'), id])
            redirect(action: "list")
            return
        }

        [tipoDePoderInstance: tipoDePoderInstance]
    }

    def edit(Long id) {
        def tipoDePoderInstance = TipoDePoder.get(id)
        if (!tipoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoDePoder.label', default: 'TipoDePoder'), id])
            redirect(action: "list")
            return
        }

        [tipoDePoderInstance: tipoDePoderInstance]
    }

    def update(Long id, Long version) {
        def tipoDePoderInstance = TipoDePoder.get(id)
        if (!tipoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoDePoder.label', default: 'TipoDePoder'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (tipoDePoderInstance.version > version) {
                tipoDePoderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'tipoDePoder.label', default: 'TipoDePoder')] as Object[],
                          "Another user has updated this TipoDePoder while you were editing")
                render(view: "edit", model: [tipoDePoderInstance: tipoDePoderInstance])
                return
            }
        }

        tipoDePoderInstance.properties = params

        if (!tipoDePoderInstance.save(flush: true)) {
            render(view: "edit", model: [tipoDePoderInstance: tipoDePoderInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'tipoDePoder.label', default: 'TipoDePoder'), tipoDePoderInstance.id])
        redirect(action: "show", id: tipoDePoderInstance.id)
    }

    def delete(Long id) {
        def tipoDePoderInstance = TipoDePoder.get(id)
        if (!tipoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoDePoder.label', default: 'TipoDePoder'), id])
            redirect(action: "list")
            return
        }

        try {
            tipoDePoderInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'tipoDePoder.label', default: 'TipoDePoder'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tipoDePoder.label', default: 'TipoDePoder'), id])
            redirect(action: "show", id: id)
        }
    }
    
    def ajaxGetCategorias = {
        def tipoDePoder = TipoDePoder.get(params.tipoDePoder.id)
        //se obtienen 2 veces la listas para ordenar los objetos
        def lista1 = tipoDePoder.categorias.id.sort()
        def lista2 = CategoriaDeTipoDePoder.getAll(lista1)        
        render (template:'categoriaSelection', model: [categorias: lista2])
    } 
    /**
     * metodo para ocultar campo de poder solicitado, solo cuando el tipo de poder sea ESPECIAL
     */
    def ajaxGetIdCategoria = {
        
        def ocultarCampo = false
        def siEs = null
        def numero = CategoriaDeTipoDePoder.get(params.categoriaDeTipoDePoder.id)        
        if(numero.id == 11){
            ocultarCampo = true            
        }        
        render (template:'ocultar', model: [ocultarCampo: ocultarCampo,siEs : numero.detalles ])        
    }    
}
