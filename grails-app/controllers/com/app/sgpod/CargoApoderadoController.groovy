package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException

class CargoApoderadoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cargoApoderadoInstanceList: CargoApoderado.list(params), cargoApoderadoInstanceTotal: CargoApoderado.count()]
    }

    def create() {
        
        [cargoApoderadoInstance: new CargoApoderado(params)]
    }

    def save() {                
        def cargoApoderadoInstance = new CargoApoderado(params)
                
        if(params.categoriaList){
            def categoriasSelects = params.list('categoriaList')        
            def selectedCategorias = CategoriaDeTipoDePoder.getAll(categoriasSelects)                               
            selectedCategorias.each(){ it ->                                                
                cargoApoderadoInstance.addToCategoriasDeTipoDePoder(it)           
            }            
        }else{                
            flash.message = "Debe Elegir al menos un Apoderado."
            render(view: "create", model: [cargoApoderadoInstance: cargoApoderadoInstance])
            return            
        }
        
        if (!cargoApoderadoInstance.save(flush: true)) {
            render(view: "create", model: [cargoApoderadoInstance: cargoApoderadoInstance])
            return
        }
        
        flash.message = message(code: 'default.created.message', args: [message(code: 'cargoApoderado.label', default: 'CargoApoderado'), cargoApoderadoInstance.id])
        redirect(action: "show", id: cargoApoderadoInstance.id)
    }

    def show(Long id) {
        def cargoApoderadoInstance = CargoApoderado.get(id)
        if (!cargoApoderadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cargoApoderado.label', default: 'CargoApoderado'), id])
            redirect(action: "list")
            return
        }

        [cargoApoderadoInstance: cargoApoderadoInstance]
    }

    def edit(Long id) {
        def cargoApoderadoInstance = CargoApoderado.get(id)
        if (!cargoApoderadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cargoApoderado.label', default: 'CargoApoderado'), id])
            redirect(action: "list")
            return
        }
        
        if(params.categoriaList){
            def categoriasSelects = params.list('categoriaList')        
            def selectedCategorias = CategoriaDeTipoDePoder.getAll(categoriasSelects)                               
            selectedCategorias.each(){ it ->                                                
                cargoApoderadoInstance.addToCategoriasDeTipoDePoder(it)           
            }            
        }
        
        def categoriasTotales = CategoriaDeTipoDePoder.list()
        def categoriasActuales = cargoApoderadoInstance.categoriasDeTipoDePoder
        def categoriasRestantes = categoriasTotales - categoriasActuales

        [cargoApoderadoInstance: cargoApoderadoInstance, categoriasRestantes : categoriasRestantes]
    }

    def update(Long id, Long version) {
        def cargoApoderadoInstance = CargoApoderado.get(id)
        if (!cargoApoderadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cargoApoderado.label', default: 'CargoApoderado'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (cargoApoderadoInstance.version > version) {
                cargoApoderadoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'cargoApoderado.label', default: 'CargoApoderado')] as Object[],
                          "Another user has updated this CargoApoderado while you were editing")
                render(view: "edit", model: [cargoApoderadoInstance: cargoApoderadoInstance])
                return
            }
        }

        cargoApoderadoInstance.properties = params

        if (!cargoApoderadoInstance.save(flush: true)) {
            render(view: "edit", model: [cargoApoderadoInstance: cargoApoderadoInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cargoApoderado.label', default: 'CargoApoderado'), cargoApoderadoInstance.id])
        redirect(action: "show", id: cargoApoderadoInstance.id)
    }

    def delete(Long id) {
        def cargoApoderadoInstance = CargoApoderado.get(id)
        if (!cargoApoderadoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cargoApoderado.label', default: 'CargoApoderado'), id])
            redirect(action: "list")
            return
        }

        try {
            cargoApoderadoInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cargoApoderado.label', default: 'CargoApoderado'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cargoApoderado.label', default: 'CargoApoderado'), id])
            redirect(action: "show", id: id)
        }
    }
    
    def addCategoria(Long id){
        def cargoApoderadoInstance= CargoApoderado.get(params.cargoApoderado.id)
        def categoriaInstance= CategoriaDeTipoDePoder.get(params.categoria.id as long)        
        cargoApoderadoInstance.addToCategoriasDeTipoDePoder(categoriaInstance)
        flash.message = "Se ha agregado correctamente la Categoria."
        redirect(action: "edit", id : cargoApoderadoInstance.id )
    }
    def removeCategoria(Long id){
        def cargoApoderadoInstance= CargoApoderado.get(params.cargoApoderado.id)
        def categoriaInstance= CategoriaDeTipoDePoder.get(params.categoria.id as long)        
        cargoApoderadoInstance.removeFromCategoriasDeTipoDePoder(categoriaInstance)
        flash.message = "Se ha eliminado correctamente la Categoria."
        redirect(action: "edit", id : cargoApoderadoInstance.id )
    }
}
