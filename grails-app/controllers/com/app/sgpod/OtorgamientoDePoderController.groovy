package com.app.sgpod

import java.text.SimpleDateFormat
import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol
import groovy.time.TimeCategory

@Secured(['IS_AUTHENTICATED_FULLY'])
class OtorgamientoDePoderController {
    
    def springSecurityService
    def bitacoraService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    /**
     * Método apara enlistar los registros existentes en una domain class 
     */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [otorgamientoDePoderInstanceList: OtorgamientoDePoder.list(params), otorgamientoDePoderInstanceTotal: OtorgamientoDePoder.count()]
    }
    /**
     * Este método sirve para la creacion de un registro de tipo otorgamiento de poder.
     */
    def create() {
        
        params.registroDeLaSolicitud = new Date()
        
        def userActual = springSecurityService.currentUser
        List<Rol> currentUserRoles = UsuarioRol.findByUsuario(userActual).collect { it.rol } as List        
        
        def userExterno = null
        def listTipoDePoder = null
        if(currentUserRoles.authority.contains("ROLE_SOLICITANTE_EXTERNO")) {
            
            //listTipoDePoder =TipoDePoder.list() 
            listTipoDePoder = TipoDePoder.findAllByNombre("EXTERNO",[max: 1, sort: "nombre", order: "desc"])
            params.userExterno = true
        }else{
            listTipoDePoder =TipoDePoder.list() 
            params.userExterno = false
        }                
                
        [otorgamientoDePoderInstance: new OtorgamientoDePoder(params), listTipoDePoder : listTipoDePoder ]
    }
    /**
     * Método para guardar los registros en el sistema.
     */

    def save() {                
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        
        //se agrega el que creó el otorgamiento en la bd
        params.creadaPor = springSecurityService.currentUser
        
        //se agrega el reponsable para envio de notificaciones        
        def usuarioResolvedorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
        usuarioResolvedorPoderes.each{
            params.responsable = Usuario.get(it.id as long)   
        } 
        //se agrega el usuario gestor en la solicitud         
        def usuarioGestorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_GESTOR")).collect {it.usuario}        
        usuarioGestorPoderes.each{
            params.usuarioGestor = Usuario.get(it.id as long)   
        }        
           
        
        if (params.registroDeLaSolicitud) {
            Date registroDeLaSolicitud = sdf.parse(params.registroDeLaSolicitud)
            params.registroDeLaSolicitud = registroDeLaSolicitud
        }
        if (params.fechaDeOtorgamiento) {
            Date fechaDeOtorgamiento = sdf.parse(params.fechaDeOtorgamiento)
            params.fechaDeOtorgamiento = fechaDeOtorgamiento
        }
        
        if(params.documentoPoderEspecial){
            if (params.documentoPoderEspecial.getSize()!=0) {                            
                params.nombreDocumentoPoderEspecial = params.documentoPoderEspecial.getOriginalFilename()                   
            }
        }
        
        //Se cambian las comas por arrobas
        if(params.tags && !params.tags.endsWith(",")){
            params.tags = params.tags + "@"
        }
        params.tags = params.tags.replaceAll(",", "@") 
        
        def otorgamientoDePoderInstance = new OtorgamientoDePoder(params)
        if (!otorgamientoDePoderInstance.save(flush: true)) {
            render(view: "create", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
            return
        }
        //se guardan datos en la bitacora
        bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se creó la Solicitud de Otorgamiento de Poder")        
                              
        flash.message = message(code: 'default.created.message', args: [message(code: 'poder.label', default: 'Poder'), otorgamientoDePoderInstance.id])
        redirect(action: "edit", id: otorgamientoDePoderInstance.id)
    }
    /**
     * Método para visualizar el registro creado en el sistema.
     */
    def show(Long id) {       
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        
        def otorgamientoDePoderInstance = OtorgamientoDePoder.read(id)        
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }
        if (otorgamientoDePoderInstance.tags){
            otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.replaceAll("@",",")
            if(otorgamientoDePoderInstance.tags && otorgamientoDePoderInstance.tags.endsWith(",")){
                otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.substring(0,otorgamientoDePoderInstance.tags.length()-1)
            }
        }
        //parametro para ocultar botones
        def ocultarBoton = false
        if(otorgamientoDePoderInstance.asignar != springSecurityService.currentUser){
            ocultarBoton = true
        }
        //banderas para saber si ya fueron vistos los documentos por el usuario solicitante
        if(otorgamientoDePoderInstance.creadaPor == springSecurityService.currentUser && otorgamientoDePoderInstance.documentos){
            otorgamientoDePoderInstance.voBoCopiaElectronica = true
            otorgamientoDePoderInstance.save()
            //se guardan datos en la bitacora
            bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "El Usuario Solicitante recibió la copia Electrónica")
        }
        if(otorgamientoDePoderInstance.creadaPor == springSecurityService.currentUser && otorgamientoDePoderInstance.notas){
            otorgamientoDePoderInstance.voBoDocumentoFisico = true
            otorgamientoDePoderInstance.save()
            //se guardan datos en la bitacora
            bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "El Usuario Solicitante recibió la Notificación de envío Documento Físico")
        }
        
        //valor de prorrogas
        def diasDeProrroga = null
        def diasDeProrrogaTotal = 0
        def diasRestantes = null
        def fechaHoy = new Date()
        if(otorgamientoDePoderInstance.prorrogas){            
            
            def prorrogasList = otorgamientoDePoderInstance.prorrogas.sort{ it.getId() }                                                    
            def prorrogaFirst = prorrogasList.get(0)
            def prorrogaLast = prorrogasList.last()                        
            def inicioProrroga = prorrogaFirst.fechaDeEnvio                     
            def fechaDeTerminoProrroga = prorrogaLast.fechaProrroga                   
            def hoy = new Date()
            diasRestantes = fechaDeTerminoProrroga - hoy                        
        }
         
        //usuarios para la reasignacion de solicitudes
        def usuarioResolvedorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}   
        def usuarioNotarioPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_NOTARIO")).collect {it.usuario}
        def usuariosReasignacion = usuarioResolvedorPoderes + usuarioNotarioPoderes
        def usuarioInstance = springSecurityService.currentUser
        usuariosReasignacion.remove(usuarioInstance)
        usuariosReasignacion.each{            
            if(it.accountLocked == true){
                usuariosReasignacion = usuariosReasignacion - it
            }
        }
        def cartaDeInstruccion = CartaDeInstruccionDeOtorgamiento.findByOtorgamientoDePoder(otorgamientoDePoderInstance)
        
        //bandera para saber si es una solicitud de solicitante_externo         
        def solicitudExterno = null
        def solicitanteInterno = null
        def solicitanteUSS = null
        def userSolicitante = otorgamientoDePoderInstance.creadaPor        
        List<Rol> currentUserRoles = UsuarioRol.findByUsuario(userSolicitante).collect { it.rol } as List               
        if(currentUserRoles.authority.contains("ROLE_SOLICITANTE_EXTERNO")) {
            solicitudExterno = true
        }else{
            solicitudExterno = false
        }   
        if(currentUserRoles.authority.contains("ROLE_PODERES_SOLICITANTE")) {
            solicitanteInterno = true
        }else if((currentUserRoles.authority.contains("ROLE_SOLICITANTE_ESPECIAL"))){
            solicitanteUSS = true
        }
        //datos del notario        
        def datosNotario = null
        if(otorgamientoDePoderInstance.notarioCorrespondienteId){
            datosNotario = Usuario.get(otorgamientoDePoderInstance?.notarioCorrespondienteId)
        }        
        [
            otorgamientoDePoderInstance: otorgamientoDePoderInstance,
            cartaDeInstruccion : cartaDeInstruccion,
            ocultarBoton:ocultarBoton,
            diasRestantes : diasRestantes,
            usuariosReasignacion : usuariosReasignacion,
            solicitudExterno : solicitudExterno,
            datosNotario : datosNotario,
            solicitanteUSS : solicitanteUSS,
            solicitanteInterno : solicitanteInterno
        ]                       
    }
    /**
     * Método para editar un registro.
     */
    def edit(Long id) {        
        def otorgamientoDePoderInstance = OtorgamientoDePoder.read(id)        
        if (!otorgamientoDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'poder.label', default: 'Poder'), id])
            redirect(action: "list")
            return
        }
        if(otorgamientoDePoderInstance.tags){
            otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.replaceAll("@",",")
            if(otorgamientoDePoderInstance.tags && otorgamientoDePoderInstance.tags.endsWith(",")){
                otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.substring(0,otorgamientoDePoderInstance.tags.length()-1)
            }
        }         
        def cargosPrincipal = CargoApoderado.list()        
        def listCargos = []                       
        cargosPrincipal.each{cargo->
            cargo.categoriasDeTipoDePoder.each{categoria ->                
                if(categoria.nombre == otorgamientoDePoderInstance.categoriaDeTipoDePoder.nombre){                   
                    listCargos.add(cargo)
                }
            }
        }         
        [
            otorgamientoDePoderInstance: otorgamientoDePoderInstance, anchor : params.anchor?:"",
            listCargos : listCargos
        ]
    }
    /**
     * Método para actualizar los datos de un registro.
     */
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
        //se reasigna al resolvedor cuando se envia la copia electronica
        if (params.fechaDeOtorgamiento) {
            Date fechaDeOtorgamiento = sdf.parse(params.fechaDeOtorgamiento)
            params.fechaDeOtorgamiento = fechaDeOtorgamiento
            def usuarioResolvedorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
            usuarioResolvedorPoderes.each{
                otorgamientoDePoderInstance.asignar = Usuario.get(it.id as long)   
            } 
            otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
            otorgamientoDePoderInstance.notarioCorrespondiente = springSecurityService.currentUser
            //se calcula la fecha de vencimiento sumando el periodo de 730 dias que es el periodo de 2 años                               
            use (TimeCategory) {
                otorgamientoDePoderInstance.fechaVencimiento = params.fechaDeOtorgamiento + 24.month
            }        
            //end
            otorgamientoDePoderInstance.fechaDeEnvio = new Date()
            //se cambia el status de los apoderados para c/u de los apoderados
            otorgamientoDePoderInstance.apoderados.each{apoderado ->
                apoderado.statusDePoder = 'Vigente'
                apoderado.save()
            }
            //se guardan datos en la bitacora
            bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se envió la copia de Electrónica")
        } else {
            params.fechaDeOtorgamiento = null
        }
        //end
        //validacion para la busqueda por tags
        if(params.tags && !params.tags.endsWith(",")){
            params.tags = params.tags + "@" 
        }
        if(params.tags){
            params.tags = params.tags.replaceAll(",", "@")
        }
        //end busqueda tags
        otorgamientoDePoderInstance.properties = params        
        if (!otorgamientoDePoderInstance.save(flush: true)) {
            render(view: "edit", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
            return
        }
        if(params.archivo){
            if (params.archivo.getSize()!=0) {            
                def documentoDePoderInstance = new DocumentoDePoder(params)
                documentoDePoderInstance.nombre = params.archivo.getOriginalFilename()
                otorgamientoDePoderInstance.addToDocumentos(documentoDePoderInstance)
                if (!otorgamientoDePoderInstance.save(flush: true)) {
                    render(view: "create", model: [otorgamientoDePoderInstance: otorgamientoDePoderInstance])
                    return
                }
            }
        }
        if(params.tags){
            otorgamientoDePoderInstance = OtorgamientoDePoder.read(id)
            otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.replaceAll("@",",")
            if(otorgamientoDePoderInstance.tags && otorgamientoDePoderInstance.tags.endsWith(",")){              
                otorgamientoDePoderInstance.tags = otorgamientoDePoderInstance.tags.substring(0,otorgamientoDePoderInstance.tags.length()-1)
            }
        }
        //se cambia redireccionamiento cuando se envia la copia de escritura al solicitante
        if (params.fechaDeOtorgamiento != null) {
            flash.message = "Se ha enviado con éxito la copia de Escritura al Resolvedor"
            redirect(controller:"poderes", action: "index")            
        }else{            
            flash.message = message(code: 'default.updated.message', args: [message(code: 'poder.label', default: 'Poder'), otorgamientoDePoderInstance.id])
            redirect(action: "edit", id: otorgamientoDePoderInstance.id, params : [ anchor : params.anchor ])
        }
    }
    /**
     * Método para eliminar el registro del sistema.
     */
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
    /**
     * Método para eliminar un archivo dentro de la solicitud de otorgamiento de poder.
     */
    def deleteArchivo(Long id) {
        def otorgamientoDePoderId = params.otorgamientoDePoderId
        def otorgamientoDePoder = OtorgamientoDePoder.get (otorgamientoDePoderId)
        def documentoDePoder = DocumentoDePoder.get(id)
        otorgamientoDePoder.removeFromDocumentos(documentoDePoder)
        documentoDePoder.delete()
        flash.message = "El archivo se ha eliminado satisfactoriamente."
        redirect(action: "edit", id: otorgamientoDePoderId, params : [ anchor : params.anchor ])
    }
    /**
     * Método para saber si ya esta creada la carta de instrucción de un otorgamiento.
     */
    def existe() {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.id)        
        def cartaDeInstruccion = CartaDeInstruccionDeOtorgamiento.findByOtorgamientoDePoder(otorgamientoDePoderInstance)
        if(!cartaDeInstruccion) {
            redirect(controller: "cartaDeInstruccionDeOtorgamiento", action: "create", params:[id:otorgamientoDePoderInstance.id])
            return   
        } else {
            redirect(controller: "cartaDeInstruccionDeOtorgamiento", action: "edit", params:[id:cartaDeInstruccion.id, otorgamientoDePoderId: otorgamientoDePoderInstance.id])
            return   
        }
    }
    /**
     * Método para agregar apoderados dentro de la solicitud.
     */
    def addApoderado () {            
        def cargoApoderado = CargoApoderado.get(params.cargoApoderado as long)        
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.otorgamientoDePoder.id as long)
        if(params.apoderado == params.apoderado2){                    
            def apoderadoInstance = Apoderado.findByNombre(params."apoderado") 
            apoderadoInstance = new Apoderado(nombre:params."apoderado".toUpperCase(), cargoApoderado:cargoApoderado, numeroIN:params?.numeroIN  ) 
            if (apoderadoInstance) {
                apoderadoInstance.cargoApoderado = cargoApoderado
                apoderadoInstance.save()
                otorgamientoDePoderInstance.addToApoderados(apoderadoInstance)
                otorgamientoDePoderInstance.addToApoderadosVigentes(apoderadoInstance)
                if (otorgamientoDePoderInstance.save(flush:true)) {                
                    flash.message = "Se ha agregado apoderado a la solicitud."
                    params.apoderado = null
                } else {
                    flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
                }
            } else {          
                apoderadoInstance = new Apoderado(nombre:params."apoderado".toUpperCase(), cargoApoderado:cargoApoderado, numeroIN:params?.numeroIN  )                        
                if (apoderadoInstance.save(flush:true)) {  
                    otorgamientoDePoderInstance.addToApoderados(apoderadoInstance)
                    otorgamientoDePoderInstance.addToApoderadosVigentes(apoderadoInstance)
                    if (otorgamientoDePoderInstance.save(flush:true)) {                    
                        flash.message = "Se ha agregado apoderado a la solicitud."
                        params.apoderado = null
                    } else {
                        flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
                    }                
                } else {
                    flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
                }
            }
        }else{
            flash.error = "No coinciden los campos del nombre de apoderado"
        }
        redirect(action: "edit", id: otorgamientoDePoderInstance.id, params : [anchor : params.anchor, apoderado : params.apoderado])
    }
    /**
     * Método para eliminar apoderado dentro de la solicitud.
     */
    def removeApoderado () {
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.otorgamientoDePoder.id as long)        
        def apoderadoInstance = Apoderado.get(params.apoderado.id as long)
        otorgamientoDePoderInstance.removeFromApoderados(apoderadoInstance)
        otorgamientoDePoderInstance.removeFromApoderadosVigentes(apoderadoInstance)
        flash.message = "El apoderado ha sido eliminado."        
        redirect(action: "edit", id: otorgamientoDePoderInstance.id, params : [ anchor : params.anchor ])
    }
    /**
     * Método para enviar la solicitud y se asigna al usuario correspondiente.
     */
    def asignarA(){
        
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.idOtorgamientoDePoder as long)
                
        def userActual = springSecurityService.currentUser
        List<Rol> currentUserRoles = UsuarioRol.findByUsuario(userActual).collect { it.rol } as List        
        
        def userExterno = null
        if(currentUserRoles.authority.contains("ROLE_SOLICITANTE_EXTERNO")) {
                       
            //params.userExterno = true
           
            if (!otorgamientoDePoderInstance.datosUsuarioExterno){
                flash.warn = "No se ha agregado un documento con los datos necesarios del usuario." 
                redirect(action: "edit", id: params.idOtorgamientoDePoder, params : [anchor : params.anchor])
            }else{
                def usuarioGestorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_GESTOR_EXTERNO")).collect {it.usuario}        
                usuarioGestorPoderes.each{
                    otorgamientoDePoderInstance.asignar = Usuario.get(it.id as long)   
                }        
                otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
                otorgamientoDePoderInstance.fechaDeEnvio = new Date()
                otorgamientoDePoderInstance.apoderados.each{apoderado ->
                    apoderado.statusDePoder = 'En trámite de otorgamiento'
                }
                otorgamientoDePoderInstance.save()
                //se guardan datos en la bitacora
                bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se envió la solicitud")
                flash.message = "Se ha enviado con éxito la Solicitud."        
                redirect(controller: "poderes", action: "index")                
            }            
        }else if(currentUserRoles.authority.contains("ROLE_SOLICITANTE_ESPECIAL")){
            
            if (!otorgamientoDePoderInstance.datosUsuarioExterno){
                flash.warn = "No se ha agregado un documento con los datos necesarios del usuario." 
                redirect(action: "edit", id: params.idOtorgamientoDePoder, params : [anchor : params.anchor])
            }else{
                def usuarioGestorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_GESTOR")).collect {it.usuario}        
                usuarioGestorPoderes.each{
                    otorgamientoDePoderInstance.asignar = Usuario.get(it.id as long)   
                }        
                otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
                otorgamientoDePoderInstance.fechaDeEnvio = new Date()
                otorgamientoDePoderInstance.apoderados.each{apoderado ->
                    apoderado.statusDePoder = 'En trámite de otorgamiento'
                    apoderado.save()
                }
                otorgamientoDePoderInstance.save()
                //se guardan datos en la bitacora
                bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se envió la solicitud")
                flash.message = "Se ha enviado con éxito la Solicitud."        
                redirect(controller: "poderes", action: "index")                
            } 
            
        }else{            
            params.userExterno = false
        
           
            def usuarioGestorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_GESTOR")).collect {it.usuario}        
            usuarioGestorPoderes.each{
                otorgamientoDePoderInstance.asignar = Usuario.get(it.id as long)   
            }        
            otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
            otorgamientoDePoderInstance.fechaDeEnvio = new Date()
            otorgamientoDePoderInstance.apoderados.each{apoderado ->
                apoderado.statusDePoder = 'En trámite de otorgamiento'
                apoderado.save()
            }
            otorgamientoDePoderInstance.save()
            //se guardan datos en la bitacora
            bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se envió la solicitud")
            flash.message = "Se ha enviado con éxito la Solicitud."        
            redirect(controller: "poderes", action: "index")
        }
    }
    /**
     * Método para enviar la copia de escritura publica al usuario solicitante.
     */
    def entregarCopiaSolicitante(){
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.idOtorgamientoDePoder as long)        
        otorgamientoDePoderInstance.asignar = otorgamientoDePoderInstance.creadaPor
        otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser       
        otorgamientoDePoderInstance.fechaDeEnvio = new Date()       
        otorgamientoDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se envió Copia Electrónica al Solicitante")
        flash.message = "Se ha enviado con éxito la Copia Electrónica."        
        redirect(controller: "poderes", action: "index")
    }
    def entregarCopiaGestorExterno(){
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.idOtorgamientoDePoder as long)
        def usuarioGestorExterno = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_GESTOR_EXTERNO")).collect {it.usuario}        
        usuarioGestorExterno.each{
            otorgamientoDePoderInstance.asignar = Usuario.get(it.id as long)   
        }        
        otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
        otorgamientoDePoderInstance.fechaDeEnvio = new Date()
        otorgamientoDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se envió Copia Electrónica al Gestor Externo")
        flash.message = "Se ha turnado con éxito la Solicitud."        
        redirect(controller: "poderes", action: "index")
        
    }
    /**
     * Método para asignar la solicitud al usuario resolvedor.
     */
    def turnarResolvedor(){
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.id as long)
        def usuarioResolvedorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
        usuarioResolvedorPoderes.each{
            otorgamientoDePoderInstance.asignar = Usuario.get(it.id as long)   
        }        
        otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
        otorgamientoDePoderInstance.fechaDeEnvio = new Date()
        otorgamientoDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se turnó la solicitud al Usuario Resolvedor")
        flash.message = "Se ha turnado con éxito la Solicitud."        
        redirect(controller: "poderes", action: "index")
    }    
    def turnarGestor(){
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.id as long)
        def usuarioGestorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_GESTOR")).collect {it.usuario}        
        usuarioGestorPoderes.each{
            otorgamientoDePoderInstance.asignar = Usuario.get(it.id as long)   
        }        
        otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
        otorgamientoDePoderInstance.fechaDeEnvio = new Date()
        otorgamientoDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se turnó la solicitud al Usuario Gestor")
        flash.message = "Se ha turnado con éxito la Solicitud."        
        redirect(controller: "poderes", action: "index")
    } 
    def turnarSolicitanteExterni(){
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.id as long)       
            
        otorgamientoDePoderInstance.asignar = otorgamientoDePoderInstance.creadaPor              
        otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
        otorgamientoDePoderInstance.fechaDeEnvio = new Date()
        otorgamientoDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se envió el rechazo de la solicitud al Usuario Solicitante por parte del usuario Gestor Externo")
        flash.message = "Se ha turnado con éxito la Solicitud."        
        redirect(controller: "poderes", action: "index")
    }
    /**
     * Método para imprimir la solicitud de otorgamiento de poder.
     */
    def imprimir(Long id){
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(id)
        //datos del notario        
        def datosNotario = null
        if(otorgamientoDePoderInstance.notarioCorrespondienteId){
            datosNotario = Usuario.get(otorgamientoDePoderInstance?.notarioCorrespondienteId)
        }
        //bandera para saber si es una solicitud de solicitante_externo         
        def solicitudExterno = null
        def solicitanteInterno = null
        def solicitanteUSS = null
        def userSolicitante = otorgamientoDePoderInstance.creadaPor        
        List<Rol> currentUserRoles = UsuarioRol.findByUsuario(userSolicitante).collect { it.rol } as List               
        if(currentUserRoles.authority.contains("ROLE_SOLICITANTE_EXTERNO")) {
            solicitudExterno = true
        }else{
            solicitudExterno = false
        }   
        if(currentUserRoles.authority.contains("ROLE_PODERES_SOLICITANTE")) {
            solicitanteInterno = true
        }else if((currentUserRoles.authority.contains("ROLE_SOLICITANTE_ESPECIAL"))){
            solicitanteUSS = true
        }
        
        [ otorgamientoDePoderInstance : otorgamientoDePoderInstance,
            datosNotario : datosNotario,
            solicitudExterno : solicitudExterno,
            solicitanteInterno : solicitanteInterno,
            solicitanteUSS : solicitanteUSS
        ]
    }
    /**
     * Método para reasignar una solicitud en dado caso que aun no sea atendida
     * por el usuario que la tiene actualmente asignada.
     */
    def reasignarSolicitud(Long id){        
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.otorgamientoDePoder.id as long)        
        
        def usuarioInstance = Usuario.get(params.asignar.id as long)
        otorgamientoDePoderInstance.asignar = usuarioInstance
        otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
        otorgamientoDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se reasignó la Solicitud")
        flash.message = "Se ha Reasignado la Solicitud."        
        redirect(controller: "poderes", action: "index")
        
        [ otorgamientoDePoderInstance : otorgamientoDePoderInstance ]
    }
    
    def ocultarPorResolvedor(Long id){          
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.id as long)                
        otorgamientoDePoderInstance.ocultadoPorResolvedor = true
        otorgamientoDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarOtorgamiento(otorgamientoDePoderInstance, springSecurityService.currentUser, "Se ocultó la Solicitud")
        flash.message = "Se ha Ocultado la Solicitud."        
        redirect(controller: "poderes", action: "index")
        
        [ otorgamientoDePoderInstance : otorgamientoDePoderInstance ]
    }
    
    def ocultarPorSolicitante(Long id){         
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.id as long)                
        otorgamientoDePoderInstance.ocultadoPorSolicitante = true
        otorgamientoDePoderInstance.save()        
        flash.message = "Se ha Ocultado la Solicitud."        
        redirect(controller: "poderes", action: "index")
        
        [ otorgamientoDePoderInstance : otorgamientoDePoderInstance ]
    }
    def uploadDatosUsuario (){
                                
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(params.otorgamientoDePoder.id as long)    
        def f = request.getFile('datosUsuario')
        if (!f.getSize()) {
            flash.warn = "Debe indicar la ruta del archivo."
        } else if (f.getSize() >= 52428800) {
            flash.warn = "El archivo debe pesar menos de 50 Mb."
        } else {
            def filename = f.getOriginalFilename()                         
            def extension = filename.substring(filename.lastIndexOf(".") + 1, filename.size()).toLowerCase()                       
            otorgamientoDePoderInstance.nombreDatosUsuarioExterno = filename
            otorgamientoDePoderInstance.datosUsuarioExterno = f.getBytes()
            if (otorgamientoDePoderInstance.save(flash:true)) {                
                flash.message = "el archivo se ha cargado correctamente."
                redirect(action: "edit", id: params.otorgamientoDePoder.id, params : [anchor : params.anchor])
            } else {
                flash.error = "Error en base de datos."
            }                       
        }
    }
    
    def downloadArchivo2 () {        
        if(params.id){
            def poderId = params.id
            def poderInstance = OtorgamientoDePoder.get(poderId as long)
            response.setHeader("Content-Disposition", "attachment;filename=\"" + poderInstance.nombreDocumentoPoderEspecial + "\"");
            byte[] documentoPoderEspecial = poderInstance.documentoPoderEspecial
            response.outputStream << documentoPoderEspecial
        }else{
        
            def poderInstance = OtorgamientoDePoder.get(params.poderId as long)
            response.setHeader("Content-Disposition", "attachment;filename=\"" + poderInstance.nombreDocumentoPoderEspecial + "\"");
            byte[] documentoPoderEspecial = poderInstance.documentoPoderEspecial
            response.outputStream << documentoPoderEspecial
        }  
    }
    
}
