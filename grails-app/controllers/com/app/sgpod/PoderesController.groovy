package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat
import com.pogos.BusquedaBean
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class PoderesController {
    def springSecurityService
    def exportService
    def grailsApplication

    def index() {
        flash.warn = null
        //Mis Poderes:poderes que alguien me asigno o poderes que yo cree y que aun no eh asignado.
        def poderesList1 = OtorgamientoDePoder.where {
            (creadaPor == springSecurityService.currentUser &&  asignar == springSecurityService.currentUser) || (creadaPor == springSecurityService.currentUser && asignar == null) || (asignar == springSecurityService.currentUser)
        }
        def poderesList2 = RevocacionDePoder.where {
            (creadaPor == springSecurityService.currentUser &&  asignar == springSecurityService.currentUser) || (creadaPor == springSecurityService.currentUser && asignar == null) || (asignar == springSecurityService.currentUser)
        }
     
        def poderesList = poderesList1.list() + poderesList2.list()
        //Poderes Asignados: yo cree y asigne a alguien mas.
        //lista de otorgamiento
        def c = OtorgamientoDePoder.createCriteria()
        def asignadosOtorgamiento = c.list {
            eq ("creadaPor", springSecurityService.currentUser)
            ne ("asignar", springSecurityService.currentUser)
        } 
        //lista de revocacion
        def d = RevocacionDePoder.createCriteria()
        def asignadosRevocacion = d.list {
            eq ("creadaPor", springSecurityService.currentUser)
            ne ("asignar", springSecurityService.currentUser)
        } 
        def poderesAsignadosList = asignadosOtorgamiento + asignadosRevocacion
        render (
            view: "index", 
            model: [
                otorgamientoInstanceList:poderesList1,
                revocacionInstanceList:poderesList2,
                poderInstanceTotal: poderesList.size(),
                otorgamientoAsignadosInstanceList:asignadosOtorgamiento,
                revocacionAsignadosInstanceList : asignadosRevocacion,
                poderesAsignadosInstanceTotal : poderesAsignadosList.size()
            ]
        )
    }
    
    def otorgamientoConsulta() {
        
        [nombreApoderadoActive:"active"] 
    }
    
    def revocacionConsulta() {
        
        [nombreApoderadoActive:"active"] 
    }
    
    def busquedaGeneral() {
        
        [nombreApoderadoActive:"active"] 
    }
    
     
    def menuConsulta() { 
    
    }
    
    def buscarNombreApoderado (){
        def nombreApoderadoActive = null
        if (params.inActive=="nombreApoderado") {
            nombreApoderadoActive = "active"
        }
        def otorgamientoDePoderInstanceList = OtorgamientoDePoder.findAllBySolicitadoPorIlike("%"+params.solicitadoPor+"%", [sort: "id", order: "asc"])
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: otorgamientoDePoderInstanceList.size(),
                nombreApoderadoActive : nombreApoderadoActive       
            ]
        )       
    }
    
    def buscarPorDelegacion (){
        def porDelegacionActive = null
        if (params.inActive=="porDelegacion") {
            porDelegacionActive = "active"
        }        
        def c = OtorgamientoDePoder.createCriteria()
        def otorgamientoDePoderInstanceList = c.list {
            delegacion {
                like("nombre", "%"+params.nombre+"%")
            }
            order("id", "asc")
        }
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: otorgamientoDePoderInstanceList.size(),
                porDelegacionActive : porDelegacionActive       
            ]
        )       
    }
    
    def buscarPorNombrePoder (){
        def porNombrePoderActive = null
        if (params.inActive=="porNombrePoder") {
            porNombrePoderActive = "active"
        }
        def otorgamientoDePoderInstanceList = OtorgamientoDePoder.findAllByNombreIlike("%"+params.nombre+"%", [sort: "id", order: "asc"])
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: otorgamientoDePoderInstanceList.size(),
                porNombrePoderActive : porNombrePoderActive       
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
        def otorgamientoDePoderInstanceList = []
        if (params.rangoDeFechaRegistro != "") {
            flash.warn = null
            rangoDeFechaRegistro = params.rangoDeFechaRegistro
            fechaInicio = sdf.parse(rangoDeFechaRegistro.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFechaRegistro.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            otorgamientoDePoderInstanceList = OtorgamientoDePoder.findAllByRegistroDeLaSolicitudBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: otorgamientoDePoderInstanceList.size(),
                busquedaBean : busquedaBean,
                rangoDeFechaRegistro : params.rangoDeFechaRegistro,
                porFechaRegistroActive : porFechaRegistroActive
            ]
        )
    }
    
    def buscarPorTags () {
        def porTagsActive = null
        if (params.inActive == "porTags") {
            porTagsActive = "active"
        }
        def s = params.tags.toString().replaceAll(" ", "")
        def resultList = s.tokenize(",")
        def otorgamientoDePoderInstanceList =[] 
        resultList.each{            
            def results = OtorgamientoDePoder.findAllByTagsIlike("%"+it+"@%", [sort: "id", order: "asc"])
            otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList + results as Set    
        }
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: otorgamientoDePoderInstanceList.size(),
                porTagsActive : porTagsActive       
            ]
        )       
    }
    
    def buscarNombreApoderadoRevocacion (){
        def nombreApoderadoActive = null
        if (params.inActive=="nombreApoderado") {
            nombreApoderadoActive = "active"
        }
        def revocacionDePoderInstanceList = RevocacionDePoder.findAllBySolicitadoPorIlike("%"+params.nombre+"%", [sort: "id", order: "asc"])
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList : revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal : revocacionDePoderInstanceList.size(),
                nombreApoderadoActive : nombreApoderadoActive       
            ]
        )       
    }
    
    def buscarPorDelegacionRevocacion (){
        def porDelegacionActive = null
        if (params.inActive=="porDelegacion") {
            porDelegacionActive = "active"
        }        
        def revocacionDePoderInstanceList = RevocacionDePoder.findAllByDelegacionIlike("%"+params.delegacion+"%", [sort: "id", order: "asc"])
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: revocacionDePoderInstanceList.size(),
                porDelegacionActive : porDelegacionActive       
            ]
        )       
    }
    
    def buscarPorNombreNotarioRevocacion (){
        def porNombreNotarioActive = null
        if (params.inActive=="porNombreNotario") {
            porNombreNotarioActive = "active"
        }
        def revocacionDePoderInstanceList = RevocacionDePoder.findAllByNombreDeNotarioIlike("%"+params.nombreNotario+"%", [sort: "id", order: "asc"])
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: revocacionDePoderInstanceList.size(),
                porNombreNotarioActive : porNombreNotarioActive       
            ]
        )       
    }
    
    def buscarPorFechaRevocacion () {
        def porFechaRevocacionActive = null
        if (params.inActive=="porFechaRevocacion") {
            porFechaRevocacionActive = "active"
        }        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")       
        def rangoDeFechaRevocacion = null
        def fechaInicio = null
        def fechaFin = null
        def busquedaBean = null
        def revocacionDePoderInstanceList = []
        if (params.rangoDeFechaRevocacion != "") {
            flash.warn = null
            rangoDeFechaRevocacion = params.rangoDeFechaRevocacion
            fechaInicio = sdf.parse(rangoDeFechaRevocacion.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFechaRevocacion.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            revocacionDePoderInstanceList = RevocacionDePoder.findAllByFechaDeRevocacionBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: revocacionDePoderInstanceList.size(),
                busquedaBean : busquedaBean,
                rangoDeFechaRevocacion : params.rangoDeFechaRevocacion,
                porFechaRevocacionActive : porFechaRevocacionActive
            ]
        )
    }
    
    def buscarPorTagsRevocacion () {
        def porTagsActive = null
        if (params.inActive == "porTags") {
            porTagsActive = "active"
        }
        def s = params.tags.toString().replaceAll(" ", "")
        def resultList = s.tokenize(",")
        def revocacionDePoderInstanceList =[] 
        resultList.each{            
            def results = RevocacionDePoder.findAllByTagsIlike("%"+it+"@%", [sort: "id", order: "asc"])
            revocacionDePoderInstanceList = revocacionDePoderInstanceList + results as Set    
        }
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: revocacionDePoderInstanceList.size(),
                porTagsActive : porTagsActive       
            ]
        )       
    }
    
    def buscarNombreGeneral (){
        def nombreApoderadoActive = null
        if (params.inActive=="nombreApoderado") {
            nombreApoderadoActive = "active"
        }
        def revocacionDePoderInstanceList = RevocacionDePoder.findAllByNombreIlike("%"+params.nombre+"%", [sort: "id", order: "asc"])
        def otorgamientoDePoderInstanceList = OtorgamientoDePoder.findAllByNombreIlike("%"+params.nombre+"%", [sort: "id", order: "asc"])
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "busquedaGeneral", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                revocacionDePoderInstanceList : revocacionDePoderInstanceList,
                otorgamientoDePoderInstanceTotal : otorgamientoDePoderInstanceList.size(),
                revocacionDePoderInstanceTotal : revocacionDePoderInstanceList.size(),
                nombreApoderadoActive : nombreApoderadoActive       
            ]
        )       
    }
    
    def buscarPorSolicitanteGeneral () {
        def solicitadoPorActive = null
        if (params.inActive=="solicitadoPor") {
            solicitadoPorActive = "active"
        }
        def revocacionDePoderInstanceList = RevocacionDePoder.findAllBySolicitadoPorIlike("%"+params.solicitadoPor+"%", [sort: "id", order: "asc"])
        def otorgamientoDePoderInstanceList = OtorgamientoDePoder.findAllBySolicitadoPorIlike("%"+params.solicitadoPor+"%", [sort: "id", order: "asc"])
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "busquedaGeneral", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                revocacionDePoderInstanceList : revocacionDePoderInstanceList,
                otorgamientoDePoderInstanceTotal : otorgamientoDePoderInstanceList.size(),
                revocacionDePoderInstanceTotal : revocacionDePoderInstanceList.size(),
                solicitadoPorActive : solicitadoPorActive       
            ]
        )       
    }
    
    def buscarPorTagsGeneral () {
        def porTagsActive = null
        if (params.inActive == "porTags") {
            porTagsActive = "active"
        }        
        def s = params.tags.toString().replaceAll(" ", "")
        def resultList = s.tokenize(",")
        def otorgamientoDePoderInstanceList =[] 
        resultList.each{            
            def results = OtorgamientoDePoder.findAllByTagsIlike("%"+it+"@%", [sort: "id", order: "asc"])
            otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList + results as Set    
        }
        def st = params.tags.toString().replaceAll(" ", "")
        def resultList2 = st.tokenize(",")
        def revocacionDePoderInstanceList =[] 
        resultList2.each{            
            def results2 = RevocacionDePoder.findAllByTagsIlike("%"+it+"@%", [sort: "id", order: "asc"])
            revocacionDePoderInstanceList = revocacionDePoderInstanceList + results2 as Set    
        }
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "busquedaGeneral", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                revocacionDePoderInstanceList : revocacionDePoderInstanceList,
                otorgamientoDePoderInstanceTotal : otorgamientoDePoderInstanceList.size(),
                revocacionDePoderInstanceTotal : revocacionDePoderInstanceList.size(),
                porTagsActive : porTagsActive       
            ]
        )       
    }
    
    def generarReporteOtorgamiento(){
        def otorgamientoDePoderInstanceList = session.otorgamientoDePoderInstanceList
        def inActive = session.inActive
        log.info "activo:." + session.inActive
        log.info "total::." + session.otorgamientoDePoderInstanceList.size()
        log.info "params::::::::::::::::"+ params
        log.info "convenioinstance::::::"+ session.otorgamientoDePoderInstanceList
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=otorgamiento.${params.extension}")
            List fields = ["id", "nombre", "solicitadoPor", "numeroDeFolio", "registroDeLaSolicitud","puesto", "tipoDePoder","delegacion"]
            Map labels = ["id": "Id Interno", "solicitadoPor": "Solicitado Por","numeroDeFolio": "No.Folio","registroDeLaSolicitud":"Registro De Solicitud","puesto":"Puesto",\
                          "contrato":"Contrato","tipoDePoder":"Tipo de Poder","delegacion":"Delegación"]
            def upperCase = { domain, value ->
                return value.toUpperCase()
            }
            Map formatters = [contrato: upperCase]		
            Map parameters = [title: "Reporte de Otorgamiento de Poder ", "column.widths": [0.2, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4], "title.font.size":12]

            exportService.export(params.format, response.outputStream, session.otorgamientoDePoderInstanceList, fields, labels, formatters, parameters)
        }
        render(
            view: "list", 
            model: [inActive: inActive, otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList ]
        )
        
    }
    
    def generarReporteRevocacion(){
        def revocacionDePoderInstanceList = session.revocacionDePoderInstanceList
        def inActive = session.inActive
        log.info "activo:." + session.inActive
        log.info "total::." + session.revocacionDePoderInstanceList.size()
        log.info "params::::::::::::::::"+ params
        log.info "convenioinstance::::::"+ session.revocacionDePoderInstanceList
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=revocacion.${params.extension}")
            List fields = ["id", "nombre", "solicitadoPor", "escrituraPublica", "nombreDeNotario","puesto","fechaDeRevocacion"]
            Map labels = ["id": "Id Interno","nombre": "Nombre Apoderado", "solicitadoPor": "Solicitado Por","escrituraPublica":"Escritura Pública","nombreDeNotario":"Nombre Notario",\
                          "puesto":"Puesto","fechaDeRevocacion":"Fecha Revocación"]
            def upperCase = { domain, value ->
                return value.toUpperCase()
            }
            Map formatters = [nombreDeNotario: upperCase]		
            Map parameters = [title: "Reporte de Revocación de Poder ", "column.widths": [0.2, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4], "title.font.size":12]

            exportService.export(params.format, response.outputStream, session.revocacionDePoderInstanceList, fields, labels, formatters, parameters)
        }
        render(
            view: "list", 
            model: [inActive: inActive, revocacionDePoderInstanceList: revocacionDePoderInstanceList ]
        )
        
    }
    
}
