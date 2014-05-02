package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat
import com.pogos.BusquedaBean
import grails.plugins.springsecurity.Secured
import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol

@Secured(['IS_AUTHENTICATED_FULLY'])
class PoderesController {
    def springSecurityService
    def exportService
    def grailsApplication

    /**
     * Método para agregar a la bandeja de pendientes las solicitudes que corresponden.
     */
    def index(Integer max) {
        
        params.max = Math.min(max ?: 10, 100)
        
        flash.warn = null
        //Mis Poderes:poderes que alguien me asigno o poderes que yo cree y que aun no eh asignado.
        def poderesList1 = OtorgamientoDePoder.where {
            (creadaPor == springSecurityService.currentUser &&  asignar == springSecurityService.currentUser && ocultadoPorSolicitante == false) || (creadaPor == springSecurityService.currentUser && asignar == null) || (asignar == springSecurityService.currentUser && ocultadoPorSolicitante == false)
        }               
        def poderesList2 = RevocacionDePoder.where {
            (creadaPor == springSecurityService.currentUser &&  asignar == springSecurityService.currentUser && ocultadoPorSolicitante == false) || (creadaPor == springSecurityService.currentUser && asignar == null) || (asignar == springSecurityService.currentUser && ocultadoPorSolicitante == false)
        }    
        def poderesList = poderesList1.list() + poderesList2.list()
        
        def parameters = ConfigurarParametro.get(1 as long)        
        
        def otorgamientosRojosList = []
        def otorgamientosAmarillosList = []
        def otorgamientosVerdesList = []
        def otorgamientosNoAsignadosList = []
        poderesList1.each {poder ->
            if(poder.fechaDeEnvio){
                def fechaHoy = new Date() 
                def diasDeProrroga = null
                def diasDeProrrogaTotal = 0
                def fechaDeEnvio = poder.fechaDeEnvio                
                def diasPosteriores = fechaHoy - fechaDeEnvio                
                if(poder.prorrogas){                                         
                    
                    def prorrogasList = poder.prorrogas.sort{ it.getId() }                                                          
                    def prorrogaLast = prorrogasList.last()
                    def prorrogaFirst = prorrogasList.get(0)                    
                    def inicioProrroga = prorrogaFirst.fechaDeEnvio                     
                    def fechaDeTerminoProrroga = prorrogaLast.fechaProrroga                     
                    def hoy = new Date()
                    def diasRestantes = fechaDeTerminoProrroga - hoy                     
                    if(diasRestantes == 0){
                        otorgamientosRojosList.add(poder)
                    }else{
                        otorgamientosVerdesList.add(poder)
                    }
                }else{ 
                    if(diasPosteriores <= parameters.estadoCriticoSolicitud){
                        otorgamientosVerdesList.add(poder)
                    }else if(diasPosteriores <= parameters.estadoSemiSolicitud && diasPosteriores > parameters.estadoCriticoSolicitud){
                        otorgamientosAmarillosList.add(poder)
                    }else if(diasPosteriores > parameters.estadoSemiSolicitud){
                        otorgamientosRojosList.add(poder)
                    } 
                }
            }else{
                otorgamientosNoAsignadosList.add(poder)
            }            
        }        
        def revocacionesRojosList = []
        def revocacionesAmarillosList = []
        def revocacionesVerdesList = []
        def revocacionesNoAsignadosList = []
        poderesList2.each {poder ->
            if(poder.fechaDeEnvio){
                def fechaHoy = new Date()
                def diasDeProrroga = null
                def diasDeProrrogaTotal = 0
                def fechaDeEnvio = poder.fechaDeEnvio                
                def diasPosteriores = fechaHoy - fechaDeEnvio
                
                if(poder.prorrogas){                                        
                    
                    def prorrogasList = poder.prorrogas.sort{ it.getId() }                                                          
                    def prorrogaFirst = prorrogasList.get(0)
                    def prorrogaLast = prorrogasList.last()                                       
                    def inicioProrroga = prorrogaFirst.fechaDeEnvio                     
                    def fechaDeTerminoProrroga = prorrogaLast.fechaProrroga                                      
                    def hoy = new Date()
                    def diasRestantes = fechaDeTerminoProrroga - hoy                    
                    if(diasRestantes == 0){
                        revocacionesRojosList.add(poder)
                    }else{
                        revocacionesVerdesList.add(poder)
                    }
                }else{                
                    if(diasPosteriores <= parameters.estadoCriticoSolicitud){
                        revocacionesVerdesList.add(poder)
                    }else if(diasPosteriores <= parameters.estadoSemiSolicitud && diasPosteriores > parameters.estadoCriticoSolicitud){
                        revocacionesAmarillosList.add(poder)
                    }else if(diasPosteriores > parameters.estadoSemiSolicitud){
                        revocacionesRojosList.add(poder)
                    } 
                }
            }else{
                revocacionesNoAsignadosList.add(poder)
            }            
        }
        
        //Poderes Asignados: yo cree y asigne a alguien mas.
        //lista de otorgamiento
        def c = OtorgamientoDePoder.createCriteria()
        def asignadosOtorgamiento = c.list {
            eq ("asignadaPor", springSecurityService.currentUser)
            ne ("asignar", springSecurityService.currentUser)
        } 
        //lista de revocacion
        def d = RevocacionDePoder.createCriteria()
        def asignadosRevocacion = d.list {
            eq ("asignadaPor", springSecurityService.currentUser)
            ne ("asignar", springSecurityService.currentUser)
        } 
        def poderesAsignadosList = asignadosOtorgamiento + asignadosRevocacion
        
        //lista de enviados al notario por parte del usuario resolvedor
        //solicitudes de otorgamiento        
        def usuarioNotario = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_NOTARIO")).collect {it.usuario}
        def enviadosOtorgamientosNotario = null
        def enviadosRevocacionesNotario = null
        def enviados = []
        def enviados2 = []
        usuarioNotario.each{
            def usuarioInstance = Usuario.get(it.id as long)            
            def e = OtorgamientoDePoder.createCriteria()
            enviadosOtorgamientosNotario = e.list{
                eq ("asignadaPor", springSecurityService.currentUser)
                eq ("asignar", usuarioInstance)
            }
            enviados = enviados + enviadosOtorgamientosNotario
            //solicitudes de revocacion
            def f = RevocacionDePoder.createCriteria()                           
            enviadosRevocacionesNotario = f.list{
                eq ("asignadaPor", springSecurityService.currentUser)
                eq ("asignar", usuarioInstance)
            }
            enviados2 = enviados2 + enviadosRevocacionesNotario
        }        
        enviadosOtorgamientosNotario = enviados
        enviadosRevocacionesNotario = enviados2        
        def enviadosNotarioList = enviadosOtorgamientosNotario + enviadosRevocacionesNotario         
        
        //lista de enviados al solicitante por parte del usuario resolvedor
        //solicitudes de otorgamiento        
        def usuarioSolicitante = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_SOLICITANTE")).collect {it.usuario}
        def enviadosOtorgamientosSolicitante = null
        def enviadosRevocacionesSolicitante = null
        def enviados3 = []
        def enviados4 = []
        usuarioSolicitante.each{
            def usuarioSolicitanteInstance = Usuario.get(it.id as long)            
            def g = OtorgamientoDePoder.createCriteria()
            enviadosOtorgamientosSolicitante = g.list{
                eq ("asignadaPor", springSecurityService.currentUser)
                eq ("asignar", usuarioSolicitanteInstance)
                eq ("ocultadoPorResolvedor", false)
            }
            enviados3 = enviados3 + enviadosOtorgamientosSolicitante
            //solicitudes de revocacion
            def h = RevocacionDePoder.createCriteria()
            enviadosRevocacionesSolicitante = h.list{
                eq ("asignadaPor", springSecurityService.currentUser)
                eq ("asignar", usuarioSolicitanteInstance)
                eq ("ocultadoPorResolvedor", false)
            }
            enviados4 = enviados4 + enviadosRevocacionesSolicitante
        }
        enviadosOtorgamientosSolicitante = enviados3
        enviadosRevocacionesSolicitante = enviados4        
        def enviadosSolicitanteList = enviadosOtorgamientosSolicitante + enviadosRevocacionesSolicitante
        
        //Poderes que están por vencer
        def listaPoderes = OtorgamientoDePoder.list()
        
        def poderCriticoList = []
        def poderSemicriticoList = []        
        def poderNoCritico = []
        listaPoderes.each {poder ->
            if(poder.fechaVencimiento){
                def fechaHoy = new Date()                
                def fechaVencimiento = poder.fechaVencimiento                
                def diasParaVencimiento = fechaVencimiento - fechaHoy                                 
                if(diasParaVencimiento <= parameters.estadoCriticoPoder){
                    poderCriticoList.add(poder)
                }else if(diasParaVencimiento <= parameters.estadoSemiPoder && diasParaVencimiento > parameters.estadoCriticoPoder ){
                    poderSemicriticoList.add(poder)
                }else{
                    poderNoCritico.add(poder)
                }                 
            }            
        }
        def poderesPorVencerList = poderCriticoList + poderSemicriticoList
        
        //prorrogas de otorgamiento de poder        
        def prorrogaList = []      
        listaPoderes.each { poder ->
            if(poder.prorrogas){
                poder.prorrogas.each{prorroga ->
                    if(prorroga.asignadoA == springSecurityService.currentUser && prorroga.ocultado == false){                        
                        prorrogaList.add(prorroga)                        
                    }
                }               
            }                
        }
        //prorrogas de revocacion de poder
        def listaPoderesRevocacion = RevocacionDePoder.list()              
        listaPoderesRevocacion.each{ poder ->
            if(poder.prorrogas){
                poder.prorrogas.each{prorroga ->
                    if(prorroga.asignadoA == springSecurityService.currentUser && prorroga.ocultado == false){                        
                        prorrogaList.add(prorroga)                        
                    }
                }               
            }                
        }        
        prorrogaList.sort{ it.getId() }
        
        //facturas
        def facturaList = Factura.findAllByAsignadoAAndOcultadoPorFacturas(springSecurityService.currentUser, false)  
        //facturas enviadas
        def facturasEnviadasList = Factura.findAllByAsignadoPorAndOcultadoPorResolvedor(springSecurityService.currentUser, false)
        
        render (
            view: "index", 
            model: [
                otorgamientosRojosList : otorgamientosRojosList,
                otorgamientosAmarillosList : otorgamientosAmarillosList,
                otorgamientosVerdesList : otorgamientosVerdesList,
                otorgamientosNoAsignadosList : otorgamientosNoAsignadosList,
                revocacionesRojosList : revocacionesRojosList,
                revocacionesAmarillosList : revocacionesAmarillosList,
                revocacionesVerdesList : revocacionesVerdesList,
                revocacionesNoAsignadosList : revocacionesNoAsignadosList,
                poderInstanceTotal: poderesList.size(),                
                otorgamientoAsignadosInstanceList:asignadosOtorgamiento,
                revocacionAsignadosInstanceList : asignadosRevocacion,
                poderesAsignadosInstanceTotal : poderesAsignadosList.size(),
                otorgamientosEnviadosNotarioInstanceList : enviadosOtorgamientosNotario,
                revocacionesEnviadosNotarioInstanceList : enviadosRevocacionesNotario,
                enviadosNotarioTotal : enviadosNotarioList.size(),                
                otorgamientosEnviadosSolicitanteInstanceList : enviadosOtorgamientosSolicitante,
                revocacionesEnviadosSolicitanteInstanceList : enviadosRevocacionesSolicitante,
                enviadosSolicitanteTotal : enviadosSolicitanteList.size(),
                poderCriticoInstanceList : poderCriticoList,
                poderSemicriticoInstanceList : poderSemicriticoList,
                poderesPorVencerTotal : poderesPorVencerList.size(),
                prorrogaList : prorrogaList,
                prorrogaListTotal : prorrogaList.size(),
                facturaList : facturaList,
                facturaListTotal : facturaList.size(),
                facturasEnviadasList : facturasEnviadasList,
                facturasEnviadasTotal : facturasEnviadasList.size()
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
    /**
     * Método para busquedas por nombre del apoderado.
     */
    def buscarNombreApoderado (){
        def nombreApoderadoActive = null
        if (params.inActive=="nombreApoderado") {
            nombreApoderadoActive = "active"
        }
        def r = OtorgamientoDePoder.createCriteria()
        def otorgamientoDePoderInstanceList = r.list {
            apoderados {
                ilike("nombre", "%"+params.nombre+"%")
            }
            order("id", "asc")
        }        
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
    /**
     * Método para busquedas por delegación.
     */
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
    /**
     * Método para busquedas por fecha de otorgamiento.
     */
    def buscarPorFechaOtorgamiento () {
        def porFechaOtorgamientoActive = null
        if (params.inActive=="porFechaOtorgamiento") {
            porFechaOtorgamientoActive = "active"
        }        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")       
        def rangoDeFechaOtorgamiento = null
        def fechaInicio = null
        def fechaFin = null
        def busquedaBean = null
        def otorgamientoDePoderInstanceList = []
        if (params.rangoDeFechaOtorgamiento != "") {
            flash.warn = null
            rangoDeFechaOtorgamiento = params.rangoDeFechaOtorgamiento
            fechaInicio = sdf.parse(rangoDeFechaOtorgamiento.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFechaOtorgamiento.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            otorgamientoDePoderInstanceList = OtorgamientoDePoder.findAllByFechaDeOtorgamientoBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin, [sort: "id", order: "asc"])
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
                rangoDeFechaOtorgamiento : params.rangoDeFechaOtorgamiento,
                porFechaOtorgamientoActive : porFechaOtorgamientoActive
            ]
        )
    }
    
    /**
     * Método para busquedas por número de escritura pública.
     */
    def buscarPorEscrituraPublica () {
        def porEscrituraPublicaActive = null
        if (params.inActive == "porEscrituraPublica") {
            porEscrituraPublicaActive = "active"
        }
        def otorgamientoDePoderInstanceList = OtorgamientoDePoder.findAllByEscrituraPublicaLike("%"+params.escrituraPublica+"%", [sort: "id", order: "asc"])        
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: otorgamientoDePoderInstanceList.size(),
                porEscrituraPublicaActive : porEscrituraPublicaActive       
            ]
        )       
    }
    
    /**
     * Método para busquedas por palabras clave.
     */
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
    /**
     * Método para busquedas por nombre del apoderado de revocacion.
     */
    def buscarNombreApoderadoRevocacion (){
        def nombreApoderadoActive = null
        if (params.inActive=="nombreApoderado") {
            nombreApoderadoActive = "active"
        }
        def s = RevocacionDePoder.createCriteria()
        def revocacionDePoderInstanceList = s.list {
            apoderados {
                ilike("nombre", "%"+params.nombre+"%")
            }
            order("id", "asc")
        } 
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
    /**
     * Método para busquedas por delegacion de la revocación.
     */
    def buscarPorDelegacionRevocacion (){
        def porDelegacionActive = null
        if (params.inActive=="porDelegacion") {
            porDelegacionActive = "active"
        }        
        //def revocacionDePoderInstanceList = RevocacionDePoder.findAllByDelegacionIlike("%"+params.delegacion+"%", [sort: "id", order: "asc"])
        def g = RevocacionDePoder.createCriteria()
        def revocacionDePoderInstanceList = g.list {
            delegacion {
                ilike("nombre", "%"+params.delegacion+"%")
            }
            order("id", "asc")
        } 
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
    /**
     * Método para busquedas por nombre de escritura pública de revocación.
     */
    def buscarPorNumeroEscrituraRevocacion (){        
        def porNumeroEscrituraActive = null
        if (params.inActive=="porNumeroEscritura") {
            porNumeroEscrituraActive = "active"
        }
        def revocacionDePoderInstanceList = RevocacionDePoder.findAllByEscrituraPublicaRevocacionLike("%"+params.escrituraPublica+"%", [sort: "id", order: "asc"])        
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: revocacionDePoderInstanceList.size(),
                porNumeroEscrituraActive : porNumeroEscrituraActive       
            ]
        )       
    }
    /**
     * Método para busquedas por fecha de revocación.
     */
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
        if (params.rangoDeFechaRevocacion) {
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
    /**
     * Método para busquedas por palabras claves en revocacion de poder.
     */
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
    /**
     * Método para busquedas por nombre en busqueda general.
     */
    def buscarNombreGeneral (){
        def nombreApoderadoActive = null
        if (params.inActive=="nombreApoderado") {
            nombreApoderadoActive = "active"
        }
        def a = OtorgamientoDePoder.createCriteria()
        def otorgamientoDePoderInstanceList = a.list {
            apoderados {
                ilike("nombre", "%"+params.nombre+"%")
            }
            order("id", "asc")
        }
        def b = RevocacionDePoder.createCriteria()
        def revocacionDePoderInstanceList = b.list {
            apoderados {
                ilike("nombre", "%"+params.nombre+"%")
            }
            order("id", "asc")
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
                nombreApoderadoActive : nombreApoderadoActive       
            ]
        )       
    }
    /**
     * Método para busquedas por nombre del solciitante en busqueda general.
     */
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
    /**
     * Método para busquedas por palabras clave de busqueda general.
     */
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
    /**
     * Método para generar reportes en las busquedas.
     */
    def generarReporteOtorgamiento(){
        def otorgamientoDePoderInstanceList = session.otorgamientoDePoderInstanceList
        def inActive = session.inActive
        log.info "activo:." + session.inActive
        log.info "total::." + session.otorgamientoDePoderInstanceList.size()
        log.info "params::::::::::::::::"+ params
        log.info "otorgamiento::::::"+ session.otorgamientoDePoderInstanceList
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=otorgamiento.${params.extension}")
            List fields = ["id", "categoriaDeTipoDePoder.tipoDePoder.nombre", "categoriaDeTipoDePoder.nombre", "solicitadoPor", "apoderados.nombre", "registroDeLaSolicitud", "delegacion"]
            Map labels = ["id":"Número de Folio", "categoriaDeTipoDePoder.tipoDePoder.nombre":"Tipo de Poder", "categoriaDeTipoDePoder.nombre":"Categoria", "solicitadoPor": "Solicitado Por", "apoderados.nombre": "Apoderados", "registroDeLaSolicitud":"Registro De Solicitud",
                          "delegacion":"Delegación"]
            def upperCase = { domain, value ->
                return value.toUpperCase()
            }
            Map formatters = [contrato: upperCase]		
            Map parameters = [title: "Reporte de Otorgamiento de Poder ", "column.widths": [0.2, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4], "title.font.size":12]

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
            List fields = ["id", "apoderadosEliminar.nombre", "solicitadoPor", "escrituraPublica","fechaDeRevocacion"]
            Map labels = ["id": "Número de Folio","apoderadosEliminar.nombre": "Nombre Apoderado", "solicitadoPor": "Solicitado Por","escrituraPublica":"Escritura Pública",
                          "fechaDeRevocacion":"Fecha Revocación"]
            def upperCase = { domain, value ->
                return value.toUpperCase()
            }
            Map formatters = [nombreDeNotario: upperCase]		
            Map parameters = [title: "Reporte de Revocación de Poder ", "column.widths": [0.2, 0.4, 0.4, 0.4, 0.4], "title.font.size":12]

            exportService.export(params.format, response.outputStream, session.revocacionDePoderInstanceList, fields, labels, formatters, parameters)
        }
        render(
            view: "list", 
            model: [inActive: inActive, revocacionDePoderInstanceList: revocacionDePoderInstanceList ]
        )
        
    }
    def bitacoraList(Integer max){
        
        params.max = Math.min(max ?: 10, 100)
        
        [
            otorgamientoDePoderInstanceList: OtorgamientoDePoder.list(params),
            otorgamientoDePoderInstanceTotal: OtorgamientoDePoder.count(),
            revocacionDePoderInstanceList: RevocacionDePoder.list(params),
            revocacionDePoderInstanceTotal: RevocacionDePoder.count()
        ]                
    }
    
}
