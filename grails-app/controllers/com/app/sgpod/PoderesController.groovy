package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat
import com.pogos.BusquedaBean
import com.pogos.ResultadoBusquedaApoderado
import com.pogos.ResultadosReporteOtorgamiento
import grails.plugins.springsecurity.Secured
import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol
import com.app.sgcon.Persona

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
        def solicitantes1 = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_SOLICITANTE")).collect {it.usuario}
        def solicitantes2 = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_SOLICITANTE_EXTERNO")).collect {it.usuario}
        def solicitantes3 = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_GESTOR_EXTERNO")).collect {it.usuario}
        def solicitantes0 = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_SOLICITANTE_ESPECIAL")).collect {it.usuario}
        def usuarioSolicitante = solicitantes1 + solicitantes2 + solicitantes3 + solicitantes0
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
        
        
        def fechaDeEstadoCritico = new Date() + parameters.estadoCriticoPoder
        def fechaSemicritico = new Date() + parameters.estadoSemiPoder
           
        def results = OtorgamientoDePoder.where {
            (fechaVencimiento <= fechaDeEstadoCritico)
        }
        def poderCriticoList = results.list()        
        
        def results2 = OtorgamientoDePoder.where {
            (fechaVencimiento <= fechaSemicritico && fechaVencimiento >= fechaDeEstadoCritico)
        }
        def poderSemicriticoList = results2.list()
                                                
        def poderesPorVencerTotal = poderCriticoList.size() + poderSemicriticoList.size()
                                     
        //prorrogas de otorgamiento de poder        
        def prorrogaListPrincipal = Prorroga.list()
        def prorrogaList = []
        def listaPoderesRevocacion = []        
        
        prorrogaListPrincipal.each { prorroga ->
            if(prorroga.class == 'com.app.sgpod.otorgamientoDePoder' && prorroga.asignadoA == springSecurityService.currentUser && prorroga.ocultado == false){
                prorrogaList.add(prorroga)
            }else if(prorroga.class == 'com.app.sgpod.revocacionDePoder' && prorroga.asignadoA == springSecurityService.currentUser && prorroga.ocultado == false){
                listaPoderesRevocacion.add(prorroga)
            }              
        }                            
        prorrogaList?.sort{ it.getId() }
        
        //facturas
        def facturaList = Factura.findAllByAsignadoAAndOcultadoPorFacturas(springSecurityService.currentUser, false)  
        //facturas enviadas
        def facturasEnviadasList = Factura.findAllByAsignadoPorAndOcultadoPorResolvedor(springSecurityService.currentUser, false)
                
        def usuarioFacturas = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_FACTURAS")).collect {it.usuario}
        def isFacturas = false
        usuarioFacturas.each { usuarioFac ->
            if(usuarioFac == springSecurityService.currentUser){
                isFacturas = true                
            }            
        }  
        def usuarioEnlace = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_ENLACE")).collect {it.usuario}
        def isEnlace = false
        usuarioEnlace.each { usuarioEnl ->
            if(usuarioEnl == springSecurityService.currentUser){
                isEnlace = true                
            }          
        }  
        
        //bandera para saber si es una solicitud de solicitante_externo 
        def usuarioExterno = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_SOLICITANTE_EXTERNO")).collect {it.usuario}
        def solicitudExterno = null
        usuarioExterno.each { usuarioFac ->
            if(usuarioFac == springSecurityService.currentUser){
                solicitudExterno = true                
            }else{
                solicitudExterno = false                
            }            
        }    
        
        //lista de proyectos
        def proyectosList = DocumentoDeProyecto.findAllByAsignadoAOrAsignadoPor(springSecurityService.currentUser,springSecurityService.currentUser)  
        println "proyectosList: " + proyectosList
        
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
                poderesPorVencerTotal : poderesPorVencerTotal,
                prorrogaList : prorrogaList,
                prorrogaListTotal : prorrogaList.size(),
                facturaList : facturaList,
                facturaListTotal : facturaList.size(),
                facturasEnviadasList : facturasEnviadasList,
                facturasEnviadasTotal : facturasEnviadasList.size(),
                proyectosList : proyectosList,
                proyectosTotal : proyectosList.size(),
                isFacturas : isFacturas,
                isEnlace : isEnlace,
                solicitudExterno : solicitudExterno
            ]
        )
    }
    
    def otorgamientoConsulta() {
        
        def notarios = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_NOTARIO")).collect {it.usuario} 
        session.notarios = notarios             
        [nombreApoderadoActive:"active", notarios : notarios] 
    }
    
    def revocacionConsulta() {
        def notarios = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_NOTARIO")).collect {it.usuario} 
        session.notarios = notarios   
        [nombreApoderadoActive:"active", notarios : notarios] 
    }
    
    def busquedaGeneral() {
        
        [nombreApoderadoActive:"active"] 
    }
    
     
    def menuConsulta() { 
    
    }
    /**
     * Método para busquedas por nombre del apoderado.
     * en otorgamiento de poder
     */
    def buscarNombreApoderado (){        
        def nombreApoderadoActive = null
        if (params.inActive=="nombreApoderado") {
            nombreApoderadoActive = "active"
        }
        def r = OtorgamientoDePoder.createCriteria()
        def resultados = r.list {
            apoderados {
                ilike("nombre", "%"+params.nombre+"%")                
            }
            order("id", "asc")
        }          
        resultados.unique()
        def otorgamientoDePoderInstanceList = [] 
        def countApoderadosTotal = 0
        def poderesParaReporteList = []
        resultados.each{it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id            
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublica  
            nuevoPoder.fechaDeOtorgamiento = it.fechaDeOtorgamiento                         
            def listOk = []
            def listKo = []  
            //countApoderadosTotal = countApoderadosTotal + 1
            it.apoderados.each{apoderado ->
                if(apoderado.nombre.contains(params.nombre.toUpperCase())){                     
                    listOk.add(apoderado)
                    countApoderadosTotal = countApoderadosTotal + 1
                }else{                           
                    listKo.add(apoderado)
                } 
            }     
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk            
            nuevoPoder.totalApoderados = it.apoderados.size() -1
            otorgamientoDePoderInstanceList.add(nuevoPoder)             
        }  
        //se crea la lista para generar el reporte
        otorgamientoDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-O"
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                
                nuevoPoderReporte.fechaDeOtorgamiento = it.fechaDeOtorgamiento
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList        
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: countApoderadosTotal,
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
        def resultados = c.list {
            delegacion {
                like("nombre", "%"+params.nombre+"%")
            }
            order("id", "asc")
        }
        
        resultados.unique()
        def otorgamientoDePoderInstanceList = []   
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublica  
            nuevoPoder.fechaDeOtorgamiento = it.fechaDeOtorgamiento
            def listOk = []
            it.apoderados.each {apoderado ->
                listOk.add(apoderado)
                countApoderadosTotal = countApoderadosTotal + 1
            }   
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderados.size() -1
            otorgamientoDePoderInstanceList.add(nuevoPoder)                             
        }                       
        //se crea la lista para generar el reporte
        otorgamientoDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-O"                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                               
                nuevoPoderReporte.fechaDeOtorgamiento = it.fechaDeOtorgamiento
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: countApoderadosTotal,
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
        def resultados = []
        if (params.rangoDeFechaOtorgamiento != "") {
            flash.warn = null
            rangoDeFechaOtorgamiento = params.rangoDeFechaOtorgamiento
            fechaInicio = sdf.parse(rangoDeFechaOtorgamiento.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFechaOtorgamiento.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            resultados = OtorgamientoDePoder.findAllByFechaDeOtorgamientoBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        
        resultados.unique()
        def otorgamientoDePoderInstanceList = [] 
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublica  
            nuevoPoder.fechaDeOtorgamiento = it.fechaDeOtorgamiento               
            def listOk = []
            it.apoderados.each {apoderado ->
                listOk.add(apoderado)
                countApoderadosTotal = countApoderadosTotal + 1
            }   
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderados.size() -1
            otorgamientoDePoderInstanceList.add(nuevoPoder)   
        }     
        //se crea la lista para generar el reporte
        otorgamientoDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-O"                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                                
                nuevoPoderReporte.fechaDeOtorgamiento = it.fechaDeOtorgamiento
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: countApoderadosTotal,
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
        def resultados = OtorgamientoDePoder.findAllByEscrituraPublicaLike("%"+params.escrituraPublica+"%", [sort: "id", order: "asc"])        
        resultados.unique()
        def otorgamientoDePoderInstanceList = [] 
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublica  
            nuevoPoder.fechaDeOtorgamiento = it.fechaDeOtorgamiento               
            def listOk = []
            it.apoderados.each {apoderado ->
                listOk.add(apoderado)
                countApoderadosTotal = countApoderadosTotal + 1
            }   
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderados.size() -1
            otorgamientoDePoderInstanceList.add(nuevoPoder)   
        } 
        //se crea la lista para generar el reporte
        otorgamientoDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-O"                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                                
                nuevoPoderReporte.fechaDeOtorgamiento = it.fechaDeOtorgamiento
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: countApoderadosTotal,
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
        /*def s = params.tags.toString().replaceAll(" ", "")
        def resultList = s.tokenize(",")
        def otorgamientoDePoderInstanceList =[] 
        resultList.each{            
        def results = OtorgamientoDePoder.findAllByTagsIlike("%"+it+"@%", [sort: "id", order: "asc"])
        otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList + results as Set    
        }*/
        def resultados = OtorgamientoDePoder.findAllByTagsIlike("%"+params.tags+"%", [sort: "id", order: "asc"])
        resultados.unique()
        def otorgamientoDePoderInstanceList = [] 
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublica  
            nuevoPoder.fechaDeOtorgamiento = it.fechaDeOtorgamiento    
            
            def listOk = []
            it.apoderados.each {apoderado ->
                listOk.add(apoderado)
                countApoderadosTotal = countApoderadosTotal + 1
            }   
            
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderados.size() -1
            otorgamientoDePoderInstanceList.add(nuevoPoder)   
        } 
        //se crea la lista para generar el reporte
        otorgamientoDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-O"                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                                
                nuevoPoderReporte.fechaDeOtorgamiento = it.fechaDeOtorgamiento
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: countApoderadosTotal,
                porTagsActive : porTagsActive       
            ]
        )       
    }
    /**
     * Método para busquedas por notario para otorgamientos de poder.
     */
    def buscarPorNotario (){        
        def porNotarioActive = null
        if (params.inActive=="porNotario") {
            porNotarioActive = "active"
        }        
        def notarioInstance = Usuario.get(params.id)               
        def resultados = OtorgamientoDePoder.findAll {
            notarioCorrespondiente == notarioInstance
        }        
        resultados.unique()
        def otorgamientoDePoderInstanceList = []   
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublica  
            nuevoPoder.fechaDeOtorgamiento = it.fechaDeOtorgamiento
            def listOk = []
            it.apoderados.each {apoderado ->
                listOk.add(apoderado)
                countApoderadosTotal = countApoderadosTotal + 1
            }   
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderados.size() -1
            otorgamientoDePoderInstanceList.add(nuevoPoder)                             
        }      
        //se crea la lista para generar el reporte
        otorgamientoDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-O"                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                               
                nuevoPoderReporte.fechaDeOtorgamiento = it.fechaDeOtorgamiento
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: countApoderadosTotal,
                porNotarioActive : porNotarioActive,
                nombreNotario : notarioInstance
            ]
        )       
    }
    /**
     * Método de busqueda por status del otorgamiento
     */
    def buscarPorStatus(){        
        def porStatusActive = null
        if (params.inActive=="porStatus") {
            porStatusActive = "active"
        }                    
        def resultados = OtorgamientoDePoder.where{
            apoderados { statusDePoder == params.statusDePoder}
        }                                
        
        def otorgamientoDePoderInstanceList = []   
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublica  
            nuevoPoder.fechaDeOtorgamiento = it.fechaDeOtorgamiento
            def listOk = []
            it.apoderados.each {apoderado ->                                
                if(apoderado.statusDePoder == params.statusDePoder){
                    countApoderadosTotal = countApoderadosTotal + 1
                    listOk.add(apoderado)
                }
            }   
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderados.size() -1
            otorgamientoDePoderInstanceList.add(nuevoPoder)                             
        } 
        
        //se crea la lista para generar el reporte
        otorgamientoDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-O"                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                                
                nuevoPoderReporte.fechaDeOtorgamiento = it.fechaDeOtorgamiento
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }              
        }
         
        session.poderesParaReporteList = poderesParaReporteList
        session.otorgamientoDePoderInstanceList = otorgamientoDePoderInstanceList
        
        
        render(
            view: "otorgamientoConsulta", 
            model: [
                
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: countApoderadosTotal,
                porStatusActive : porStatusActive
            ]
        )                
    }
    /**
     * Método para busquedas por notario para otorgamientos de poder.
     */
    def registrosTotales(){        
        def registrosTotalesActive = null
        if (params.inActive=="registrosTotales") {
            registrosTotalesActive = "active"
        }        
        //def notarioInstance = Usuario.get(params.id)               
        def resultados = OtorgamientoDePoder.list()    
        resultados.unique()
        resultados.sort{it.id}
        def otorgamientoDePoderInstanceList = []   
        def poderesParaReporteList = []
        def countRegistrosTotales = 0            
        //se crea la lista para generar el reporte
        resultados.each{it ->           
            it.apoderados.sort{it.nombre}each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-O"                
                nuevoPoderReporte.apoderado = poderInstance.nombre                              
                nuevoPoderReporte.fechaDeOtorgamiento = it.fechaDeOtorgamiento
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
                countRegistrosTotales = countRegistrosTotales +1
            }            
        }        
        session.poderesParaReporteList = poderesParaReporteList        
        render(
            view: "otorgamientoConsulta", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                otorgamientoDePoderInstanceTotal: countRegistrosTotales,
                registrosTotalesActive : registrosTotalesActive
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
        def resultados = s.list {
            apoderadosEliminar {
                ilike("nombre", "%"+params.nombre+"%")
            }
            order("id", "asc")
        } 
        println "total antes del unique: " + resultados.size()
        resultados.unique()
        println "total despues del unique: " + resultados.size()
        def revocacionDePoderInstanceList = [] 
        def countApoderadosTotal = 0
        def poderesParaReporteList = []
        resultados.each{it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id            
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublicaRevocacion  
            nuevoPoder.fechaDeRevocacion = it.fechaDeRevocacion                         
            def listOk = []
            def listKo = []  
            //countApoderadosTotal = countApoderadosTotal + 1
            it.apoderadosEliminar.each{apoderado ->
                if(apoderado.nombre.contains(params.nombre.toUpperCase())){                     
                    listOk.add(apoderado)
                    countApoderadosTotal = countApoderadosTotal + 1                    
                }else{                           
                    listKo.add(apoderado)
                } 
            }           
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk            
            nuevoPoder.totalApoderados = it.apoderadosEliminar.size() -1
            revocacionDePoderInstanceList.add(nuevoPoder)             
        }            
        //se crea la lista para generar el reporte
        revocacionDePoderInstanceList.each{it ->               
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-R"
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                                
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
                                     
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList : revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal : poderesParaReporteList.size(),
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
        def resultados = g.list {
            delegacion {
                like("nombre", "%"+params.nombre+"%")
            }
            order("id", "asc")
        }
        resultados.unique()
        def revocacionDePoderInstanceList = []   
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublicaRevocacion  
            nuevoPoder.fechaDeRevocacion = it.fechaDeRevocacion
            def listOk = []
            it.apoderadosEliminar.each {apoderado ->
                listOk.add(apoderado)
                countApoderadosTotal = countApoderadosTotal + 1
            }   
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderadosEliminar.size() -1
            revocacionDePoderInstanceList.add(nuevoPoder)                             
        }                       
        //se crea la lista para generar el reporte
        revocacionDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-R"                                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                 
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: poderesParaReporteList.size(),
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
        def resultados = RevocacionDePoder.findAllByEscrituraPublicaRevocacionLike("%"+params.escrituraPublica+"%", [sort: "id", order: "asc"])        
        resultados.unique()
        def revocacionDePoderInstanceList = [] 
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublicaRevocacion  
            nuevoPoder.fechaDeRevocacion = it.fechaDeRevocacion           
            def listOk = []
            it.apoderadosEliminar.each {apoderado ->
                listOk.add(apoderado)
                countApoderadosTotal = countApoderadosTotal + 1
            }   
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderadosEliminar.size() -1
            revocacionDePoderInstanceList.add(nuevoPoder)   
        } 
        //se crea la lista para generar el reporte
        revocacionDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-R"                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                                            
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: poderesParaReporteList.size(),
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
        def resultados = []
        if (params.rangoDeFechaRevocacion) {
            flash.warn = null
            rangoDeFechaRevocacion = params.rangoDeFechaRevocacion
            fechaInicio = sdf.parse(rangoDeFechaRevocacion.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFechaRevocacion.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            resultados = RevocacionDePoder.findAllByFechaDeRevocacionBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        resultados.unique() 
        def revocacionDePoderInstanceList = []
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublicaRevocacion  
            nuevoPoder.fechaDeRevocacion = it.fechaDeRevocacion           
            def listOk = []
            it.apoderadosEliminar.each {apoderado ->
                listOk.add(apoderado)
                countApoderadosTotal = countApoderadosTotal + 1
            }   
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderadosEliminar.size() -1
            revocacionDePoderInstanceList.add(nuevoPoder)   
        } 
        //se crea la lista para generar el reporte
        revocacionDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-R"                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                                            
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: poderesParaReporteList.size(),
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
        /*def s = params.tags.toString().replaceAll(" ", "")
        def resultList = s.tokenize(",")
        def revocacionDePoderInstanceList =[] 
        resultList.each{            
        def results = RevocacionDePoder.findAllByTagsIlike("%"+it+"@%", [sort: "id", order: "asc"])
        revocacionDePoderInstanceList = revocacionDePoderInstanceList + results as Set    
        }*/
        def resultados = RevocacionDePoder.findAllByTagsIlike("%"+params.tags+"%", [sort: "id", order: "asc"])
        resultados.unique()
        def revocacionDePoderInstanceList = [] 
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublicaRevocacion  
            nuevoPoder.fechaDeRevocacion = it.fechaDeRevocacion           
            def listOk = []
            it.apoderadosEliminar.each {apoderado ->
                listOk.add(apoderado)
                countApoderadosTotal = countApoderadosTotal + 1
            }   
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderadosEliminar.size() -1
            revocacionDePoderInstanceList.add(nuevoPoder)   
        } 
        //se crea la lista para generar el reporte
        revocacionDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-R"                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                                            
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: poderesParaReporteList.size(),
                porTagsActive : porTagsActive       
            ]
        )       
    }
    
    def buscarPorNotarioRevocacion (){        
        def porNotarioActive = null
        if (params.inActive=="porNotario") {
            porNotarioActive = "active"
        }        
        def notarioInstance = Usuario.get(params.id)               
        def resultados = RevocacionDePoder.findAll {
            notarioCorrespondiente == notarioInstance
        }        
        resultados.unique()
        def revocacionDePoderInstanceList = []   
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublicaRevocacion  
            nuevoPoder.fechaDeRevocacion = it.fechaDeRevocacion
            def listOk = []
            it.apoderadosEliminar.each {apoderado ->
                listOk.add(apoderado)
                countApoderadosTotal = countApoderadosTotal + 1
            }   
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderadosEliminar.size() -1
            revocacionDePoderInstanceList.add(nuevoPoder)                             
        }      
        //se crea la lista para generar el reporte
        revocacionDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-R"                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                               
                nuevoPoderReporte.fechaDeRevocacion = it.fechaDeRevocacion
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }            
        }
        session.poderesParaReporteList = poderesParaReporteList
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: countApoderadosTotal,
                porNotarioActive : porNotarioActive,
                nombreNotario : notarioInstance
            ]
        )       
    }
    
    /**
     * Método de busqueda por status del otorgamiento
     */
    def buscarPorStatusRevocacion(){        
        def porStatusActive = null
        if (params.inActive=="porStatus") {
            porStatusActive = "active"
        }                    
        def resultados = RevocacionDePoder.where{
            apoderados { statusDePoder == params.statusDePoder}
        }                                
        
        def revocacionDePoderInstanceList = []   
        def poderesParaReporteList = []
        def countApoderadosTotal = 0
        resultados.each{ it ->
            def nuevoPoder = new ResultadoBusquedaApoderado()
            nuevoPoder.id = it.id
            nuevoPoder.registroDeLaSolicitud = it.registroDeLaSolicitud            
            nuevoPoder.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
            nuevoPoder.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
            nuevoPoder.delegacion = it.delegacion
            nuevoPoder.escrituraPublica = it.escrituraPublicaRevocacion  
            nuevoPoder.fechaDeRevocacion = it.fechaDeRevocacion
            def listOk = []
            it.apoderadosEliminar.each {apoderado ->                                
                if(apoderado.statusDePoder == params.statusDePoder){
                    countApoderadosTotal = countApoderadosTotal + 1
                    listOk.add(apoderado)
                }
            }   
            listOk.sort{it.nombre}  
            nuevoPoder.apoderados = listOk  
            nuevoPoder.totalApoderados = it.apoderadosEliminar.size() -1
            revocacionDePoderInstanceList.add(nuevoPoder)                             
        } 
        
        //se crea la lista para generar el reporte
        revocacionDePoderInstanceList.each{it ->           
            it.apoderados.each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-R"                
                if(it.totalApoderados > 0){
                    nuevoPoderReporte.apoderado = poderInstance.nombre + " y " +it.totalApoderados + " más."
                }else{
                    nuevoPoderReporte.apoderado = poderInstance.nombre
                }                                
                nuevoPoderReporte.fechaDeRevocacion = it.fechaDeRevocacion
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.tipoDePoder
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublica
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
            }              
        }
         
        session.poderesParaReporteList = poderesParaReporteList
        session.revocacionDePoderInstanceList = revocacionDePoderInstanceList
        
        
        render(
            view: "revocacionConsulta", 
            model: [
                
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: countApoderadosTotal,
                porStatusActive : porStatusActive
            ]
        )                
    }
    
    def registrosTotalesRevocacion(){        
        def registrosTotalesActive = null
        if (params.inActive=="registrosTotales") {
            registrosTotalesActive = "active"
        }        
        //def notarioInstance = Usuario.get(params.id)               
        def resultados = RevocacionDePoder.list()    
        resultados.unique()
        resultados.sort{it.id}
        def revocacionDePoderInstanceList = []   
        def poderesParaReporteList = []
        def countRegistrosTotales = 0            
        //se crea la lista para generar el reporte
        resultados.each{it ->           
            it.apoderadosEliminar.sort{it.nombre}each{poderInstance ->                
                def nuevoPoderReporte = new ResultadosReporteOtorgamiento()
                nuevoPoderReporte.id = it.id + "-R"                
                nuevoPoderReporte.apoderado = poderInstance.nombre                              
                nuevoPoderReporte.fechaDeRevocacion = it.fechaDeRevocacion
                nuevoPoderReporte.registroDeLaSolicitud = it.registroDeLaSolicitud
                nuevoPoderReporte.tipoDePoder = it.categoriaDeTipoDePoder.tipoDePoder.nombre
                nuevoPoderReporte.categoriaDeTipoDePoder = it.categoriaDeTipoDePoder.nombre
                nuevoPoderReporte.delegacion = it.delegacion
                nuevoPoderReporte.escrituraPublica = it.escrituraPublicaRevocacion
                nuevoPoderReporte.statusDePoderApoderado = poderInstance.statusDePoder
                poderesParaReporteList.add(nuevoPoderReporte)
                countRegistrosTotales = countRegistrosTotales +1
            }            
        }        
        session.poderesParaReporteList = poderesParaReporteList        
        render(
            view: "revocacionConsulta", 
            model: [
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,
                revocacionDePoderInstanceTotal: countRegistrosTotales,
                registrosTotalesActive : registrosTotalesActive
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
        def revocacionDePoderInstanceList = RevocacionDePoder.findAllByCreadaPorIlike("%"+params.solicitadoPor+"%", [sort: "id", order: "asc"])
        def otorgamientoDePoderInstanceList = OtorgamientoDePoder.findAllByCreadaPorIlike("%"+params.solicitadoPor+"%", [sort: "id", order: "asc"])
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
        /*def s = params.tags.toString().replaceAll(" ", "")
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
        }*/
        def otorgamientoDePoderInstanceList = OtorgamientoDePoder.findAllByTagsIlike("%"+params.tags+"%", [sort: "id", order: "asc"])
        def revocacionDePoderInstanceList = RevocacionDePoder.findAllByTagsIlike("%"+params.tags+"%", [sort: "id", order: "asc"])
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
        def otorgamientoDePoderInstanceList = session.poderesParaReporteList        
        def inActive = session.inActive
        log.info "activo:." + session.inActive
        //log.info "total::." + otorgamientoDePoderInstanceList.size()
        log.info "params::::::::::::::::"+ params
        log.info "otorgamiento::::::"+ session.otorgamientoDePoderInstanceList
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=Reporte de Otorgamiento(s) de poder(es).${params.extension}")
            List fields = ["id", "apoderado",  "escrituraPublica", "registroDeLaSolicitud", "tipoDePoder",
                             "categoriaDeTipoDePoder", "delegacion", "statusDePoderApoderado"]
            Map labels = ["id":"Folio", "apoderado":"Nombre del Apoderado", "escrituraPublica":"Escritura Pública",
                            "registroDeLaSolicitud":"Fecha de Registro", 
                            "tipoDePoder":"Tipo de Poder", "categoriaDeTipoDePoder":"Categoria", 
                          "delegacion":"Delegación", "statusDePoderApoderado":"Estatus"]
            def upperCase = { domain, value ->
                return value.toUpperCase()
            }
            Map formatters = [contrato: upperCase]		
            Map parameters = [title: "Reporte de Otorgamiento de Poder ", "column.widths": [0.2, 0.5, 0.3, 0.4, 0.4, 0.6, 0.4,0.4], "title.font.size":12]

            exportService.export(params.format, response.outputStream, session.poderesParaReporteList, fields, labels, formatters, parameters)
        }
        render(
            view: "list", 
            model: [inActive: inActive, otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList ]
        )
        
    }
    
    def generarReporteRevocacion(){
        def revocacionDePoderInstanceList = session.poderesParaReporteList 
        def inActive = session.inActive
        log.info "activo:." + session.inActive
        log.info "total::." + session.revocacionDePoderInstanceList.size()
        log.info "params::::::::::::::::"+ params
        log.info "convenioinstance::::::"+ session.revocacionDePoderInstanceList
        if(params?.format && params.format != "html"){
            response.contentType = grailsApplication.config.grails.mime.types[params.format]
            response.setHeader("Content-disposition", "attachment; filename=Reporte de revocacion(es) de poder(es).${params.extension}")
            List fields = ["id", "apoderado",  "escrituraPublica", "registroDeLaSolicitud", "tipoDePoder",
                             "categoriaDeTipoDePoder", "delegacion", "statusDePoderApoderado"]
            Map labels = ["id":"Folio", "apoderado":"Nombre del Apoderado", "escrituraPublica":"Escritura Pública",
                            "registroDeLaSolicitud":"Fecha de Registro", 
                            "tipoDePoder":"Tipo de Poder", "categoriaDeTipoDePoder":"Categoria", 
                          "delegacion":"Delegación", "statusDePoderApoderado":"Estatus"]
            def upperCase = { domain, value ->
                return value.toUpperCase()
            }
            Map formatters = [nombreDeNotario: upperCase]		
            Map parameters = [title: "Reporte de Revocación de Poder ", "column.widths": [0.2, 0.5, 0.3, 0.4, 0.4, 0.6, 0.4,0.4], "title.font.size":12]

            exportService.export(params.format, response.outputStream, session.poderesParaReporteList, fields, labels, formatters, parameters)
        }
        render(
            view: "list", 
            model: [inActive: inActive, revocacionDePoderInstanceList: revocacionDePoderInstanceList ]
        )
        
    }
    def bitacoraList(Integer max){
        
        params.max = Math.min(max ?: 10, 100)
        
        []                
    }
    def rangoDeFechaBitacora () {        
              
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")       
        def rangoDeFechaBitacora = null
        def fechaInicio = null
        def fechaFin = null
        def busquedaBean = null
        def otorgamientoDePoderInstanceList = []
        def revocacionDePoderInstanceList = []
        if (params.rangoDeFechaBitacora) {
            flash.warn = null
            rangoDeFechaBitacora = params.rangoDeFechaBitacora
            fechaInicio = sdf.parse(rangoDeFechaBitacora.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFechaBitacora.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            otorgamientoDePoderInstanceList = OtorgamientoDePoder.findAllByRegistroDeLaSolicitudBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin, [sort: "id", order: "asc"])
            revocacionDePoderInstanceList = RevocacionDePoder.findAllByRegistroDeLaSolicitudBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin, [sort: "id", order: "asc"])           
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        } 
        if(!otorgamientoDePoderInstanceList && !revocacionDePoderInstanceList){
            flash.warn = "No se encontraron coincidencias."
        }
        render(
            view: "bitacoraList", 
            model: [
                otorgamientoDePoderInstanceList: otorgamientoDePoderInstanceList,
                revocacionDePoderInstanceList: revocacionDePoderInstanceList,                
                busquedaBean : busquedaBean,
                rangoDeFechaBitacora : params.rangoDeFechaBitacora                
            ]
        )
    }
    def downloadArchivo () {
                       
        if(params.id){
            def poderId = params.id
            def poderInstance = Poder.get(poderId as long)
            response.setHeader("Content-Disposition", "attachment;filename=\"" + poderInstance.nombreDatosUsuarioExterno + "\"");
            byte[] datosUsuarioExterno = poderInstance.datosUsuarioExterno
            response.outputStream << datosUsuarioExterno
        }else{
        
            def poderInstance = Poder.get(params.poderId as long)
            response.setHeader("Content-Disposition", "attachment;filename=\"" + poderInstance.nombreDatosUsuarioExterno + "\"");
            byte[] datosUsuarioExterno = poderInstance.datosUsuarioExterno
            response.outputStream << datosUsuarioExterno
        }  
    }    
    
    def editarNotario (){        
        def notarios = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_NOTARIO")).collect {it.usuario}                
        [ notarios : notarios ]
    }
    def editarSolicitanteExterno (){        
        def solicitantesExternos = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_SOLICITANTE_EXTERNO")).collect {it.usuario}         
        [ solicitantesExternos : solicitantesExternos ]
    }
}
