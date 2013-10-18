package com.app.sgcon

import org.springframework.dao.DataIntegrityViolationException
import com.app.sgcon.beans.BusquedaBean
import java.text.SimpleDateFormat
import com.app.security.Usuario
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class ConvenioController {

    def springSecurityService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
         [porFolioActive:"active"]
         
    }

    def create() {
        [convenioInstance: new Convenio(params)]
    }

    def save() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        
        if (params.vigencia != "Indefinida") {
            Date vigencia = sdf.parse(params.vigencia)
            params.vigencia = vigencia
        } else {
            params.vigencia = null
        }
        
        if (params.fechaDeFirma == "") {
            flash.error = "Debe existir una fecha de firma del convenio."
            redirect(action: "create", params:params)
            return
        }
        Date fechaDeFirma = sdf.parse(params.fechaDeFirma)        
        params.fechaDeFirma = fechaDeFirma        
        
        def convenioInstance = new Convenio(params)
        
        //TODO Corregir
        if (!convenioInstance.save(flush: true)) {
            render(view: "create", model: [convenioInstance: convenioInstance])
            return
        }

        //Se agrega el que lo creó como dueño y se le comparte por default
        def usuarioDeConvenio = new UsuarioDeConvenio()
        usuarioDeConvenio.usuario = springSecurityService.currentUser
        usuarioDeConvenio.owner = true
        usuarioDeConvenio.convenio = convenioInstance
        usuarioDeConvenio.save(flush:true)
        
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
        session.idConvenio = null
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
        if (params.fechaDeFirma == "") {
            flash.error = "Debe existir una fecha de firma del convenio."
            params.fechaDeFirma = null
        } else {
            Date fechaDeFirma = sdf.parse(params.fechaDeFirma)        
            params.fechaDeFirma = fechaDeFirma
        }
        
        if (params.vigencia != "Indefinida") {
            Date vigencia = sdf.parse(params.vigencia)
            params.vigencia = vigencia
        } else {
            params.vigencia = null
        }
                
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
        redirect(action: "edit", id: convenioInstance.id, anchor : params.anchor)
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
        } else if (f.getSize() >= 52428800) {
            flash.warn = "El archivo debe pesar menos de 50 Mb."
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
    
    def rangoDeFecha () {
        def rangoDeFechaActive = null
        if (params.inActive=="rangoDeFecha") {
            rangoDeFechaActive = "active"
        }        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")       
        def rangoDeFecha = null
        def fechaInicio = null
        def fechaFin = null
        def busquedaBean = null
        def convenioInstanceList = []        
        if (params.rangoDeFecha != "") {
            flash.warn = null
            rangoDeFecha = params.rangoDeFecha
            fechaInicio = sdf.parse(rangoDeFecha.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFecha.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            convenioInstanceList = Convenio.findAllByFechaDeFirmaBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin,, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        render(
            view: "list", 
            model: [
                convenioInstanceList: convenioInstanceList, 
                convenioInstanceTotal: convenioInstanceList.size(),
                busquedaBean : busquedaBean,
                rangoDeFecha : params.rangoDeFecha,
                rangoDeFechaActive : rangoDeFechaActive
            ]
        )
    }
    def buscarPorFolio (){        
        def porFolioActive = null
        if (params.inActive=="porFolio") {
            porFolioActive = "active"
        }        
        def numeroDeConvenio = null
        def convenioInstanceList = null
        if (params.numeroDeConvenio != "") {
            flash.warn = null
            numeroDeConvenio = params.numeroDeConvenio
            convenioInstanceList = Convenio.findAllByNumeroDeConvenioIlike("%"+params.numeroDeConvenio+"%", [sort: "id", order: "asc"])
            
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        render(
            view: "list", 
            model: [
                convenioInstanceList: convenioInstanceList,
                convenioInstanceTotal: convenioInstanceList.size(),
                numeroDeConvenio: params.numeroDeConvenio,
                porFolioActive : porFolioActive
                
            ]
        )  
    }
    def buscarPorNombreResponsables (){
        def nombreResponsablesActive = null
        if (params.inActive=="nombreResponsables") {
            nombreResponsablesActive = "active"
        }        
        def c = Convenio.createCriteria()
        def convenioInstanceList = c.list {
            responsables {
                like("nombre", "%"+params.nombre+"%")
            }
            order("id", "asc")
        }       
        render(
            view: "list", 
            model: [
                convenioInstanceList: convenioInstanceList,
                convenioInstanceTotal: convenioInstanceList.size(),
                nombreResponsablesActive : nombreResponsablesActive       
            ]
        )       
    } 
    def buscarPorCategoria (){
        def porCategoriaActive = null
        if (params.inActive=="porCategoria") {
            porCategoriaActive = "active"
        }        
        def c = Convenio.createCriteria()
        def convenioInstanceList = c.list {
            status {
                like("nombre", "%"+params.nombre+"%")
            }
            order("id", "asc")
        }       
        render(
            view: "list", 
            model: [
                convenioInstanceList: convenioInstanceList,
                convenioInstanceTotal: convenioInstanceList.size(),
                porCategoriaActive : porCategoriaActive       
            ]
        )       
    }
    def buscarPorFechaRegistro () {
        def porFechaRegistroActive = null
        if (params.inActive=="porFechaRegistro") {
            porFechaRegistroActive = "active"
        }        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")       
        def rangoDeFechaRegistro = null
        def fechaInicio = null
        def fechaFin = null
        def busquedaBean = null
        def convenioInstanceList = []
        if (params.rangoDeFechaRegistro != "") {
            flash.warn = null
            rangoDeFechaRegistro = params.rangoDeFechaRegistro
            fechaInicio = sdf.parse(rangoDeFechaRegistro.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFechaRegistro.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            convenioInstanceList = Convenio.findAllByDateCreatedBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        render(
            view: "list", 
            model: [
                convenioInstanceList: convenioInstanceList, 
                convenioInstanceTotal: convenioInstanceList.size(),
                busquedaBean : busquedaBean,
                rangoDeFechaRegistro : params.rangoDeFechaRegistro,
                porFechaRegistroActive : porFechaRegistroActive
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
    
    def share (Long id) {
        def convenioInstance = Convenio.get(id)
        [ convenioInstance : convenioInstance ]
    }
    
    def addUsuarioToConvenio(Long id) {
        def convenioInstance = Convenio.get(id)        
        def compartirCon = Usuario.get(params.compartidoCon.id as long)
        def lista = convenioInstance.usuariosDeConvenio
        def existe = false
        lista.each {
            if (it.usuario.id == compartirCon.id) {
                existe = true
            }
        }
        if (!existe) {
            def usuarioDeConvenio = new UsuarioDeConvenio()
            usuarioDeConvenio.usuario = compartirCon
            usuarioDeConvenio.owner = false
            usuarioDeConvenio.convenio = convenioInstance
            usuarioDeConvenio.save(flush:true)
            flash.message = "Convenio compartido satisfactoriamente."
        } else {
            flash.warn = "Ya se encuentra compartido con el usuario seleccionado."
        }
        redirect (action:"share", params : [ id : convenioInstance.id ])
    }
    
    def removeUsuarioFromConvenio() {
        def convenioInstance = Convenio.get(params.convenioId as long)
        def usuario = Usuario.get(params.usuarioId as long)
        def usuarioDeConvenio = UsuarioDeConvenio.findByConvenioAndUsuario(convenioInstance, usuario)
        usuarioDeConvenio.delete()
        redirect (action:"share", params : [ id : convenioInstance.id ])
    }
    
    def regresar(Long id) {
        redirect(action: "edit", id: id)
    }
}
