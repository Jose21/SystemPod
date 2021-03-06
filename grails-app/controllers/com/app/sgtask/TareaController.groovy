package com.app.sgtask

import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat
import com.app.security.Usuario
import grails.plugin.asyncmail.AsynchronousMailService
import com.app.NotificacionesService
import grails.plugins.springsecurity.Secured
import groovy.time.TimeDuration
import groovy.time.TimeCategory
import com.app.sgcon.Convenio
import com.app.sgcon.beans.BusquedaBean
import com.pogos.BusquedaBean
import com.app.sgpod.OtorgamientoDePoder
import com.app.sgpod.RevocacionDePoder
import com.app.security.Rol
import com.app.security.UsuarioRol
import com.app.ses.AmazonSES
import com.app.sgcon.HistorialDeConvenio

@Secured(['IS_AUTHENTICATED_FULLY'])
class TareaController {

    def historialDeTareaService
    def springSecurityService
    AsynchronousMailService asyncMailService
    NotificacionesService notificacionesService
    def exportService
    def grailsApplication
    def historialDeConvenioService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
    /**
     * Bandeja de turnos pestaña hoy.
     */
    def hoy() {
        flash.warn = null
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        
        session.opt = params.action
        
        //Mis turnos
        def taskList1 = Tarea.findAllByCerradaAndResponsableAndFechaLimiteAndEliminado(false, springSecurityService.currentUser, sdf.parse(sdf.format(new Date())), false)
        def taskList2 = Tarea.findAllByCerradaAndResponsableAndFechaLimiteIsNullAndEliminado(false, springSecurityService.currentUser, false)
        def taskList = taskList1 + taskList2
                
        //Compartidos
        def c = Tarea.createCriteria()
        def sharedTaskList = c.list {
            eq ("cerrada", false)
            ne ("responsable", springSecurityService.currentUser)
            ne ("creadaPor", springSecurityService.currentUser)
            eq ("eliminado", false)
            or {
                eq ("fechaLimite", sdf.parse(sdf.format(new Date())))
                isNull ("fechaLimite")
            }
            usuariosDeTarea {
                eq ("usuario", springSecurityService.currentUser)
                eq ("owner", false)
            }
        }        
        
        //Turnados
        def turnados = Tarea.findAllByFechaLimiteOrFechaLimiteIsNull(sdf.parse(sdf.format(new Date())))
        turnados = turnados.findAll {
            it.cerrada == false &&
            it.creadaPor == springSecurityService.currentUser &&
            it.responsable != springSecurityService.currentUser &&
            it.eliminado == false
        }       
        
        render (
            view: "list", 
            model: [
                tareaInstanceList: taskList, 
                tareaInstanceTotal: taskList.size(),
                sharedTaskList : sharedTaskList,
                sharedTaskTotal : sharedTaskList.size(),
                turnadosList : turnados,
                turnadosTotal : turnados.size()
            ]
        )
    }
    /**
     * Bandeja de turnos pestaña Programadas.
     */
    def programadas() {
        flash.warn = null
        session.opt = params.action
        
        //Mis turnos        
        def taskListQuery = Tarea.where {            
            fechaLimite > new Date() &&
            cerrada == false &&
            responsable == springSecurityService.currentUser &&
            eliminado == false
        }
        def taskList = taskListQuery.list(sort:"id")
        
        //Compartidos        
        def usuariosDeTarea = UsuarioDeTarea.findAllByUsuarioAndOwner(springSecurityService.currentUser, false)
        def sharedTaskList = usuariosDeTarea*.tarea        
        sharedTaskList = sharedTaskList.findAll {            
            it.fechaLimite > new Date() &&
            it.cerrada == false &&
            it.responsable != springSecurityService.currentUser &&
            it.creadaPor != springSecurityService.currentUser &&
            it.eliminado == false
        }
        
        //Turnados
        def turnadosQuery = Tarea.where {
            fechaLimite > new Date() &&
            cerrada == false &&
            responsable != springSecurityService.currentUser &&
            creadaPor == springSecurityService.currentUser &&
            eliminado == false
        }
        def turnados = turnadosQuery.list(sort:"id")
        
        render (
            view: "list", 
            model: [
                tareaInstanceList: taskList, 
                tareaInstanceTotal: taskList.size(),
                sharedTaskList : sharedTaskList,
                sharedTaskTotal : sharedTaskList.size(),
                turnadosList : turnados,
                turnadosTotal : turnados.size()
            ]
        )
    }
    /**
     * Bandeja de turnos pestaña Retrasadas.
     */
    def retrasadas () {
        session.opt = params.action
        flash.warn = null
        //Mis turnos        
        def taskListQuery = Tarea.where {
            fechaLimite < (new Date() - 1) &&
            cerrada == false &&
            responsable == springSecurityService.currentUser && 
            eliminado == false
        }
        def taskList = taskListQuery.list(sort:"id")
        
        //Compartidos
        def usuariosDeTarea = UsuarioDeTarea.findAllByUsuarioAndOwner(springSecurityService.currentUser, false)
        def sharedTaskList = usuariosDeTarea*.tarea        
        sharedTaskList = sharedTaskList.findAll {
            it.fechaLimite < (new Date() - 1) &&
            it.cerrada == false &&
            it.responsable != springSecurityService.currentUser &&
            it.creadaPor != springSecurityService.currentUser &&
            it.eliminado == false
        }
        
        //Turnados
        def turnadosQuery = Tarea.where {
            fechaLimite < (new Date() - 1) &&
            cerrada == false &&
            responsable != springSecurityService.currentUser &&
            creadaPor == springSecurityService.currentUser &&
            eliminado == false
        }
        def turnados = turnadosQuery.list(sort:"id")
        
        render (
            view: "list", 
            model: [
                tareaInstanceList: taskList, 
                tareaInstanceTotal: taskList.size(),
                sharedTaskList : sharedTaskList,
                sharedTaskTotal : sharedTaskList.size(),
                turnadosList : turnados,
                turnadosTotal : turnados.size()
            ]
        )
    }
    /**
     * Bandeja de turnos pestaña Concluidas.
     */
    def concluidas () {
        session.opt = params.action
        
        //Mis turnos        
        def taskListQuery = Tarea.where {
            cerrada == true &&
            responsable == springSecurityService.currentUser &&
            eliminado == false
        }
        def taskList = taskListQuery.list(sort:"id")
        
        //Compartidos
        def usuariosDeTarea = UsuarioDeTarea.findAllByUsuarioAndOwner(springSecurityService.currentUser, false)
        def sharedTaskList = usuariosDeTarea*.tarea        
        sharedTaskList = sharedTaskList.findAll {
            it.cerrada == true &&
            it.responsable != springSecurityService.currentUser &&
            it.creadaPor != springSecurityService.currentUser &&
            it.eliminado == false
        }
        
        //Turnados
        def turnadosQuery = Tarea.where {
            cerrada == true &&
            responsable != springSecurityService.currentUser &&
            creadaPor == springSecurityService.currentUser &&
            eliminado == false
        }
        def turnados = turnadosQuery.list(sort:"id")
        
        render (
            view: "list", 
            model: [
                tareaInstanceList: taskList, 
                tareaInstanceTotal: taskList.size(),
                sharedTaskList : sharedTaskList,
                sharedTaskTotal : sharedTaskList.size(),
                turnadosList : turnados,
                turnadosTotal : turnados.size()
            ]
        )
    }
    /**
     * Bandeja de turnos para el modulo de convenios de turnos asiganados.
     */
    def asignacionConvenios() {
        flash.warn = null
        session.opt = params.action
        
        //Mis turnos        
        def taskListQuery = Tarea.where {            
            //fechaLimite > new Date() &&
            cerrada == false &&
            responsable == springSecurityService.currentUser &&
            eliminado == false
        }
        def taskList = taskListQuery.list(sort:"id")
                        
        render (
            view: "asignacionConvenios", 
            model: [
                tareaInstanceList: taskList, 
                tareaInstanceTotal: taskList.size()                
            ]
        )
    }
    /**
     * Historial de tarea.
     */
    def historial (Long id) {
        def tareaInstance = Tarea.get(id)
        [ tareaInstance : tareaInstance, histList : HistorialDeTarea.findAllByTarea(tareaInstance)]
    }
    /**
     * Método apara enlistar los registros existentes en una domain class 
     */
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [tareaInstanceList: Tarea.list(params), tareaInstanceTotal: Tarea.count()]
    }
    /**
     * Este método sirve para la creacion de un registro de tipo tarea.
     */
    def create() {
        
        def usuariosList = null
        def usuarioStandard = null
        
        if (params.idConvenio) {
            session.idConvenio = params.idConvenio as long
            def convenioInstance = Convenio.get(params.idConvenio as long)        
            if(!convenioInstance.responsables || !convenioInstance.firmantes){                
                flash.warn = "Debe agregar al menos un responsable y un firmante para poder turnar el convenio"
                redirect(controller: "convenio", action: "edit", id: session.idConvenio)                
            }
            
            //se buscan los usuarios parea este modulo para q aparezcan en la lista
            usuariosList = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_CONVENIOS_ADMIN")).collect {it.usuario}
            usuarioStandard = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_CONVENIOS_STANDARD")).collect {it.usuario}
        
            usuariosList = usuariosList + usuarioStandard
            //se quita el usuario que esta logueado en el sistema
            usuariosList = usuariosList - springSecurityService.currentUser
            
        } else {
            session.idConvenio = null
        }
        if (params.idOtorgamientoDePoder) {
            session.idOtorgamientoDePoder = params.idOtorgamientoDePoder as long
        } else {
            session.idOtorgamientoDePoder = null
        }
        if (params.idRevocacionDePoder) {
            session.idRevocacionDePoder = params.idRevocacionDePoder as long
        } else {
            session.idRevocacionDePoder = null
        }
        if (!params.idConvenio && !params.idOtorgamientoDePoder && !params.idRevocacionDePoder){
            
            //se buscan los usuarios parea este modulo para q aparezcan en la lista
            usuariosList = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_TURNOS_ADMIN")).collect {it.usuario}
            usuarioStandard = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_TURNOS_STANDARD")).collect {it.usuario}
        
            usuariosList = usuariosList + usuarioStandard
            //se quita el usuario que esta logueado en el sistema
            usuariosList = usuariosList - springSecurityService.currentUser            
        }                             
        
        [tareaInstance: new Tarea(params), usuariosList : usuariosList]        
    }
    /**
     * Método para guardar los registros en el sistema.
     */
    def save() {
        if(session.idOtorgamientoDePoder){
            params.fechaLimite = null
            params.prioridad = "Normal"
            params.alertaVencimiento = "0"
            params.grupo = Grupo.get(1 as long)
            def responsable = Usuario.get(session.idOtorgamientoDePoder as long)
            params.responsable = responsable            
            
        }
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        Date fechaLimite = null
        if (params.fechaLimite) {
            fechaLimite = sdf.parse(params.fechaLimite)
        }
        params.fechaLimite = fechaLimite
        params.creadaPor = springSecurityService.currentUser
        params.asignadaA = springSecurityService.currentUser
        def tareaInstance = new Tarea(params)
        if (!tareaInstance.save(flush: true)) {
            
            if (session.idConvenio)  {                                                
                def usuariosList = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_CONVENIOS_ADMIN")).collect {it.usuario}     
                def usuariosListEstandard = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_CONVENIOS_STANDARD")).collect {it.usuario}     
                usuariosList = usuariosList + usuariosListEstandard
             
                render(view: "create", model: [tareaInstance: tareaInstance, usuariosList : usuariosList])
                return
                                                                                
            }else{                            
                //se buscan los usuarios parea este modulo para q aparezcan en la lista               
                def usuariosList = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_TURNOS_ADMIN")).collect {it.usuario}
                def usuarioStandard = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_TURNOS_STANDARD")).collect {it.usuario}        
                usuariosList = usuariosList + usuarioStandard
                //se quita el usuario que esta logueado en el sistema
                usuariosList = usuariosList - springSecurityService.currentUser
                
                render(view: "create", model: [tareaInstance: tareaInstance, usuariosList : usuariosList])
                return
            }
        }

        //Se agrega el que lo creó como dueño y se le comparte por default
        def creadaPor = new UsuarioDeTarea()
        creadaPor.usuario = springSecurityService.currentUser
        creadaPor.owner = true
        creadaPor.tarea = tareaInstance
        creadaPor.save(flush:true)
        
        //Si el responsable es distinto al creador, se le asigna        
        if(params.responsable){                    
            if (params.responsable.id as long != springSecurityService.currentUser.id) {
                def responsable = new UsuarioDeTarea()            
                responsable.usuario = Usuario.get(params.responsable.id as long)
                responsable.owner = false
                responsable.tarea = tareaInstance
                if (responsable.save(flush:true)) {
                    //notificacionesService.tareaAsignada(tareaInstance, responsable.usuario)
                    String stringId = tareaInstance.id 
                    AmazonSES enviarEmail = new AmazonSES()
                    enviarEmail.sendMail(responsable.usuario.email,responsable.usuario.firstName +" "+ responsable.usuario.lastName, "SGCON --Asignación de Tarea", "Tienes un nuevo Turno asignado", stringId, "Creador del Turno: " + tareaInstance.creadaPor.firstName +" "+ tareaInstance.creadaPor.lastName, "Nombre del Turno: " + tareaInstance.nombre)                                
                }
            } 
        }
        
        //Integración con Convenios
        if (session.idConvenio) {
            def convenioInstance = Convenio.get(session.idConvenio)
            convenioInstance.addToTareas(tareaInstance).save(flush:true)
            def usuarioInstance = Usuario.get(params.responsable.id as long)            
            historialDeConvenioService.addTurnosToHistorial(usuarioInstance, convenioInstance,null,"Se turnó el Convenio al usuario:")
        }
        //Integración con Otorgamiento De Poder
        if (session.idOtorgamientoDePoder){
            def otorgamientoDePoderInstance = OtorgamientoDePoder.get(session.idOtorgamientoDePoder)
            def userActual = springSecurityService.currentUser
            List<Rol> currentUserRoles = UsuarioRol.findByUsuario(userActual).collect { it.rol } as List 
            
            def userSolicitante = otorgamientoDePoderInstance.creadaPor        
            List<Rol> currentRolUsers = UsuarioRol.findByUsuario(userSolicitante).collect { it.rol } as List 
            
            //se cambia el status de c/u de los apoderados al cancelar la solicitud
            otorgamientoDePoderInstance.apoderados.each{apoderado ->
                apoderado.statusDePoder = 'Cancelado'
            }
            otorgamientoDePoderInstance.fechaDeEnvio = new Date()
            otorgamientoDePoderInstance.save()
            
            if(currentUserRoles.authority.contains("ROLE_GESTOR_EXTERNO")) {
                otorgamientoDePoderInstance.asignar = otorgamientoDePoderInstance.creadaPor
                otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
                otorgamientoDePoderInstance.addToTareas(tareaInstance).save(flush:true)  
                println "entro al primer if"
            }else if(currentRolUsers.authority.contains("ROLE_SOLICITANTE_EXTERNO")){
                def usuarioExterno = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_GESTOR_EXTERNO")).collect {it.usuario}                
                usuarioExterno.each { usuarioFac ->
                    otorgamientoDePoderInstance.asignar = usuarioFac       
                }                
                otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
                otorgamientoDePoderInstance.addToTareas(tareaInstance).save(flush:true)
                println "entro al segundo if"
            }else{
                otorgamientoDePoderInstance.asignar = otorgamientoDePoderInstance.creadaPor
                otorgamientoDePoderInstance.asignadaPor = springSecurityService.currentUser
                otorgamientoDePoderInstance.addToTareas(tareaInstance).save(flush:true)
                println "entro al tecer if"
            }
            
        }
        //Integración con Revocación De Poder
        if (session.idRevocacionDePoder){
            def revocacionDePoderInstance = RevocacionDePoder.get(session.idRevocacionDePoder)            
            revocacionDePoderInstance.addToTareas(tareaInstance).save(flush:true)
        }
        
        //validacion para la busqueda por tags
        if(tareaInstance.tags){
            if(tareaInstance.tags.endsWith(",")){
                params.tags = params.tags.substring(0, params.tags.length() -1)
            }else {
                tareaInstance.tags = tareaInstance.tags + "," 
            }
        }
        //end busqueda tags
        
        if(!session.idOtorgamientoDePoder){            
            historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "creó un turno")        
            flash.message = message(code: 'default.created.message', args: [message(code: 'tarea.label', default: 'Turno'), tareaInstance.id])
            redirect(action: "show", id: tareaInstance.id)        
        }else{            
            flash.info = "Se ha enviado la Nofificacion al Solicitante."
            redirect(controller: "poderes", action: "index", id: session.idOtorgamientoDePoder)            
        }
    }    
    /**
     * Método para visualizar el registro creado en el sistema.
     */
    def show(Long id) {
        if (params.idConvenio) {
            session.idConvenio = params.idConvenio as long
        } else {
            session.idConvenio = null
        }
        if (params.idOtorgamientoDePoder) {
            session.idOtorgamientoDePoder = params.idOtorgamientoDePoder as long
        } else {
            session.idOtorgamientoDePoder = null
        }
        if (params.idRevocacionDePoder) {
            session.idRevocacionDePoder = params.idRevocacionDePoder as long
        } else {
            session.idRevocacionDePoder = null
        }
        def tareaInstance = Tarea.get(id)
        
        if(!session.idOtorgamientoDePoder){
            if(tareaInstance.fechaLimite){
                def fechaHoy = new Date()
                def fechaLimite = tareaInstance.fechaLimite
                def alertaVencimiento = tareaInstance.alertaVencimiento
                TimeDuration tiempo = TimeCategory.minus(fechaLimite, fechaHoy)
                if(tiempo.days == (alertaVencimiento as int) && !tareaInstance.notas){
                    flash.warn = "El Turno aun no ha sido Atendido."
                }else{
                    flash.warn = null 
                }  
            }
        }
               
        if (tareaInstance.creadaPor != springSecurityService.currentUser) {
            historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "abrió un turno")
        }
        
        if(tareaInstance.creadaPor == springSecurityService.currentUser){
            def owner = false            
        }else{
            def owner = true            
        } 
        
        //opcion para verificar que el responsable abrio el turno
        if(tareaInstance.responsable == springSecurityService.currentUser){
            tareaInstance.check_responsable = true            
            tareaInstance.save(flush:true)                        
        }        
        
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "list")
            return
        }
        
        [tareaInstance: tareaInstance, currentUser : springSecurityService.currentUser, owner:params.owner]
    }
    /**
     * Método para editar un registro.
     */
    def edit(Long id) {
        def tareaInstance = Tarea.get(id)
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "list")
            return
        }
        def usuariosConveniosList = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_CONVENIOS")).collect {it.usuario}

        [tareaInstance: tareaInstance, usuariosConveniosList : usuariosConveniosList]
    }
    /**
     * Método para actualizar los datos de un registro.
     */
    def update(Long id, Long version) {
        
        def tareaInstance = Tarea.get(id)
               
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (tareaInstance.version > version) {
                tareaInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'tarea.label', default: 'Turno')] as Object[],
                          "Another user has updated this Tarea while you were editing")
                render(view: "edit", model: [tareaInstance: tareaInstance])
                return
            }
        }

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        params.fechaLimite = params.fechaLimite!=""?sdf.parse(params.fechaLimite):null
        tareaInstance.properties = params
        
        //validacion para la busqueda por tags
        if(tareaInstance.tags){
            if(tareaInstance.tags.endsWith(",")){
                params.tags = params.tags.substring(0, params.tags.length() -1)
            }else {
                tareaInstance.tags = tareaInstance.tags + "," 
            }
        }
        //end busqueda tags                

        if (!tareaInstance.save(flush: true)) {
            render(view: "edit", model: [tareaInstance: tareaInstance])
            return
        }

        //notificacionesService.tareaAsignada(tareaInstance, tareaInstance.creadaPor)
        String stringId = tareaInstance.id        
        AmazonSES enviarEmail = new AmazonSES()
        enviarEmail.sendMail(tareaInstance.creadaPor.email,tareaInstance.creadaPor.firstName +" "+ tareaInstance.creadaPor.firstName, "SGCON --Se editó un Turno", "Se realizarón modificaciones en el Turno", stringId, "Creador del Turno: " + tareaInstance.creadaPor.firstName +" "+ tareaInstance.creadaPor.lastName, "Nombre del Turno: " + tareaInstance.nombre)                
        historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "editó un turno")
        flash.message = message(code: 'default.updated.message', args: [message(code: 'tarea.label', default: 'Turno'), tareaInstance.id])
        redirect(action: "show", id: tareaInstance.id)
    }
    /**
     * Método para eliminar el registro del sistema.
     */
    def delete(Long id) {
        def tareaInstance = Tarea.get(id)       
        if (!tareaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "list")
            return
        }

        try {
            //tareaInstance.delete(flush: true)
            tareaInstance.eliminado = true            
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "hoy")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'tarea.label', default: 'Turno'), id])
            redirect(action: "show", id: id)
        }
    }
    /**
     * Método para compartir una tarea.
     */
    def share (Long id) {
        def tareaInstance = Tarea.get(id)
        def usuariosTurnosList = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_TURNOS_ADMIN")).collect {it.usuario}
        def list2 = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_TURNOS_STANDARD")).collect {it.usuario}    
        usuariosTurnosList = usuariosTurnosList + list2
        usuariosTurnosList = usuariosTurnosList - springSecurityService.currentUser
        [ tareaInstance : tareaInstance, usuariosTurnosList : usuariosTurnosList ]
    }
    /**
     * Método para agregar compartir la tarea con los usuarios.
     */
    def addUsuarioToTarea(Long id) {
        def tareaInstance = Tarea.get(id)        
        def compartirCon = Usuario.get(params.compartidoCon.id as long)
        def lista = tareaInstance.usuariosDeTarea
        def existe = false
        lista.each {
            if (it.usuario.id == compartirCon.id) {
                existe = true
            }
        }
        if (!existe) {
            def usuarioDeTarea = new UsuarioDeTarea()
            usuarioDeTarea.usuario = compartirCon
            usuarioDeTarea.owner = false
            usuarioDeTarea.tarea = tareaInstance
            if (usuarioDeTarea.save(flush:true)) {            
                //notificacionesService.tareaCompartida(tareaInstance, usuarioDeTarea.usuario)
                String stringId = tareaInstance.id
                AmazonSES enviarEmail = new AmazonSES()
                enviarEmail.sendMail(usuarioDeTarea.usuario.email, usuarioDeTarea.usuario.firstName +" "+ usuarioDeTarea.usuario.lastName, "SGCon: Tienes un nuevo turno compartido.", "Se te ha compartido un nuevo Turno", stringId, "Creador del Turno: " + tareaInstance.creadaPor.firstName +" "+ tareaInstance.creadaPor.lastName, "Nombre del Turno: " + tareaInstance.nombre)                
            }
            flash.message = "Tarea compartida satisfactoriamente."
        } else {
            flash.warn = "Ya se encuentra compartida con el usuario seleccionado."
        }
        redirect (action:"share", params : [ id : tareaInstance.id ])
    }
    /**
     * Método para dejar de compartir una tarea con los usuarios.
     */
    def removeUsuarioFromTarea() {
        def tareaInstance = Tarea.get(params.tareaId as long)
        def usuario = Usuario.get(params.usuarioId as long)
        def usuarioDeTarea = UsuarioDeTarea.findByTareaAndUsuario(tareaInstance, usuario)
        usuarioDeTarea.delete()
        redirect (action:"share", params : [ id : tareaInstance.id ])
    }
    /**
     * Método para la navegacion entre pantallas.
     */
    def regresar(Long id) {
        redirect(action: "show", id: id)
    }
    /**
     * Método para cerrar una tarea.
     */
    def cerrarTarea (Long id) {
        def tareaInstance = Tarea.get(id)
        tareaInstance.cerrada = true
        if (tareaInstance.save(flush:true)) {
            def usuariosDeTarea = tareaInstance.usuariosDeTarea
            usuariosDeTarea.each { it ->
                //notificacionesService.tareaCerrada(tareaInstance, it.usuario)
                String stringId = tareaInstance.id
                AmazonSES enviarEmail = new AmazonSES()
                enviarEmail.sendMail(it.usuario.email, it.usuario.firstName +" "+ it.usuario.lastName, "SGCon: El turno ${tareaInstance.id} ha sido cerrado.", "El turno ha sido cerrado.", stringId, "Creador del Turno: " + tareaInstance.creadaPor.firstName +" "+ tareaInstance.creadaPor.lastName,"Nombre del Turno: " + tareaInstance.nombre)                
            }
            historialDeTareaService.agregar(tareaInstance, springSecurityService.currentUser, "concluyó un turno")
            flash.message = "La tarea fue cerrada satisfactoriamente."            
        } else {
            flash.message = "No se pudo cerrar la tarea. Intente nuevamente."
        }
        redirect (action:"show", id:tareaInstance.id)
    }    
    /**
     * Método para las notificacion por correo electrónico.
     */
    def notificationByEmail () {
        def message = "Tienes una nueva tarea asignada."
        [ tareaInstance : Tarea.get(1), message : message, usuarioInstance : springSecurityService.currentUser ]
    }
    /**
     * Método para consultas.
     */
    def consultaTarea() {
        flash.error = null
        flash.info = null
        flash.message = null
        flash.warn = null
        [porTagsActive:"active"]  
    }
    /**
     * Método para busquedas por folio.
     */
    def buscarPorFolio (){
        flash.warn = null
        def porFolioActive = null
        if (params.inActive=="porFolio") {
            porFolioActive = "active"
        }        
        def tareaInstanceList = []
        def inActive = "active"
        if(params.id?.isInteger()){
            tareaInstanceList = Tarea.findAllByIdAndEliminado(params.id, false) 
        }else{
            flash.warn = "Valor no válido. El campo debe contener sólo Números Enteros."
        }   
        session.tareaInstanceList = tareaInstanceList
        session.inActive = inActive
        render(
            view: "consultaTarea", 
            model: [
                tareaInstanceList: tareaInstanceList,
                tareaInstanceTotal: tareaInstanceList.size(),
                id: params.id,
                porFolioActive : porFolioActive
                
            ]
        )  
    }
    /**
     * Método para busquedas por fecha de registro.
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
        def tareaInstanceList = []
        if (params.rangoDeFechaRegistro != "") {
            flash.warn = null
            rangoDeFechaRegistro = params.rangoDeFechaRegistro
            fechaInicio = sdf.parse(rangoDeFechaRegistro.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFechaRegistro.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            tareaInstanceList = Tarea.findAllByDateCreatedBetweenAndEliminado(busquedaBean.fechaInicio, busquedaBean.fechaFin, false, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        session.tareaInstanceList = tareaInstanceList
        render(
            view: "consultaTarea", 
            model: [
                tareaInstanceList: tareaInstanceList, 
                tareaInstanceTotal: tareaInstanceList.size(),
                busquedaBean : busquedaBean,
                rangoDeFechaRegistro : params.rangoDeFechaRegistro,
                porFechaRegistroActive : porFechaRegistroActive
            ]
        )
    }
    /**
     * Método para crear un rango de fechas a partir de las fechas seleccionadas en el calendario del formulario.
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
        def tareaInstanceList = []        
        if (params.rangoDeFecha != "") {
            flash.warn = null
            rangoDeFecha = params.rangoDeFecha
            fechaInicio = sdf.parse(rangoDeFecha.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFecha.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            tareaInstanceList = Tarea.findAllByFechaLimiteBetweenAndEliminado(busquedaBean.fechaInicio, busquedaBean.fechaFin, false, [sort: "id", order: "asc"])
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
        session.tareaInstanceList = tareaInstanceList
        render(
            view: "consultaTarea", 
            model: [
                tareaInstanceList: tareaInstanceList, 
                tareaInstanceTotal: tareaInstanceList.size(),
                busquedaBean : busquedaBean,
                rangoDeFecha : params.rangoDeFecha,
                rangoDeFechaActive : rangoDeFechaActive
            ]
        )
    }
    /**
     * Método para busquedas por nombre de responsable.
     */
    def buscarPorNombreResponsables (){
        def nombreResponsablesActive = null
        if (params.inActive=="nombreResponsables") {
            nombreResponsablesActive = "active"
        }         
        def c = Tarea.createCriteria()
        def tareaInstanceList = c.list {
            eq("eliminado", false)
            and{
                responsable {
                    ilike("firstName", "%"+params.nombre+"%")               
                }
            }
            order("id", "asc")
        }
        session.tareaInstanceList = tareaInstanceList
        render(
            view: "consultaTarea", 
            model: [
                tareaInstanceList: tareaInstanceList,
                tareaInstanceTotal: tareaInstanceList.size(),
                nombreResponsablesActive : nombreResponsablesActive       
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
       
        //def s = params.tags.toString().replaceAll(" ", ",")
        //def resultList = s.tokenize(",")
        //def tareaInstanceList =[]         
        /*resultList.each{ algo -> 
        println "it: "+ algo
        def results = Tarea.findAllByTagsIlikeAndEliminado("%"+algo+",%", false, [sort: "id", order: "asc"])
        tareaInstanceList = tareaInstanceList + results as Set    
        println "tareaInstanceList: " + tareaInstanceList
        }*/        
        def tareaInstanceList = Tarea.findAllByTagsIlikeAndEliminado("%"+params.tags+"%", false, [sort: "id", order: "asc"])
                
        session.tareaInstanceList = tareaInstanceList       
        render(
            view: "consultaTarea", 
            model: [
                tareaInstanceList: tareaInstanceList,
                tareaInstanceTotal: tareaInstanceList.size(),
                porTagsActive : porTagsActive       
            ]
        )       
    }
    /**
     * Método para generar reporte de consultas.
     */
    def generarReporte(){        
        def tareaInstanceList = session.tareaInstanceList
        def inActive = session.inActive
        log.info "activo:." + session.inActive
        log.info "total::." + session.tareaInstanceList.size()
        log.info "params::::::::::::::::"+ params
        log.info "tareainstance::::::"+ session.tareaInstanceList
        if (tareaInstanceList.size() != 0) {
            log.info "despues del if::::::"+ tareaInstanceList
            flash.warn = null
            if(params?.format && params.format != "html"){
                response.contentType = grailsApplication.config.grails.mime.types[params.format]
                response.setHeader("Content-disposition", "attachment; filename= Turnos.${params.extension}")
                List fields = ["id", "nombre", "grupo", "dateCreated", "responsable", "descripcion", "prioridad","fechaLimite"]
                Map labels = ["id": "Número de Turno", "nombre": "Nombre","grupo":"Compartida con","dateCreated":"Fecha de Registro",\
                              "responsable":"Responsable","descripcion":"Descripción","prioridad":"Prioridad","fechaLimite":"Fecha Limite del Turno"]
                def upperCase = { domain, value ->
                    return value.toUpperCase()
                }
                Map formatters = [nombre: upperCase]		
                Map parameters = [title: "Reporte De Turnos", "column.widths": [0.2, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4], "title.font.size":12]

                exportService.export(params.format, response.outputStream, session.tareaInstanceList, fields, labels, formatters, parameters)
            }
        }else{
            log.info "<<<aaaaaaaaaaaaaaaaa" 
            flash.warn = "No hay datos para generar reporte."
            
        }
        render(
            view: "consultaTarea", 
            model: [inActive: inActive, tareaInstanceList: tareaInstanceList ]
        )  
    }
    /**
     * Método para visualizar todos los campos con su valor de una tarea.
     */
    def detalles(Long id){
        def tareaInstance = Tarea.get(id)
        log.info "id de tarea "+ id
        [ tareaInstance : tareaInstance ]
    }
    
}
