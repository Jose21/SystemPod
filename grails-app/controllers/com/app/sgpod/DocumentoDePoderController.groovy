package com.app.sgpod

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException

class DocumentoDePoderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    /**
    * Método para descargar un archivo.
    */
    def downloadArchivo (Long id) {
        def documentoDePoderInstance = DocumentoDePoder.get(id)
        response.setHeader("Content-Disposition", "attachment;filename=\"" + documentoDePoderInstance.nombre + "\"");
        byte[] archivo = documentoDePoderInstance.archivo
        response.outputStream << archivo
    }
    /**
    * Método para eliminar un archivo.
    */
    def deleteArchivo (Long id) {
        def otorgamientoDePoderId = session.otorgamientoDePoderId
        def documentoDePoder = DocumentoDePoder.get(id)
        documentoDePoder.delete()
        flash.message = "El archivo se ha eliminado satisfactoriamente."
        redirect(controller:"otorgamientoDePoder", action: "edit", id: otorgamientoDePoderId)
    }
    
    def index() {
        redirect(action: "list", params: params)
    }
    /**
    * Método apara enlistar los registros existentes en una domain class 
    */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [documentoDePoderInstanceList: DocumentoDePoder.list(params), documentoDePoderInstanceTotal: DocumentoDePoder.count()]
    }
     /**
    * Este método sirve para la creacion de un registro de tipo documento de poder.
    */
    def create() {
        [documentoDePoderInstance: new DocumentoDePoder(params)]
    }
    /**
    * Método para guardar los registros en el sistema.
    */
    def save() {
        def documentoDePoderInstance = new DocumentoDePoder(params)        
        if (!documentoDePoderInstance.save(flush: true)) {
            render(view: "create", model: [documentoDePoderInstance: documentoDePoderInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'documentoDePoder.label', default: 'Documento'), documentoDePoderInstance.id])
        redirect(action: "show", id: documentoDePoderInstance.id)
    }
    /**
    * Método para visualizar el registro creado en el sistema.
    */
    def show(Long id) {
        def documentoDePoderInstance = DocumentoDePoder.get(id)
        if (!documentoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documentoDePoder.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        [documentoDePoderInstance: documentoDePoderInstance]
    }
     /**
    * Método para editar un registro.
    */
    def edit(Long id) {
        def documentoDePoderInstance = DocumentoDePoder.get(id)
        if (!documentoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documentoDePoder.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        [documentoInstance: documentoInstance]
    }
    /**
    * Método para actualizar los datos de un registro.
    */
    def update(Long id, Long version) {
        def documentoDePoderInstance = DocumentoDePoder.get(id)
        if (!documentoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documentoDePoder.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (documentoDePoderInstance.version > version) {
                documentoDePoderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'documentoDePoder.label', default: 'Documento')] as Object[],
                          "Another user has updated this Documento while you were editing")
                render(view: "edit", model: [documentoDePoderInstance: documentoDePoderInstance])
                return
            }
        }

        documentoDePoderInstance.properties = params

        if (!documentoDePoderInstance.save(flush: true)) {
            render(view: "edit", model: [documentoDePoderInstance: documentoDePoderInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'documentoDePoder.label', default: 'Documento'), documentoDePoderInstance.id])
        redirect(action: "show", id: documentoDePoderInstance.id)
    }
    /**
    * Método para eliminar el registro del sistema.
    */
    def delete(Long id) {
        def documentoDePoderInstance = DocumentoDePoder.get(id)
        if (!documentoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documentoDePoder.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        try {
            documentoDePoderInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'documentoDePoder.label', default: 'Documento'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'documentoDePoder.label', default: 'Documento'), id])
            redirect(action: "show", id: id)
        }
    }
}
