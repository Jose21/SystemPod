package com.app.sgtask

import org.springframework.dao.DataIntegrityViolationException

class DocumentoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [documentoInstanceList: Documento.list(params), documentoInstanceTotal: Documento.count()]
    }

    def create() {
        [documentoInstance: new Documento(params)]
    }

    def save() {
        def documentoInstance = new Documento(params)        
        if (!documentoInstance.save(flush: true)) {
            render(view: "create", model: [documentoInstance: documentoInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])
        redirect(action: "show", id: documentoInstance.id)
    }

    def show(Long id) {
        def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        [documentoInstance: documentoInstance]
    }

    def edit(Long id) {
        def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        [documentoInstance: documentoInstance]
    }

    def update(Long id, Long version) {
        def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (documentoInstance.version > version) {
                documentoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'documento.label', default: 'Documento')] as Object[],
                          "Another user has updated this Documento while you were editing")
                render(view: "edit", model: [documentoInstance: documentoInstance])
                return
            }
        }

        documentoInstance.properties = params

        if (!documentoInstance.save(flush: true)) {
            render(view: "edit", model: [documentoInstance: documentoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])
        redirect(action: "show", id: documentoInstance.id)
    }

    def delete(Long id) {
        def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        try {
            documentoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "show", id: id)
        }
    }
}
