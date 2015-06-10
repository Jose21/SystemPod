package com.app.sgpod

import java.text.SimpleDateFormat
import org.springframework.dao.DataIntegrityViolationException
import grails.converters.JSON
import grails.plugins.springsecurity.Secured
import com.app.security.Usuario
import com.app.sgtask.Documento
import com.app.security.Rol
import com.app.security.UsuarioRol

@Secured(['IS_AUTHENTICATED_FULLY'])
class RevocacionDePoderController {
    
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
        [revocacionDePoderInstanceList: RevocacionDePoder.list(params), revocacionDePoderInstanceTotal: RevocacionDePoder.count()]
    }
    /**
     * Este método sirve para la creacion de un registro de tipo revocación de poder.
     */
    def create() {                               
        def datosDelOtorgamiento = OtorgamientoDePoder.findByEscrituraPublica(params.escrituraPublica)                 
        def revocacionDePoderInstance = new RevocacionDePoder(params)
        if(params.escrituraPublica){
            if(!datosDelOtorgamiento?.escrituraPublica){
                flash.warn = "No se ha encontrado una solicitud de Otorgamiento de Poder"
            }else if (!datosDelOtorgamiento?.apoderadosVigentes){
                flash.warn = "El poder asociado al Número de Escritura Pública esta totalmente Revocado."
            }else if(datosDelOtorgamiento?.solicitudEnProceso == true){
                flash.warn = "Existe una solicitud en proceso asociada al Número de Escritura que esta buscando"
            }else{
                
                revocacionDePoderInstance.escrituraPublica = datosDelOtorgamiento?.escrituraPublica
                revocacionDePoderInstance.categoriaDeTipoDePoder = datosDelOtorgamiento?.categoriaDeTipoDePoder
                revocacionDePoderInstance.delegacion = datosDelOtorgamiento?.delegacion                
                //revocacionDePoderInstance.fechaDeRevocacion = datosDelOtorgamiento?.fechaVencimiento
                revocacionDePoderInstance.comentarios = datosDelOtorgamiento?.comentarios
                revocacionDePoderInstance.documentos = datosDelOtorgamiento?.documentos
                revocacionDePoderInstance.apoderados = datosDelOtorgamiento?.apoderadosVigentes                
                revocacionDePoderInstance.agregarApoderado = false                
                flash.info = "Se han cargado los datos de la Escritura Pública"                
            }            
        }
        [revocacionDePoderInstance: revocacionDePoderInstance, otorgamientoDePoderId : datosDelOtorgamiento?.id]        
    }
    /**
     * Método para guardar los registros en el sistema.
     */
    def save() {          
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        
        params.registroDeLaSolicitud = new Date()
        
        if (params.fechaDeRevocacion) {
            Date fechaDeRevocacion = sdf.parse(params.fechaDeRevocacion)
            params.fechaDeRevocacion = fechaDeRevocacion
        } else {
            params.fechaDeRevocacion = null
        }       
        //se agrega el que creó la revocacion en la bd
        params.creadaPor = springSecurityService.currentUser
        //se agrega notario correspondiente a la solicitud de revocacion        
        def otorgamientoDePoderInstance = OtorgamientoDePoder.findByEscrituraPublica(params.escrituraPublica)        
        if(otorgamientoDePoderInstance){
            params.notarioCorrespondiente = otorgamientoDePoderInstance.notarioCorrespondiente
        }
        
        //Se cambian las comas por arrobas
        if(params.tags && !params.tags.endsWith(",")){
            params.tags = params.tags + "@"
        }
        params.tags = params.tags.replaceAll(",", "@")        
        def revocacionDePoderInstance = new RevocacionDePoder(params)        
        
        params.each(){
            if (it.key.startsWith('apoderado')){                
                def apoderadoId = it.key.replace("apoderado","")                 
                def apoderadoInstance = Apoderado.get(apoderadoId as long)
                revocacionDePoderInstance.addToApoderados(apoderadoInstance)
            }
        }
        
        params.each(){
            if (it.key.startsWith('documento')){                
                def documentoId = it.key.replace("documento","")                 
                def documentoInstance = DocumentoDePoder.get(documentoId as long)
                revocacionDePoderInstance.addToDocumentos(documentoInstance)
            }
        } 
        //se guardan los archivos adjuntos cuando se crea una solicitud manualmente
        if(params.archivo){
            if (params.archivo?.getSize()!=0) {            
                def documentoInstance = new DocumentoDePoder(params)
                documentoInstance.nombre = params.archivo.getOriginalFilename()
                revocacionDePoderInstance.addToDocumentos(documentoInstance)
                revocacionDePoderInstance.agregadaManualmente = true
            
            }
        }
        //se guardan datos en la bitacora
        bitacoraService.agregarRevocacion(revocacionDePoderInstance, springSecurityService.currentUser, "Se creó la Solicitud de Revocación de Poder")        
                        
        if (!revocacionDePoderInstance.save(flush: true)) {
            render(view: "create", model: [revocacionDePoderInstance: revocacionDePoderInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), revocacionDePoderInstance.id])
        redirect(action: "edit", id: revocacionDePoderInstance.id)
    }
    /**
     * Método para visualizar el registro creado en el sistema.
     */
    def show(Long id) {
        def revocacionDePoderInstance = RevocacionDePoder.read(id)        
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }
        if(revocacionDePoderInstance.tags){
            revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.replaceAll("@",",")
            if(revocacionDePoderInstance.tags && revocacionDePoderInstance.tags.endsWith(",")){
                revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.substring(0,revocacionDePoderInstance.tags.length()-1)
            }
        }
        //parametro para ocualtar botones
        def ocultarBoton = false
        if(revocacionDePoderInstance.asignar != springSecurityService.currentUser){
            ocultarBoton = true
        }
        
        //valor de prorrogas
        def diasDeProrroga = null
        def diasDeProrrogaTotal = 0
        def diasRestantes = null
        
        if(revocacionDePoderInstance.prorrogas){ 
                      
            def prorrogasList = revocacionDePoderInstance.prorrogas.sort{ it.getId() }                                                    
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
        
        def cartaDeInstruccion = CartaDeInstruccionDeRevocacion.findByRevocacionDePoder(revocacionDePoderInstance)
        
        //bandera para saber si es una solicitud de solicitante_externo                                       
        def userSolicitante = revocacionDePoderInstance.creadaPor
        List<Rol> currentUserRoles = UsuarioRol.findByUsuario(userSolicitante).collect { it.rol } as List          
        def solicitudExterno = null
        def solicitanteInterno = null
        def solicitanteUSS = null
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
        if(revocacionDePoderInstance.notarioCorrespondienteId){
            datosNotario = Usuario.get(revocacionDePoderInstance?.notarioCorrespondienteId)
        }          
        //otorgamiento al q pertenece la revocacion        
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(revocacionDePoderInstance.otorgamientoDePoderId)        
        
        [
            revocacionDePoderInstance: revocacionDePoderInstance,
            ocultarBoton : ocultarBoton,
            cartaDeInstruccion : cartaDeInstruccion,
            diasRestantes : diasRestantes,
            usuariosReasignacion : usuariosReasignacion,
            solicitudExterno : solicitudExterno,
            solicitanteUSS : solicitanteUSS,
            solicitanteInterno : solicitanteInterno,
            datosNotario : datosNotario,
            otorgamientoDePoderInstance : otorgamientoDePoderInstance
        ]
    }
    /**
     * Método para editar un registro.
     */
    def edit(Long id) {
        def revocacionDePoderInstance = RevocacionDePoder.read(id)        
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }
        if(revocacionDePoderInstance.tags){
            revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.replaceAll("@",",")
            if(revocacionDePoderInstance.tags && revocacionDePoderInstance.tags.endsWith(",")){
                revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.substring(0,revocacionDePoderInstance.tags.length()-1)
            }
        }
        [revocacionDePoderInstance: revocacionDePoderInstance, anchor : params.anchor?:""]
    }
    /**
     * Método para actualizar los datos de un registro.
     */
    def update(Long id, Long version) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        def revocacionDePoderInstance = RevocacionDePoder.get(id)
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (revocacionDePoderInstance.version > version) {
                revocacionDePoderInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder')] as Object[],
                          "Another user has updated this RevocacionDePoder while you were editing")
                render(view: "edit", model: [revocacionDePoderInstance: revocacionDePoderInstance])
                return
            }
        }

        if (params.fechaDeRevocacion) {
            Date fechaDeRevocacion = sdf.parse(params.fechaDeRevocacion)
            params.fechaDeRevocacion = fechaDeRevocacion            
            params.notarioCorrespondiente = springSecurityService.currentUser            
        } else {
            params.fechaDeRevocacion = null
        }
        
        if(revocacionDePoderInstance.tags){
            //validacion para la busqueda por tags
            if(params.tags && !params.tags.endsWith(",")){
                params.tags = params.tags + "@" 
            }
            params.tags = params.tags.replaceAll(",", "@")
            revocacionDePoderInstance.properties = params
        }
        if (!revocacionDePoderInstance.save(flush: true)) {
            render(view: "edit", model: [revocacionDePoderInstance: revocacionDePoderInstance])
            return
        }
        /*        
        if (params.archivo.getSize()!=0) {            
        def documentoDePoderInstance = new DocumentoDePoder(params)
        documentoDePoderInstance.nombre = params.archivo.getOriginalFilename()
        revocacionDePoderInstance.addToDocumentos(documentoDePoderInstance)                        
        }*/
        if(revocacionDePoderInstance.tags){
            revocacionDePoderInstance = RevocacionDePoder.read(id)
            revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.replaceAll("@",",")
            if(revocacionDePoderInstance.tags && revocacionDePoderInstance.tags.endsWith(",")){              
                revocacionDePoderInstance.tags = revocacionDePoderInstance.tags.substring(0,revocacionDePoderInstance.tags.length()-1)
            }
        }                
        flash.message = message(code: 'default.updated.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), revocacionDePoderInstance.id])
        redirect(action: "edit", id: revocacionDePoderInstance.id, params : [ anchor : params.anchor])
    }
    /**
     * Método para eliminar el registro del sistema.
     */
    def delete(Long id) {
        def revocacionDePoderInstance = RevocacionDePoder.get(id)
        if (!revocacionDePoderInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
            return
        }

        try {
            revocacionDePoderInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'revocacionDePoder.label', default: 'RevocacionDePoder'), id])
            redirect(action: "show", id: id)
        }
    }
    /**
     * Método para eliminar un archivo dentro de la solicitud de revocación de poder.
     */
    def deleteArchivo(Long id) {
        def revocacionDePoderId = params.revocacionDePoderId
        def revocacionDePoder = RevocacionDePoder.get (revocacionDePoderId)
        def documentoDePoder = DocumentoDePoder.get(id)
        revocacionDePoder.removeFromDocumentos(documentoDePoder)
        documentoDePoder.delete()
        flash.message = "El archivo se ha eliminado satisfactoriamente."
        redirect(action: "edit", id: revocacionDePoderId, params : [ anchor : params.anchor ])
    }
    /**
     * Método para saber si ya esta creada la carta de instrucción de una revocación.
     */
    def existe() {
        def revocacionDePoderInstance = RevocacionDePoder.get(params.id)       
        def cartaDeInstruccion = CartaDeInstruccionDeRevocacion.findByRevocacionDePoder(revocacionDePoderInstance)
        if(!cartaDeInstruccion) {
            redirect(controller: "cartaDeInstruccionDeRevocacion", action: "create", params:[id:revocacionDePoderInstance.id])
            return   
        } else {
            redirect(controller: "cartaDeInstruccionDeRevocacion", action: "edit", params:[id:cartaDeInstruccion.id, revocacionId: revocacionDePoderInstance.id])
            return   
        }
    }
    def existeCarta() {
        def revocacionDePoderInstance = RevocacionDePoder.get(params.id)       
        def cartaDeInstruccion = CartaDeInstruccionDeRevocacion.findByRevocacionDePoder(revocacionDePoderInstance)
        if(!cartaDeInstruccion) {
            redirect(controller: "cartaDeInstruccionDeRevocacion", action: "create", params:[id:revocacionDePoderInstance.id])
            return   
        } else {
            redirect(controller: "cartaDeInstruccionDeRevocacion", action: "show", params:[id:cartaDeInstruccion.id, revocacionId: revocacionDePoderInstance.id])
            return   
        }
    }
    /**
     * Método para hacer busquedas ajax para mostrar posibles opciones al buscar por número de escritura pública en la crecaion de una revocacion de poder.
     */
    def ajaxFinder() {
        def found = null
        if (params.term) {            
            def term = params.term
            found = OtorgamientoDePoder.withCriteria {
                ilike 'escrituraPublica', '%' + term + '%'
            }
        }
        render (found?.'escrituraPublica' as JSON)
    }
    /**
     * Método para buscar un otorgamiento de poder y crear una revocación.
     */
    def buscarEscrituraPublica(){        
        def datosDelOtorgamiento = OtorgamientoDePoder.findByEscrituraPublica(params.escrituraPublica)                
        def revocacionDePoderInstance = new RevocacionDePoder(params)
        revocacionDePoderInstance.escrituraPublica = datosDelOtorgamiento.escrituraPublica
        revocacionDePoderInstance.categoriaDeTipoDePoder = datosDelOtorgamiento.categoriaDeTipoDePoder
        revocacionDePoderInstance.delegacion = datosDelOtorgamiento.delegacion
        
        [revocacionDePoderInstance: revocacionDePoderInstance, otorgamientoDePoderId : datosDelOtorgamiento?.id]
    }
    /**
     * Método para enviar la solicitud y se asigna al usuario correspondiente.
     */
    def enviarSolicitud () {         
        def revocacionDePoderInstance = RevocacionDePoder.get(params.revocacionDePoder.id)        
        def otorgamientoDePoderInstance = OtorgamientoDePoder.findByEscrituraPublica(revocacionDePoderInstance.escrituraPublica)  
                                               
        def userActual = springSecurityService.currentUser
        List<Rol> currentUserRoles = UsuarioRol.findByUsuario(userActual).collect { it.rol } as List  
        
        def userExterno = null
        if(currentUserRoles.authority.contains("ROLE_SOLICITANTE_EXTERNO")) {            
            if (!revocacionDePoderInstance.datosUsuarioExterno){
                flash.warn = "No se ha agregado un documento con los datos necesarios del usuario." 
                redirect(action: "edit" , params : [id: revocacionDePoderInstance.id ])
                return
            }else{
            
                def usuarioGestorExterno = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_GESTOR_EXTERNO")).collect {it.usuario}        
                usuarioGestorExterno.each{
                    revocacionDePoderInstance.asignar = Usuario.get(it.id as long)   
                }
                userExterno = true
            }
            
        }else if(currentUserRoles.authority.contains("ROLE_SOLICITANTE_ESPECIAL")){
            
            if (!revocacionDePoderInstance.datosUsuarioExterno){
                flash.warn = "No se ha agregado un documento con los datos necesarios del usuario." 
                redirect(action: "edit" , params : [id: revocacionDePoderInstance.id ])
                return
            }else{
            
                def usuarioGestorExterno = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_GESTOR")).collect {it.usuario}        
                usuarioGestorExterno.each{
                    revocacionDePoderInstance.asignar = Usuario.get(it.id as long)   
                }
                userExterno = true
            }
        }else{                                   
            def usuarioGestorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_GESTOR")).collect {it.usuario}        
            usuarioGestorPoderes.each{
                revocacionDePoderInstance.asignar = Usuario.get(it.id as long)   
            } 
            userExterno = false
        }  
        
        if(revocacionDePoderInstance?.tipoDeRevocacion == "Parcial"){
            if(params.apoderadoList){
                def apoderadoSelects = params.list('apoderadoList')        
                def selectedApoderados = Apoderado.getAll(apoderadoSelects)                
                def listaInicialDeApoderados = revocacionDePoderInstance.apoderados              
          
                def lista2 = listaInicialDeApoderados - selectedApoderados            
                //se agregar los apoderados que se van a eliminar a la solicitud                
                selectedApoderados.each(){ it ->                                                
                    revocacionDePoderInstance.addToApoderadosEliminar(it)           
                }
                // se quitan de la lista los apoderados que se eliminan
                lista2.each(){ it ->                                                
                    revocacionDePoderInstance.removeFromApoderados(it)            
                }
            }else if(revocacionDePoderInstance.agregadaManualmente == false){                
                flash.error = "Debe Elegir al menos un Apoderado."
                redirect(action: "edit", params: [id: revocacionDePoderInstance.id])
                return            
            }else if(revocacionDePoderInstance.agregadaManualmente == true){
                revocacionDePoderInstance.apoderados.each(){it ->
                    revocacionDePoderInstance.addToApoderadosEliminar(it) 
                }
            }
        }
        
        if(revocacionDePoderInstance?.tipoDeRevocacion == "Total"){            
            revocacionDePoderInstance.apoderados.each{ it ->
                revocacionDePoderInstance.addToApoderadosEliminar(it)
            } 
        }                
        
        revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
        revocacionDePoderInstance.fechaDeEnvio = new Date()   
        revocacionDePoderInstance.otorgamientoDePoder = otorgamientoDePoderInstance
        //se cambia el status de los apoderados para c/u de los apoderados
        revocacionDePoderInstance.apoderadosEliminar.each{apoderado ->
            apoderado.statusDePoder = 'En trámite de revocación'
            apoderado.save()
        }
        revocacionDePoderInstance.save()
        //se cambia el estatus del poder cuando es una revocacion a traves de una solicitud existente
        if(otorgamientoDePoderInstance){
            otorgamientoDePoderInstance.solicitudEnProceso = true
            otorgamientoDePoderInstance.save()
            flash.message = "Se ha enviado con éxito la Solicitud."
        }
        
        redirect(controller: "poderes", action: "index")        
    }
    /**
     * Método para agregar apoderados dentro de la solicitud.
     */
    def addApoderado () {
        def revocacionDePoderInstance = RevocacionDePoder.get(params.revocacionDePoder.id as long)
        def apoderadoInstance = Apoderado.findByNombre(params."apoderado")
        if (apoderadoInstance) {
            revocacionDePoderInstance.addToApoderados(apoderadoInstance)
            if (revocacionDePoderInstance.save(flush:true)) {                
                flash.message = "Se ha agregado apoderado a la solicitud."
            } else {
                flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
            }
        } else {
            apoderadoInstance = new Apoderado(nombre:params."apoderado")
            if (apoderadoInstance.save(flush:true)) {  
                revocacionDePoderInstance.addToApoderados(apoderadoInstance)
                if (revocacionDePoderInstance.save(flush:true)) {                    
                    flash.message = "Se ha agregado apoderado a la solicitud."
                } else {
                    flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
                }                
            } else {
                flash.error = "No se pudo agregar el apoderado. Favor de reintentar."
            }
        }
        redirect(action: "edit", id: revocacionDePoderInstance.id, params : [anchor : params.anchor])
    }
    def asignarA(){
        /**
         * Método para enviar la solicitud y se asigna al usuario correspondiente.
         */
        def revocacionDePoderInstance = RevocacionDePoder.get(params.idRevocacionDePoder as long)
        revocacionDePoderInstance.asignar = Usuario.get(1 as long)
        def usuarioGestorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_GESTOR")).collect {it.usuario}        
        usuarioGestorPoderes.each{
            revocacionDePoderInstance.asignar = Usuario.get(it.id as long)   
        }
        revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
        revocacionDePoderInstance.fechaDeEnvio = new Date()
        revocacionDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarRevocacion(revocacionDePoderInstance, springSecurityService.currentUser, "Se envió la Solicitud de Revocación de Poder")        
        flash.message = "Se ha enviado con éxito la Solicitud."        
        redirect(controller: "poderes", action: "index")
    }
    /**
     * Método para enviar la copia de escritura publica al usuario solicitante.
     */
    def entregarCopiaSolicitante(){
        def revocacionDePoderInstance = RevocacionDePoder.get(params.idRevocacionDePoder as long)        
        revocacionDePoderInstance.asignar = revocacionDePoderInstance.creadaPor
        revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
        revocacionDePoderInstance.fechaDeEnvio = new Date()
        revocacionDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarRevocacion(revocacionDePoderInstance, springSecurityService.currentUser, "Se envió Copia Electrónica al Solicitante")        
        flash.message = "Se ha enviado con éxito la Copia Electrónica."        
        redirect(controller: "poderes", action: "index")
    }
    /**
     * Método para asignar la solicitud al usuario resolvedor.
     */
    def turnarResolvedor(){
        def revocacionDePoderInstance = RevocacionDePoder.get(params.id as long)
        def usuarioResolvedorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).collect {it.usuario}        
        usuarioResolvedorPoderes.each{
            revocacionDePoderInstance.asignar = Usuario.get(it.id as long)   
        }        
        revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
        revocacionDePoderInstance.fechaDeEnvio = new Date()
        revocacionDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarRevocacion(revocacionDePoderInstance, springSecurityService.currentUser, "Se turnó la solicitud al Usuario Resolvedor")
        flash.message = "Se ha turnado con éxito la Solicitud."        
        redirect(controller: "poderes", action: "index")
    }
    /**
     * Método para asignar la solicitud al usuario resolvedor.
     */
    def turnarGestor1(){
        def revocacionDePoderInstance = RevocacionDePoder.get(params.id as long)
        def usuarioResolvedorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_GESTOR")).collect {it.usuario}        
        usuarioResolvedorPoderes.each{
            revocacionDePoderInstance.asignar = Usuario.get(it.id as long)   
        }        
        revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
        revocacionDePoderInstance.fechaDeEnvio = new Date()
        revocacionDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarRevocacion(revocacionDePoderInstance, springSecurityService.currentUser, "Se turnó la solicitud al Usuario Gestor")
        flash.message = "Se ha turnado con éxito la Solicitud."        
        redirect(controller: "poderes", action: "index")
    }
    /**
     * Método para imprimir la solicitud.
     */
    def imprimir(Long id){
        def revocacionDePoderInstance = RevocacionDePoder.get(id)
        //datos del notario        
        def datosNotario = null
        if(revocacionDePoderInstance.notarioCorrespondienteId){
            datosNotario = Usuario.get(revocacionDePoderInstance?.notarioCorrespondienteId)
        }
        //otorgamiento al q pertenece la revocacion        
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(revocacionDePoderInstance.otorgamientoDePoderId) 
        //bandera para saber si es una solicitud de solicitante_externo                                       
        def userSolicitante = revocacionDePoderInstance.creadaPor
        List<Rol> currentUserRoles = UsuarioRol.findByUsuario(userSolicitante).collect { it.rol } as List          
        def solicitudExterno = null
        def solicitanteInterno = null
        def solicitanteUSS = null
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
        [ revocacionDePoderInstance : revocacionDePoderInstance,
            datosNotario : datosNotario,
            otorgamientoDePoderInstance : otorgamientoDePoderInstance,
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
        def revocacionDePoderInstance = RevocacionDePoder.get(params.revocacionDePoder.id as long)        
        
        def usuarioInstance = Usuario.get(params.asignar.id as long)
        revocacionDePoderInstance.asignar = usuarioInstance
        revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
        revocacionDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarRevocacion(revocacionDePoderInstance, springSecurityService.currentUser, "Se reasignó la Solicitud")
        flash.message = "Se ha Reasignado la Solicitud."        
        redirect(controller: "poderes", action: "index")
        
        [ revocacionDePoderInstance : revocacionDePoderInstance ]
    }
    
    def ocultarPorResolvedor(Long id){          
        def revocacionDePoderInstance = RevocacionDePoder.get(params.id as long)                
        revocacionDePoderInstance.ocultadoPorResolvedor = true
        revocacionDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarRevocacion(revocacionDePoderInstance, springSecurityService.currentUser, "Se ocultó la Solicitud")
        flash.message = "Se ha Ocultado la Solicitud."        
        redirect(controller: "poderes", action: "index")
        
        [ revocacionDePoderInstance : revocacionDePoderInstance ]
    }
    
    def ocultarPorSolicitante(Long id){         
        def revocacionDePoderInstance = RevocacionDePoder.get(params.id as long)                
        revocacionDePoderInstance.ocultadoPorSolicitante = true
        revocacionDePoderInstance.save()        
        flash.message = "Se ha Ocultado la Solicitud."        
        redirect(controller: "poderes", action: "index")
        
        [ revocacionDePoderInstance : revocacionDePoderInstance ]
    }
    
    def uploadDatosUsuario(){                                        
        def revocacionDePoderInstance = RevocacionDePoder.get(params.revocacionDePoder.id as long)    
        def f = request.getFile('datosUsuario')
        if (!f.getSize()) {
            flash.warn = "Debe indicar la ruta del archivo."
            redirect(action: "edit", params : [id: params.revocacionDePoder.id])
        } else if (f.getSize() >= 52428800) {
            flash.warn = "El archivo debe pesar menos de 50 Mb."
        } else {
            def filename = f.getOriginalFilename()                         
            def extension = filename.substring(filename.lastIndexOf(".") + 1, filename.size()).toLowerCase()                       
            revocacionDePoderInstance.nombreDatosUsuarioExterno = filename
            revocacionDePoderInstance.datosUsuarioExterno = f.getBytes()
            if (revocacionDePoderInstance.save(flash:true)) {                
                flash.message = "el archivo se ha cargado correctamente."
                redirect(action: "edit", params : [id: params.revocacionDePoder.id])
            } else {
                flash.error = "Error en base de datos."
            }                       
        }
    }
    def entregarCopiaGestorExterno(){
        def revocacionDePoderInstance = RevocacionDePoder.get(params.idRevocacionDePoder as long)
        def usuarioGestorExterno = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_GESTOR_EXTERNO")).collect {it.usuario}        
        usuarioGestorExterno.each{
            revocacionDePoderInstance.asignar = Usuario.get(it.id as long)   
        }        
        revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
        revocacionDePoderInstance.fechaDeEnvio = new Date()
        revocacionDePoderInstance.save()
        //se guardan datos en la bitacora
        bitacoraService.agregarRevocacion(revocacionDePoderInstance, springSecurityService.currentUser, "Se envió Copia Electrónica al Gestor Externo")
        flash.message = "Se ha turnado con éxito la Solicitud."        
        redirect(controller: "poderes", action: "index")
        
    }
    def notificacionDeRechazo(){          
        def revocacionDePoderInstance = RevocacionDePoder.get(params.idRevocacionDePoder as long)        
        [ revocacionDePoderInstance : revocacionDePoderInstance]
    }
    
    def updateNotificacionDeRechazo(){
        def revocacionDePoderInstance = RevocacionDePoder.get(params.idRevocacionDePoder as long)  
        def otorgamientoDePoderInstance = OtorgamientoDePoder.get(revocacionDePoderInstance.otorgamientoDePoder.id as long)
        revocacionDePoderInstance.notificacionDeRechazo = params.notificacionDeRechazo
        revocacionDePoderInstance.asignar = revocacionDePoderInstance.creadaPor
        revocacionDePoderInstance.asignadaPor = springSecurityService.currentUser
        revocacionDePoderInstance.fechaDeEnvio = new Date() 
        //se cambia el status de los apoderados para c/u de los apoderados
        revocacionDePoderInstance.apoderadosEliminar.each{apoderado ->
            apoderado.statusDePoder = 'Vigente'
            apoderado.save()
        }
        revocacionDePoderInstance.save()
        if(otorgamientoDePoderInstance){
            otorgamientoDePoderInstance.solicitudEnProceso = false
            otorgamientoDePoderInstance.save()            
        }
        flash.message = "Se ha enviado la notificación de rechazo."                       
        redirect(controller: "poderes", action: "index")
    }
}
