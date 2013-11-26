package com.app.sgpod

import java.text.SimpleDateFormat
import org.springframework.dao.DataIntegrityViolationException

class OtorgamientoDePoderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [otorgamientoDePoderInstanceList: OtorgamientoDePoder.list(params), otorgamientoDePoderInstanceTotal: OtorgamientoDePoder.count()]
    }

    def create() {
        [otorgamientoDePoderInstance: new OtorgamientoDePoder(params)]
    }

    def save() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
      
        if (params.registroDeLaSolicitud) {
            Date registroDeLaSolicitud = sdf.parse(params.registroDeLaSolicitud)
            params.registroDeLaSolicitud = registroDeLaSolicitud
        }
        if (params.fechaDeOtorgamiento) {
            Date fechaDeOtorgamiento = sdf.parse(params.fechaDeOtorgamiento)
            params.fechaDeOtorgamiento = fechaDeOtorgamiento
        }
        def otorgamientoDePoderInstance = new OtorgamientoDePoder(params)
        if (!otorgamientoDePoderInstance.save(flush: true)) {
            render(view: "create", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'poder.label', default: 'Poder'), otorgamientoDePoderInstance.id])
        redirect(action: "edit", id: otorgamientoDePoderInstance.id)
    }

    def show(Long id) {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(id)
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }

        [otorgamientoDePoderInstance: otorgamientoDePoderInstance]
    }

    def edit(Long id) {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(id)
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }
        log.info "Edit: anchorpara eliminar->" + params.anchor
        [otorgamientoDePoderInstance: otorgamientoDePoderInstance, anchor : params.anchor?:""]
    }

    def update(Long id, Long version) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(id)
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (otorgamientoDePoderInstance.version > version) {
                otorgamientoDePoderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'poder.label', default: 'Poder')] as Object[],
                          "Another user has updated this Poder while you were editing")
                render(view: "edit", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
                return
            }
        }

        if (params.registroDeLaSolicitud) {
            Date registroDeLaSolicitud = sdf.parse(params.registroDeLaSolicitud)
            params.registroDeLaSolicitud = registroDeLaSolicitud
        }
        if (params.fechaDeOtorgamiento) {
            Date fechaDeOtorgamiento = sdf.parse(params.fechaDeOtorgamiento)
            params.fechaDeOtorgamiento = fechaDeOtorgamiento
        } else {
            params.fechaDeOtorgamiento = null
        }
        
        otorgamientoDePoderInstance.properties = params

        if (!otorgamientoDePoderInstance.save(flush: true)) {
            render(view: "edit", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
            return
        }
         if (params.archivo.getSize()!=0) {            
            def documentoDePoderInstance = new DocumentoDePoder(params)
            documentoDePoderInstance.nombre = params.archivo.getOriginalFilename()
            otorgamientoDePoderInstance.addToDocumentos(documentoDePoderInstance)
            if (!otorgamientoDePoderInstance.save(flush: true)) {
                render(view: "create", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
                return
            }
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'poder.label', default: 'Poder'), otorgamientoDePoderInstance.id])
        redirect(action: "edit", id: otorgamientoDePoderInstance.id, params : [ anchor : params.anchor ])
    }

    def delete(Long id) {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(id)
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }

        try {
            otorgamientoDePoderInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "show", id: id)
        }
    }
    def deleteArchivo(Long id) {
        def otorgamientoDePoderId = params.otorgamientoDePoderId
        def otorgamientoDePoder = OtorgamientoDePoder.get (otorgamientoDePoderId)
        def documentoDePoder = DocumentoDePoder.get(id)
        otorgamientoDePoder.removeFromDocumentos(documentoDePoder)
        documentoDePoder.delete()
        flash.message = "El archivo se ha eliminado satisfactoriamente."
        redirect(action: "edit", id: otorgamientoDePoderId, params : [ anchor : params.anchor ])
    }
}
