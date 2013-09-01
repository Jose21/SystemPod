package com.app.sgcon

import org.springframework.dao.DataIntegrityViolationException
import com.app.sgcon.beans.BusquedaBean
import java.text.SimpleDateFormat

class ConvenioController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [convenioInstanceList: Convenio.list(params), convenioInstanceTotal: Convenio.count()]
    }

    def create() {
        [convenioInstance: new Convenio(params)]
    }

    def save() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date fechaDeFirma = sdf.parse(params.fechaDeFirma)
        params.fechaDeFirma = fechaDeFirma        
        def convenioInstance = new Convenio(params)
        if (!convenioInstance.save(flush: true)) {
            render(view: "create", model: [convenioInstance: convenioInstance])
            return
        }
        flash.message = message(code: 'default.created.message', args: [message(code: 'convenio.label', default: 'Convenio'), convenioInstance.id])
        redirect(action: "edit", id: convenioInstance.id)
    }

    def show(Long id) {
        def convenioInstance = Convenio.get(id)
        if (!convenioInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'convenio.label', default: 'Convenio'), id])
            redirect(action: "list")
            return
        }

        [convenioInstance: convenioInstance]
    }

    def edit(Long id) {
        def convenioInstance = Convenio.get(id)
        if (!convenioInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'convenio.label', default: 'Convenio'), id])
            redirect(action: "list")
            return
        }

        [convenioInstance: convenioInstance]
    }

    def update(Long id, Long version) {
        def convenioInstance = Convenio.get(id)
        if (!convenioInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'convenio.label', default: 'Convenio'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (convenioInstance.version > version) {
                convenioInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'convenio.label', default: 'Convenio')] as Object[],
                          "Another user has updated this Convenio while you were editing")
                render(view: "edit", model: [convenioInstance: convenioInstance])
                return
            }
        }

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date fechaDeFirma = sdf.parse(params.fechaDeFirma)
        params.fechaDeFirma = fechaDeFirma
                
        convenioInstance.properties = params

        if (!convenioInstance.save(flush: true)) {
            render(view: "edit", model: [convenioInstance: convenioInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'convenio.label', default: 'Convenio'), convenioInstance.id])
        redirect(action: "edit", id: convenioInstance.id)
    }

    def delete(Long id) {
        def convenioInstance = Convenio.get(id)
        if (!convenioInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'convenio.label', default: 'Convenio'), id])
            redirect(action: "list")
            return
        }

        try {
            convenioInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'convenio.label', default: 'Convenio'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'convenio.label', default: 'Convenio'), id])
            redirect(action: "show", id: id)
        }
    }
    
    def addFirmante () {
        def convenioInstance = Convenio.get(params.convenio.id as long)
        def personaInstance = Persona.findByNombre(params."firmante")
        if (personaInstance) {
            convenioInstance.addToFirmantes(personaInstance) 
            if (convenioInstance.save(flush:true)) {
                flash.message = "Se ha agregado un firmante al convenio."
            } else {
                flash.error = "No se pudo agregar el firmante. Favor de reintentar."
            }
        } else {
            personaInstance = new Persona(nombre:params."firmante")
            if (personaInstance.save(flush:true)) {
                convenioInstance.addToFirmantes(personaInstance)
                if (convenioInstance.save(flush:true)) {
                    flash.message = "Se ha agregado un firmante al convenio."
                } else {
                    flash.error = "No se pudo agregar el firmante. Favor de reintentar."
                }                
            } else {
                flash.error = "No se pudo agregar el firmante. Favor de reintentar."
            }
        }
        redirect(action: "edit", id: convenioInstance.id)
    }
    
    def removeFirmante () {  
        def convenioInstance = Convenio.get(params.convenio.id as long)        
        def personaInstance = Persona.get(params.firmante.id as long)
        convenioInstance.removeFromFirmantes(personaInstance)
        flash.message = "El firmante ha sido eliminado."        
        redirect(action: "edit", id: convenioInstance.id)
    }
    
    def addResponsable () {
        def convenioInstance = Convenio.get(params.convenio.id as long)
        def personaInstance = Persona.findByNombre(params."responsable")
        if (personaInstance) {
            convenioInstance.addToResponsables(personaInstance)        
            if (convenioInstance.save(flush:true)) {
                flash.message = "Se ha agregado un responsable al convenio."
            } else {
                flash.error = "No se pudo agregar el responsable. Favor de reintentar."
            }
        } else {
            personaInstance = new Persona(nombre:params."responsable")
            if (personaInstance.save(flush:true)) {
                convenioInstance.addToResponsables(personaInstance)
                if (convenioInstance.save(flush:true)) {
                    flash.message = "Se ha agregado un responsable al convenio."
                } else {
                    flash.error = "No se pudo agregar el responsable. Favor de reintentar."
                }                
            } else {
                flash.message = "No se pudo agregar el responsable. Favor de reintentar."
            }
        }
        redirect(action: "edit", id: convenioInstance.id)
    }
    
    def removeResponsable () {  
        def convenioInstance = Convenio.get(params.convenio.id as long)        
        def personaInstance = Persona.get(params.responsable.id as long)
        convenioInstance.removeFromResponsables(personaInstance)
        flash.message = "El responsable ha sido eliminado."        
        redirect(action: "edit", id: convenioInstance.id)
    }
    
    def uploadCopiaElectronica () {
        def convenioInstance = Convenio.get(params.convenio.id as long)
        def f = request.getFile('copiaElectronica')
        if (f.getSize() == 0) {
            flash.message = "Debe indicar la ruta de la copia electrónica."
        } else if (f.getSize() >= 5242880) {
            flash.warn = "El archivo debe pesar menos de 5 Mb."
        } else {               
            def filename = f.getOriginalFilename() 
            def extension = filename.substring(filename.lastIndexOf(".") + 1, filename.size()).toLowerCase()
            def extensionList = getExtensionList()
            if (extensionList.contains(extension)) {
                convenioInstance.nombreDeCopiaElectronica = filename
                convenioInstance.copiaElectronica = f.getBytes()
                if (convenioInstance.save(flash:true)) {
                    flash.message = "La copia electrónica del convenio se adjuntó satisfactoriamente."
                } else {
                    flash.error = "Error en base de datos."
                }
            } else {
                flash.warn = "El archivo debe tener alguna de las siguientes extensiones: doc, docx, pdf, jpeg, jpg, png, bmp."
            }
            
        }
        redirect(action: "edit", id: convenioInstance.id)
    }
    
    def downloadCopiaEletronica () {
        def convenioInstance = Convenio.get(params.convenioId as long)
        response.setHeader("Content-Disposition", "attachment;filename=\"" + convenioInstance.nombreDeCopiaElectronica + "\"");
        byte[] copiaElectronica = convenioInstance.copiaElectronica
        response.outputStream << copiaElectronica
    }
    
    def getExtensionList () {
        def extensiones = []
        extensiones << "doc"
        extensiones << "docx"
        extensiones << "pdf"
        extensiones << "jpeg"
        extensiones << "jpg"
        extensiones << "png"
        extensiones << "bmp"
        extensiones
    }
    
    def buscarConvenios () {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        def rangoDeFecha = params.rangoDeFecha
        def fechaInicio = sdf.parse(rangoDeFecha.split("-")[0].trim())
        def fechaFin = sdf.parse(rangoDeFecha.split("-")[1].trim())
        def busquedaBean = new BusquedaBean()        
        busquedaBean.fechaInicio = fechaInicio
        busquedaBean.fechaFin = fechaFin
        def convenioInstanceList = Convenio.findAllByFechaDeFirmaBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin)
        render(
            view: "list", 
            model: [
                convenioInstanceList: convenioInstanceList, 
                convenioInstanceTotal: convenioInstanceList.size(),
                busquedaBean : busquedaBean
            ]
        )
    }     
    
    def linkToConvenioQueModifica () {
        def convenioInstance = Convenio.get(params.convenio.id as long)
        def convenioQueModifica = Convenio.get(params.modificaA.id as long)
        convenioInstance.modificaA = convenioQueModifica        
        if (convenioInstance.save(flash:true)) {
            convenioQueModifica.esModificadoPor = convenioInstance
            if (convenioQueModifica.save(flush:true)) {
                flash.message = "El convenio al que modifica ha sido vinculado satisfactoriamente."
            } else {
                flash.error = "El convenio al que modifica no pudo ser vinculado."
            }
        } else {
            flash.error = "El convenio al que modifica no pudo ser vinculado."
        }
        redirect(action: "edit", id: convenioInstance.id)
    }
    
    def unlinkToConvenioQueModifica () {
        def convenioInstance = Convenio.get(params.convenio.id as long)
        def convenioQueModifica = Convenio.get(params.modificaA.id as long)
        convenioInstance.modificaA = null
        convenioQueModifica.esModificadoPor = null
        if (convenioInstance.save(flush:true) && convenioQueModifica.save(flush:true)) {
            flash.message = "El convenio al que modifica ha sido desvinculado."
        } else {
            flash.error = "El convenio al que modifica no pudo ser desvinculado."
        }
        redirect(action: "edit", id: convenioInstance.id)
    }
}
