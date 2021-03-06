package com.app.sgtask

import grails.plugins.springsecurity.Secured
import org.springframework.dao.DataIntegrityViolationException

@Secured(['IS_AUTHENTICATED_FULLY'])
class DocumentoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    /**
    * Método para descargar un archivo.
    */
    def downloadArchivo (Long id) {
        def documentoInstance = Documento.get(id)
        response.setHeader("Content-Disposition", "attachment;filename=\"" + documentoInstance.nombre + "\"");
        byte[] archivo = documentoInstance.archivo
        response.outputStream << archivo
    }
    /**
    * Método para eliminar un archivo.
    */
    def deleteArchivo (Long id) {
        def tareaId = session.tareaId
        def documento = Documento.get(id)
        documento.delete()
        flash.message = "El archivo se ha eliminado satisfactoriamente."
        redirect(controller:"tarea", action: "show", id: tareaId)
    }
    
    def index() {
        redirect(action: "list", params: params)
    }
    /**
    * Método apara enlistar los registros existentes en una domain class 
    */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [documentoInstanceList: Documento.list(params), documentoInstanceTotal: Documento.count()]
    }
    /**
    * Este método sirve para la creacion de un registro de tipo documento.
    */
    def create() {
        [documentoInstance: new Documento(params)]
    }
    /**
    * Método para guardar los registros en el sistema.
    */
    def save() {
        def documentoInstance = new Documento(params)        
        if (!documentoInstance.save(flush: true)) {
            render(view: "create", model: [documentoInstance: documentoInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'documento.label', default: 'Documento'), documentoInstance.id])
        redirect(action: "show", id: documentoInstance.id)
    }
    /**
    * Método para visualizar el registro creado en el sistema.
    */
    def show(Long id) {
        def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        [documentoInstance: documentoInstance]
    }
    /**
    * Método para editar un registro.
    */
    def edit(Long id) {
        def documentoInstance = Documento.get(id)
        if (!documentoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'documento.label', default: 'Documento'), id])
            redirect(action: "list")
            return
        }

        [documentoInstance: documentoInstance]
    }
    /**
    * Método para actualizar los datos de un registro.
    */
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
    /**
    * Método para eliminar el registro del sistema.
    */
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
