package com.app.sgcon

import org.springframework.dao.DataIntegrityViolationException
import com.app.sgcon.beans.BusquedaBean
import java.text.SimpleDateFormat
import com.app.security.Usuario
import grails.plugins.springsecurity.Secured
import com.app.sgcon.HistorialDeConvenio

@Secured(['IS_AUTHENTICATED_FULLY'])
class ConvenioController {
    def exportService
    def grailsApplication
    def springSecurityService
    def historialDeConvenioService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        flash.error = null
        redirect(action: "list", params: params)
    }
    /**
     * Metodo apara enlistar los registros existentes en una domain class 
     */
    def list() {
        flash.error = null
        flash.info = null
        flash.message = null
        flash.warn = null
        [porTagsActive:"active"]  
    }
    /**
     * Este metodo sirve para la creacion de un registro de un convenio.
     */
    def create() {
        flash.warn = null
        flash.info = null
        [convenioInstance: new Convenio(params)]
    }
    /**
     * Metodo para guardar los registros en el sistema
     */
    def save() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        
        if (params.vigencia != "Indefinida") {
            Date vigencia = sdf.parse(params.vigencia)
            params.vigencia = vigencia           
        } else {
            params.vigencia = null
        }
        
        /*
        if (!params.fechaDeFirma) {
        flash.error = "Debe existir una fecha de firma del convenio."
        redirect(action: "create", params:params)
        return
        }*/
        
        if (params.fechaDeFirma) {
            Date fechaDeFirma = sdf.parse(params?.fechaDeFirma)        
            params?.fechaDeFirma = fechaDeFirma
        }
        
        
        
        
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
        
        //validacion para la busqueda por tags
        if(convenioInstance.tags){
            if(convenioInstance.tags.endsWith(",")){
                params.tags = params.tags.substring(0, params.tags.length() -1)
            }else {
                convenioInstance.tags = convenioInstance.tags + "," 
            }
        }
        //end busqueda tags
        
        flash.message = message(code: 'default.created.message', args: [message(code: 'convenio.label', default: 'Convenio'), convenioInstance.id])
        historialDeConvenioService.addNewConvenioToHistorial(convenioInstance, null, null,"Se creo Convenio")
        redirect(action: "edit", id: convenioInstance.id)
    }
    /**
     * Metodo para visualizar el registro creado en el sistema.
     */
    def show(Long id) {
        def convenioInstance = Convenio.get(id)
        if (!convenioInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'convenio.label', default: 'Convenio'), id])
            redirect(action: "list")
            return
        }
              
        [convenioInstance: convenioInstance]
    }
    /**
     * Metodo para editar un registro.
     */
    def edit(Long id, String nombreDeCopiaElectronica) {
        session.idConvenio = null
        def convenioInstance = Convenio.get(id)
        def yesedit = null        
        if (convenioInstance.editable == true){
            flash.info = null
            yesedit = true 
        }else{
            flash.info= "El convenio no puede editarse porque esta actualmente firmado."   
            yesedit = false
        }          
        if (!convenioInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'convenio.label', default: 'Convenio'), id])
            redirect(action: "list")
            return
        }
        //log.info "Edit: anchor->" + params.anchor
        [convenioInstance: convenioInstance, anchor : params.anchor?:"", yesedit:yesedit]
    }
    /**
     * Metodo para actualizar los datos de un registro
     */
    def update(Long id, Long version) {
        def convenioInstance = Convenio.get(id)
        def convenioOriginal = new Convenio(convenioInstance.properties)
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
        
        //validacion para la busqueda por tags
        if(convenioInstance.tags){
            if(convenioInstance.tags.endsWith(",")){
                params.tags = params.tags.substring(0, params.tags.length() -1)
            }else {
                convenioInstance.tags = convenioInstance.tags + "," 
            }
        }
        //end busqueda tags
                                                 
        if (convenioInstance.isDirty()) {  
            historialDeConvenioService.agregar(convenioInstance, convenioOriginal, "Se editó el convenio:")
        }
        
        if (!convenioInstance.save(flush: true)) {
            render(view: "edit", model: [convenioInstance: convenioInstance])
            return
        }                

        flash.message = message(code: 'default.updated.message', args: [message(code: 'convenio.label', default: 'Convenio'), convenioInstance.id])
        redirect(action: "edit", id: convenioInstance.id, params : [ anchor : params.anchor ])
    }
    /**
     * Metodo para eliminar el registro del sistema.
     */
    def delete(Long id) {        
        def convenioInstance = Convenio.get(params.id)        
        if (!convenioInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'convenio.label', default: 'Convenio'), id])
            redirect(action: "list")
            return
        }

        try {
            //convenioInstance.delete(flush:true)
            convenioInstance.eliminado = true
            flash.message = "El convenio ha sido eliminado exitosamente."
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.error = message(code: 'default.not.deleted.message', args: [message(code: 'convenio.label', default: 'Convenio'), id])
            redirect(action: "show", id: id)
        }
    }
    /**
     * Método para agregar un firmante al convenio.
     */
    def addFirmante () {
        def convenioInstance = Convenio.get(params.convenio.id as long)
        def personaInstance = Persona.findByNombre(params."firmante")
        if (personaInstance) {
            convenioInstance.addToFirmantes(personaInstance)
            if (convenioInstance.save(flush:true)) {
                historialDeConvenioService.addPersonaToHistorial(personaInstance, convenioInstance, null, null,"Se agregó Firmante")
                flash.message = "Se ha agregado un firmante al convenio."
            } else {
                flash.error = "No se pudo agregar el firmante. Favor de reintentar."
            }
        } else {
            personaInstance = new Persona(nombre:params."firmante")
            if (personaInstance.save(flush:true)) {
                convenioInstance.addToFirmantes(personaInstance)
                if (convenioInstance.save(flush:true)) {
                    historialDeConvenioService.addPersonaToHistorial(personaInstance, convenioInstance, null, null,"Se agregó Firmante")
                    flash.message = "Se ha agregado un firmante al convenio."
                } else {
                    flash.error = "No se pudo agregar el firmante. Favor de reintentar."
                }                
            } else if (!params.firmante){
                flash.error = "Debe agregar el nombre del Firmante. Favor de reintentar."
            }else {
                flash.error = "No se pudo agregar el firmante. Favor de reintentar."
            }
        }
        redirect(action: "edit", id: convenioInstance.id, params : [anchor : params.anchor])
    }
    /**
     * Metodo para eliminar un firmante del convenio.
     */
    def removeFirmante () {
        def convenioInstance = Convenio.get(params.convenio.id as long)        
        def personaInstance = Persona.get(params.firmante.id as long)
        convenioInstance.removeFromFirmantes(personaInstance)
        historialDeConvenioService.removePersonaToHistorial(personaInstance, convenioInstance, null, null,"Se eliminó Firmante")
        flash.message = "El firmante ha sido eliminado."        
        redirect(action: "edit", id: convenioInstance.id, params : [ anchor : params.anchor ])
    }
    /**
     * Metodo para agregar un responsable del convenio.
     */
    
    def addResponsable () {
        def convenioInstance = Convenio.get(params.convenio.id as long)
        def personaInstance = Persona.findByNombre(params."responsable")
        if (personaInstance) {
            convenioInstance.addToResponsables(personaInstance)        
            if (convenioInstance.save(flush:true)) {
                historialDeConvenioService.addPersonaToHistorial(personaInstance, convenioInstance, null, null,"Se agregó Responsable")
                flash.message = "Se ha agregado un responsable al convenio."
            } else {
                flash.error = "No se pudo agregar el responsable. Favor de reintentar."
            }
        } else {
            personaInstance = new Persona(nombre:params."responsable")
            if (personaInstance.save(flush:true)) {
                convenioInstance.addToResponsables(personaInstance)
                if (convenioInstance.save(flush:true)) {
                    historialDeConvenioService.addPersonaToHistorial(personaInstance, convenioInstance, null, null,"Se agregó Responsable")
                    flash.message = "Se ha agregado un responsable al convenio."
                } else {
                    flash.error = "No se pudo agregar el responsable. Favor de reintentar."
                }                
            } else if (!params.responsable){
                flash.error = "Debe agregar el nombre del Responsable. Favor de reintentar."
            }else {
                flash.error = "No se pudo agregar el responsable. Favor de reintentar."
            }
        }
        redirect(action: "edit", id: convenioInstance.id, params : [ anchor : params.anchor ])
    }
    /**
     * Metodo para eliminar un responsable del convenio.
     */
    def removeResponsable () {  
        def convenioInstance = Convenio.get(params.convenio.id as long)        
        def personaInstance = Persona.get(params.responsable.id as long)
        convenioInstance.removeFromResponsables(personaInstance)
        historialDeConvenioService.removePersonaToHistorial(personaInstance, convenioInstance, null, null,"Se eliminó Responsable")
        flash.message = "El responsable ha sido eliminado."        
        redirect(action: "edit", id: convenioInstance.id, params : [ anchor : params.anchor ])
    }
    /**
     * Metodo para cargar al sistema la copia electronica del convenio firmado.
     */
    def uploadCopiaElectronica () {
        def convenioInstance = Convenio.get(params.convenio.id as long)
        def f = request.getFile('copiaElectronica')
        if (f.getSize() == 0) {
            flash.warn = "Debe indicar la ruta de la copia electrónica."
        } else if (f.getSize() >= 52428800) {
            flash.warn = "El archivo debe pesar menos de 50 Mb."
        } else {
            def filename = f.getOriginalFilename()                         
            def extension = filename.substring(filename.lastIndexOf(".") + 1, filename.size()).toLowerCase()
            
           //se agregar estas lineas para quitar la validacion sobre la extension de la copia alectronica.
            convenioInstance.nombreDeCopiaElectronica = filename
            convenioInstance.copiaElectronica = f.getBytes()
            if (convenioInstance.save(flash:true)) {
                historialDeConvenioService.addCopiaFirmaToHistorial(convenioInstance, null, null,"Se adjuntó copia de Firma Electronica")
                flash.message = "La copia electrónica del convenio se adjuntó satisfactoriamente."
            } else {
                flash.error = "Error en base de datos."
            }
            
            //se comentan para quitar la validacion
            /*
            def extensionList = getExtensionList()
            if (extensionList.contains(extension)) {
            //bandera para deshabilitar la edicion.
            //se deshabilitó la opcion
            //convenioInstance.editable = false
            convenioInstance.nombreDeCopiaElectronica = filename
            convenioInstance.copiaElectronica = f.getBytes()
            if (convenioInstance.save(flash:true)) {
            historialDeConvenioService.addCopiaFirmaToHistorial(convenioInstance, null, null,"Se adjuntó copia de Firma Electronica")
            flash.message = "La copia electrónica del convenio se adjuntó satisfactoriamente."
            } else {
            flash.error = "Error en base de datos."
            }
            } else {
            flash.warn = "El archivo debe tener alguna de las siguientes extensiones: doc, docx, pdf, jpeg, jpg, png, bmp."
            
             */
            
        }
        redirect(action: "edit", id: convenioInstance.id, params : [ anchor : params.anchor ])
    }
    /**
     * Metodo para descargar el documento del convenio.
     */
    def downloadCopiaEletronica () {
        def convenioInstance = Convenio.get(params.convenioId as long)
        response.setHeader("Content-Disposition", "attachment;filename=\"" + convenioInstance.nombreDeCopiaElectronica + "\"");
        byte[] copiaElectronica = convenioInstance.copiaElectronica
        response.outputStream << copiaElectronica
    }
    /**
     * Metodo para enlistar los tipo de formatos aceptados por sistema. 
     */
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
    /**
     * metodo para generar un rango de fecha entre las fechas del calendario que aperece en el formulario.
     */
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
            convenioInstanceList = Convenio.findAllByFechaDeFirmaBetweenAndEliminado(busquedaBean.fechaInicio, busquedaBean.fechaFin, false, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        session.convenioInstanceList = convenioInstanceList
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
    /**
     * Método para realizar una búsqueda por folio del convenio.
     */
    def buscarPorFolio (){        
        def porFolioActive = null
        if (params.inActive=="porFolio") {
            porFolioActive = "active"
        }        
        def numeroDeConvenio = null
        def convenioInstanceList = null
        def inActive = "active"
        if (params.numeroDeConvenio != "") {
            flash.warn = null
            numeroDeConvenio = params.numeroDeConvenio
            convenioInstanceList = Convenio.findAllByNumeroDeConvenioIlike("%"+params.numeroDeConvenio+"%", [sort: "id", order: "asc"])
            
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        session.convenioInstanceList = convenioInstanceList
        session.inActive = inActive
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
    /**
     * Método para realizar una búsqueda por nombre del reponsable del convenio.
     */
    def buscarPorNombreResponsables (){
        def nombreResponsablesActive = null
        if (params.inActive=="nombreResponsables") {
            nombreResponsablesActive = "active"
        }        
        def c = Convenio.createCriteria()
        def convenioInstanceList = c.list {         
            eq("eliminado", false)
            and{
                responsables {
                    ilike("nombre", "%"+params.nombre+"%")             
                }
            }
            order("id", "asc")
        }
        //def convenioInstanceList = Convenio.findAllByResponsablesIlikeAndDelete("")
        session.convenioInstanceList = convenioInstanceList
        render(
            view: "list", 
            model: [
                convenioInstanceList: convenioInstanceList,
                convenioInstanceTotal: convenioInstanceList.size(),
                nombreResponsablesActive : nombreResponsablesActive       
            ]
        )       
    }
    /**
     * Método para realizar una búsqueda por nombre del firmante del convenio.
     */
    def buscarPorNombreFirmantes () {
        def nombreFirmantesActive = null
        if (params.inActive == "nombreFirmantes") {
            nombreFirmantesActive = "active"
        }        
        def c = Convenio.createCriteria()
        def convenioInstanceList = c.list {
            eq("eliminado", false)
            and{
                firmantes {
                    ilike("nombre", "%"+params.nombre+"%")
                }
            }
            order("id", "asc")
        }
        session.convenioInstanceList = convenioInstanceList
        render(
            view: "list", 
            model: [
                convenioInstanceList: convenioInstanceList,
                convenioInstanceTotal: convenioInstanceList.size(),
                nombreFirmantesActive : nombreFirmantesActive       
            ]
        )       
    }
    /**
     * Método para realizar una búsqueda por categoria del convenio.
     */
    def buscarPorCategoria (){
        def porCategoriaActive = null
        if (params.inActive=="porCategoria") {
            porCategoriaActive = "active"
        }        
        def c = Convenio.createCriteria()
        def convenioInstanceList = c.list {
            eq("eliminado", false)
            and{
                status {
                    like("nombre", "%"+params.nombre+"%")
                }
            }
            order("id", "asc")
        }
        session.convenioInstanceList = convenioInstanceList
        render(
            view: "list", 
            model: [
                convenioInstanceList: convenioInstanceList,
                convenioInstanceTotal: convenioInstanceList.size(),
                porCategoriaActive : porCategoriaActive       
            ]
        )       
    }
    /**
     * Método para realizar una búsqueda por fecha de registro del convenio.
     */
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
            convenioInstanceList = Convenio.findAllByDateCreatedBetweenAndEliminado(busquedaBean.fechaInicio, busquedaBean.fechaFin, false, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        session.convenioInstanceList = convenioInstanceList
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
    /**
     * Método para realizar una búsqueda por palabras clave.
     */
    def buscarPorTags () {
        def porTagsActive = null
        if (params.inActive == "porTags") {
            porTagsActive = "active"
        }
        /*def s = params.tags.toString().replaceAll(" ", "")
        def resultList = s.tokenize(",")
        def convenioInstanceList =[] 
        resultList.each{            
        def results = Convenio.findAllByTagsIlikeAndEliminado("%"+it+",%", false, [sort: "id", order: "asc"])
        convenioInstanceList = convenioInstanceList + results as Set    
        }*/
        def convenioInstanceList = Convenio.findAllByTagsIlikeAndEliminado("%"+params.tags+"%", false, [sort: "id", order: "asc"])
        session.convenioInstanceList = convenioInstanceList
        render(
            view: "list", 
            model: [
                convenioInstanceList: convenioInstanceList,
                convenioInstanceTotal: convenioInstanceList.size(),
                porTagsActive : porTagsActive       
            ]
        )       
    }
    /**
     * Método para generar un reporte sobre las consultas.
     */
    def generarReporte(){
        def convenioInstanceList = session.convenioInstanceList
        def inActive = session.inActive
        log.info "activo:." + session.inActive
        log.info "total::." + session.convenioInstanceList.size()
        log.info "params::::::::::::::::"+ params
        log.info "convenioinstance::::::"+ session.convenioInstanceList
        if (convenioInstanceList.size() != 0) {
            log.info "despues del if::::::"+ convenioInstanceList
            flash.warn = null
            if(params?.format && params.format != "html"){
                response.contentType = grailsApplication.config.grails.mime.types[params.format]
                response.setHeader("Content-disposition", "attachment; filename=convenios.${params.extension}")
                List fields = ["id", "objeto", "dateCreated", "fechaDeFirma","responsables","firmantes", "institucion", "status"]
                Map labels = ["id": "Id Interno","objeto" : "Objeto", "dateCreated":"Fecha Registro","fechaDeFirma":"Fecha Firma",\
                              "responsables":"Responsables","firmantes":"Firmantes","institucion":"Institucion","status":"Estatus"]
                def upperCase = { domain, value ->
                    return value.toUpperCase()
                }
                Map formatters = [institucion: upperCase]		
                Map parameters = [title: "Reporte De Convenios", "column.widths": [0.2, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4], "title.font.size":12]

                exportService.export(params.format, response.outputStream, session.convenioInstanceList, fields, labels, formatters, parameters)
            }
        }else{
            log.info "<<<aaaaaaaaaaaaaaaaa" 
            flash.warn = "No hay datos para generar reporte."
            
        }
        render(
            view: "list", 
            model: [inActive: inActive, convenioInstanceList: convenioInstanceList ]
        )
        
    }
    
    /**
     * Método para realizar una busqueda por tipo de poder.
     */
    
    def buscarPorTipoConvenio (){
        def tipoConvenioActive = null
        if (params.inActive=="tipoConvenio") {
            tipoConvenioActive = "active"
        }        
        def convenioInstanceList = Convenio.findAllByTipoDeConvenioIlikeAndEliminado("%"+params.tipoConvenio+"%",false, [sort: "id", order: "asc"])
                            
        session.convenioInstanceList = convenioInstanceList
        render(
            view: "list", 
            model: [
                convenioInstanceList: convenioInstanceList,
                convenioInstanceTotal: convenioInstanceList.size(),
                tipoConvenioActive : tipoConvenioActive       
            ]
        )       
    }
    /**
     * Método para vincular un convenio con un convenio modificatorio.
     */
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
    /**
     * Método para desvincular un convenio de otro.
     */
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
    /**
     * Método para compartir un convenio.
     */
    def share (Long id) {
        def convenioInstance = Convenio.get(id)
        [ convenioInstance : convenioInstance ]
    }
    /**
     * Método para compartir un convenio agregando datos del usuario.
     */
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
    /**
     * Dejar de compartir el convenio con algun usuario.
     */
    def removeUsuarioFromConvenio() {
        def convenioInstance = Convenio.get(params.convenioId as long)
        def usuario = Usuario.get(params.usuarioId as long)
        def usuarioDeConvenio = UsuarioDeConvenio.findByConvenioAndUsuario(convenioInstance, usuario)
        usuarioDeConvenio.delete()
        redirect (action:"share", params : [ id : convenioInstance.id ])
    }
    /**
     * Botón que ayuda  a la navegación entre pantallas de un convenio.
     */
    def regresar(Long id) {
        redirect(action: "edit", id: id)
    }
    /**
     * Método que ayuda a visualizar todo los campos de un convenio.
     */
    def detalles(Long id){
        def convenioInstance = Convenio.get(id)
        [ convenioInstance : convenioInstance ]
    }
    /**
     * Método para realizar una búsqueda del historial de un convenio.
     */
    def buscarHistorial (Long id){
        def convenioInstance = Convenio.get(id)
        def convenioInstanceList = HistorialDeConvenio.findAllByConvenio(convenioInstance, [sort: "dateCreated", order: "desc"])
        render(
            view: "historial", 
            model: [
                convenioInstanceList: convenioInstanceList,
                convenioInstance : convenioInstance
            ]
        )
    } 
}

