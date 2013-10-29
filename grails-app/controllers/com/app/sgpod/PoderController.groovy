package com.app.sgpod

import java.text.SimpleDateFormat
import org.springframework.dao.DataIntegrityViolationException

class PoderController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [poderInstanceList: Poder.list(params), poderInstanceTotal: Poder.count()]
    }

    def create() {
        [poderInstance: new Poder(params)]
    }

    def save() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
      
        if (params.registroDeLaSolicitud) {
            Date registroDeLaSolicitud = sdf.parse(params.registroDeLaSolicitud)
            params.registroDeLaSolicitud = registroDeLaSolicitud
        }
        if (params.fechaDeOtorgamientoDePoder) {
            Date fechaDeOtorgamientoDePoder = sdf.parse(params.fechaDeOtorgamientoDePoder)
            params.fechaDeOtorgamientoDePoder = fechaDeOtorgamientoDePoder
        }
        def poderInstance = new Poder(params)
        if (!poderInstance.save(flush: true)) {
            render(view: "create", model: [poderInstance: poderInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'poder.label', default: 'Poder'), poderInstance.id])
        redirect(action: "edit", id: poderInstance.id)
    }

    def show(Long id) {
        def poderInstance = Poder.get(id)
        if (!poderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }

        [poderInstance: poderInstance]
    }

    def edit(Long id) {
        def poderInstance = Poder.get(id)
        if (!poderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }

        [poderInstance: poderInstance]
    }

    def update(Long id, Long version) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        def poderInstance = Poder.get(id)
        if (!poderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (poderInstance.version > version) {
                poderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'poder.label', default: 'Poder')] as Object[],
                          "Another user has updated this Poder while you were editing")
                render(view: "edit", model: [poderInstance: poderInstance])
                return
            }
        }

        if (params.registroDeLaSolicitud) {
            Date registroDeLaSolicitud = sdf.parse(params.registroDeLaSolicitud)
            params.registroDeLaSolicitud = registroDeLaSolicitud
        }
        if (params.fechaDeOtorgamientoDePoder) {
            Date fechaDeOtorgamientoDePoder = sdf.parse(params.fechaDeOtorgamientoDePoder)
            params.fechaDeOtorgamientoDePoder = fechaDeOtorgamientoDePoder
        } else {
            params.fechaDeOtorgamientoDePoder = null
        }
        
        poderInstance.properties = params

        if (!poderInstance.save(flush: true)) {
            render(view: "edit", model: [poderInstance: poderInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'poder.label', default: 'Poder'), poderInstance.id])
        redirect(action: "edit", id: poderInstance.id)
    }

    def delete(Long id) {
        def poderInstance = Poder.get(id)
        if (!poderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }

        try {
            poderInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "show", id: id)
        }
    }
}
