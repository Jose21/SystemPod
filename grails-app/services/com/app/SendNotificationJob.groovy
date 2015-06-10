package com.app

import grails.plugin.asyncmail.AsynchronousMailService
import groovy.time.TimeDuration
import java.text.SimpleDateFormat

import groovy.time.TimeCategory

import com.app.sgtask.Tarea
import com.app.NotificacionesService
import com.app.security.Usuario
import com.app.sgpod.OtorgamientoDePoder
import com.app.sgpod.ConfigurarParametro
import com.app.ses.AmazonSES
import com.app.security.Rol
import com.app.security.UsuarioRol
import com.app.sgpod.Apoderado
import grails.converters.JSON

class SendNotificationJob {

    def grailsApplication
    AsynchronousMailService asyncMailService
    NotificacionesService notificacionesService
    
    static triggers = {
        //cron name: 'notification', cronExpression: "0 05 09 * * ?"
        //intervalo de 60 segundos
        //simple name: 'mySimpleTrigger', startDelay: 120000, repeatInterval: 120000
    }

    def execute() {
        log.info "Inicializando trabajo de Notificaciones..."
        println "Inicializando trabajo de Notificaciones..."
        //NOTIFICACIONES DEL MÓDULO DE TAREAS
        log.info "Tareas"
        println "Tareas"
        def fechaHoy = new Date()        
        def taskList1 = Tarea.findAllByCerrada(false)
        def taskList2 = Tarea.findAllByEliminado(false)
        def tareaList = taskList1 + taskList2
        def enviarCorreo = null
             
        log.info "tareas: " + tareaList                
        log.info "total de tareas: " + tareaList.size()
        println "tareas: " + tareaList                
        println "total de tareas: " + tareaList.size()
        
        def contador = 0
        tareaList.each { tarea ->            
            if(tarea.alertaVencimiento != 0 && tarea.fechaLimite){
                println "Despues de alerta vencimiento"
                def fechaLimite = tarea.fechaLimite
                def alertaVencimiento = tarea.alertaVencimiento
                TimeDuration tiempo = TimeCategory.minus(fechaLimite, fechaHoy)
                println "tiempo entre intervalo  "+ tiempo.days
                println "alerta en dias: " + alertaVencimiento
                if((tiempo.days as int) <= (alertaVencimiento as int) && !tarea.notas && tarea.cerrada == false){
                    //notificacionesService.tareaPorVencer(tarea, tarea.creadaPor)
                    //notificacionesService.tareaPorVencer(tarea, tarea.responsable)
                    String stringId = tarea.id 
                    def responsable = tarea.responsable.firstName +" "+ tarea.responsable.lastName
                    AmazonSES enviarEmail = new AmazonSES()
                    enviarEmail.sendMail(tarea.creadaPor.email, tarea.creadaPor.firstName +" "+ tarea.creadaPor.lastName, "SGCon: El turno " + stringId + " no ha sido atendido.", "El turno no ha sido atendido. Usuario responsable: " + responsable, stringId ,"Creador del Turno: " + tarea.creadaPor.firstName +" "+ tarea.creadaPor.lastName, "Nombre del Turno: " + tarea.nombre)                                
                    AmazonSES enviarEmail2 = new AmazonSES()                                                   
                    enviarEmail2.sendMail(tarea.responsable.email, tarea.responsable.firstName +" "+ tarea.responsable.lastName, "SGCon: El turno " + stringId + " no ha sido atendido.", "El turno no ha sido atendido, favor de darle seguimiento", stringId, "Creador del Turno: " + tarea.creadaPor.firstName +" "+ tarea.creadaPor.lastName, "Nombre del Turno: " + tarea.nombre)                                
                    println "Correo Enviado de Turno aun no atendido"
                }else{
                    println "No se envia correo"
                }
                if(tiempo.days <= (alertaVencimiento as int) && tarea.notas && tarea.cerrada == false){
                    tarea.notas.each { nota ->
                        if(nota.agregadaPor != tarea.responsable){
                            //enviarCorreo = false
                            contador = contador + 1
                        }                        
                    }
                    println "contador: " + contador
                }
                if(contador == 0){
                    //notificacionesService.tareaPorVencer(tarea, tarea.creadaPor)
                    //notificacionesService.tareaPorVencer(tarea, tarea.responsable)
                    String stringId = tarea.id 
                    def responsable = tarea.responsable.firstName +" "+ tarea.responsable.lastName
                    AmazonSES enviarEmail = new AmazonSES()
                    enviarEmail.sendMail(tarea.creadaPor.email, tarea.creadaPor.firstName +" "+ tarea.creadaPor.lastName, "SGCon: El turno " + stringId + " no ha sido atendido.", "El turno no ha sido atendido. Usuario responsable: " + responsable, stringId ,"Creador del Turno: " + tarea.creadaPor.firstName +" "+ tarea.creadaPor.lastName, "Nombre del Turno: " + tarea.nombre)                                
                    AmazonSES enviarEmail2 = new AmazonSES()                                                   
                    enviarEmail2.sendMail(tarea.responsable.email,tarea.responsable.firstName +" "+ tarea.responsable.lastName, "SGCon: El turno " +stringId+ " no ha sido atendido.", "El turno no ha sido atendido, favor de darle seguimiento",stringId ,"Creador del Turno: " + tarea.creadaPor.firstName +" "+ tarea.creadaPor.lastName, "Nombre del Turno: " + tarea.nombre)                                
                    println "Correo Enviado de Turno aun no atendido"
                }else{
                    println "no se envia correo desde la bandera enviar correo"
                }
            }else{
                println "No se envia correo electronico porque es una tarea de otorgamiento de poder"
            }
        }
        //NOTIFICACIONES EN EL MÓDULO DE PODERES
        //Poderes que están por vencer
        println "Poderes"
        def listaPoderes = OtorgamientoDePoder.list()       
        def poderCriticoList = []
        def poderSemicriticoList = []
        def userGestor = null
        def userEnlace = null
        println "aaaa"
        //def usuarioGestorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_GESTOR")).collect {it.usuario}
        def usuarioGestorPoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_GESTOR")).collect {it.usuario}        
        usuarioGestorPoderes.each{
            userGestor = Usuario.get(it.id as long)   
        } 
        def usuarioEnlacePoderes = UsuarioRol.findAllByRol(Rol.findByAuthority("ROLE_PODERES_ENLACE")).collect {it.usuario} 
        usuarioEnlacePoderes.each{
            userEnlace = Usuario.get(it.id as long)   
        }           
        def parameters = ConfigurarParametro.get(1 as long)
        listaPoderes.each {otorgamientoDePoder ->
            if(otorgamientoDePoder.fechaVencimiento){  
                //newDate = new SimpleDateFormat("M-d-yyyy").format(date) 
                def fechaVencimiento1 = otorgamientoDePoder.fechaVencimiento                
                def diasParaVencimiento = fechaVencimiento1 - fechaHoy 
                def fechaVencimiento = new SimpleDateFormat("dd-MMM-yyyy").format(otorgamientoDePoder.fechaVencimiento)                
                String stringId = otorgamientoDePoder.id 
                //println "diasVencimiento: " + diasParaVencimiento
                if(diasParaVencimiento <= parameters.estadoCriticoPoder && diasParaVencimiento > 0){
                    //println "si paso a estado critico"
                    poderCriticoList.add(otorgamientoDePoder)
                    //notificacionesService.poderPorVencer(otorgamientoDePoder, otorgamientoDePoder.responsable)
                    //notificacionesService.poderPorVencer(otorgamientoDePoder, otorgamientoDePoder.creadaPor)                    
                    //mail para resolvedor
                    //AmazonSES enviarEmail = new AmazonSES()                    
                    //enviarEmail.sendMail(otorgamientoDePoder.responsable.email, otorgamientoDePoder.responsable.firstName +" "+ otorgamientoDePoder.responsable.lastName, "SGCon: Poder por vencer.", "El Otorgamiento de Poder: "+ stringId +"-O está por expirar.", stringId +"-O", "Solicitante: " + otorgamientoDePoder.creadaPor.firstName +" "+ otorgamientoDePoder.creadaPor.lastName, "Fecha de vencimiento: " + fechaVencimiento) 
                    //mail para gestor
                    //AmazonSES enviarEmail3 = new AmazonSES()
                    //enviarEmail3.sendMail(userGestor.email, userGestor.firstName +" "+ userGestor.lastName, "SGCon: Poder por vencer.", "El Otorgamiento de Poder: "+ stringId +"-O está por expirar.", stringId +"-O", "Solicitante: " + otorgamientoDePoder.creadaPor.firstName +" "+ otorgamientoDePoder.creadaPor.lastName, "Fecha de vencimiento: " + fechaVencimiento)                                
                    //mail para enlace
                    //AmazonSES enviarEmail4 = new AmazonSES()
                    //enviarEmail4.sendMail(userEnlace.email, userEnlace.firstName +" "+ userEnlace.lastName, "SGCon: Poder por vencer.", "El Otorgamiento de Poder: "+ stringId +"-O está por expirar.", stringId +"-O", "Solicitante: " + otorgamientoDePoder.creadaPor.firstName +" "+ otorgamientoDePoder.creadaPor.lastName, "Fecha de vencimiento: " + fechaVencimiento)                                                                                   
                    //println "se envia correo critico"
                }else if(diasParaVencimiento <= parameters.estadoSemiPoder && diasParaVencimiento > parameters.estadoCriticoPoder && diasParaVencimiento > 0){
                    //println "si paso a estado semicritico"
                    poderSemicriticoList.add(otorgamientoDePoder)
                    //notificacionesService.poderPorVencer(otorgamientoDePoder, otorgamientoDePoder.responsable)
                    //notificacionesService.poderPorVencer(otorgamientoDePoder, otorgamientoDePoder.creadaPor)  
                    //mail para el resolvedor                  
                    //AmazonSES enviarEmail = new AmazonSES()
                    //enviarEmail.sendMail(otorgamientoDePoder.responsable.email, otorgamientoDePoder.responsable.firstName +" "+ otorgamientoDePoder.responsable.lastName, "SGCon: Poder por vencer.", "El Otorgamiento de Poder: "+ stringId +"-O está por expirar.", stringId +"-O" ,"Solicitante: " + otorgamientoDePoder.creadaPor.firstName +" "+ otorgamientoDePoder.creadaPor.lastName, "Fecha de vencimiento: "+ fechaVencimiento)                                
                    //mail para gestor
                    //AmazonSES enviarEmail3 = new AmazonSES()
                    //enviarEmail3.sendMail(userGestor.email, userGestor.firstName +" "+ userGestor.lastName, "SGCon: Poder por vencer.", "El Otorgamiento de Poder: "+ stringId +"-O está por expirar.", stringId +"-O", "Solicitante: " + otorgamientoDePoder.creadaPor.firstName +" "+ otorgamientoDePoder.creadaPor.lastName, "Fecha de vencimiento: " + fechaVencimiento)                                
                    //mail para enlace
                    //AmazonSES enviarEmail4 = new AmazonSES()
                    //enviarEmail4.sendMail(userEnlace.email, userEnlace.firstName +" "+ userEnlace.lastName, "SGCon: Poder por vencer.", "El Otorgamiento de Poder: "+ stringId +"-O está por expirar.", stringId +"-O", "Solicitante: " + otorgamientoDePoder.creadaPor.firstName +" "+ otorgamientoDePoder.creadaPor.lastName, "Fecha de vencimiento: " + fechaVencimiento)
                    //println "se envia correo semicritico"
                }                
                
                if(diasParaVencimiento <= 15 && diasParaVencimiento > 0){
                    //mail para solicitante                                        
                    //AmazonSES enviarEmail2 = new AmazonSES()                    
                    //enviarEmail2.sendMail(otorgamientoDePoder.creadaPor.email, otorgamientoDePoder.creadaPor.firstName +" "+ otorgamientoDePoder.creadaPor.lastName, "SGCon: Poder por vencer.", "El Otorgamiento de Poder: "+ stringId +"-O está por expirar.", stringId +"-O" , "Solicitante: " + otorgamientoDePoder.creadaPor.firstName +" "+ otorgamientoDePoder.creadaPor.lastName,  "Fecha de vencimiento: " + fechaVencimiento)                    
                }    
                if(diasParaVencimiento == 0){
                    otorgamientoDePoder.apoderadosVigentes.each{apoderado ->
                        apoderado.statusDePoder = 'Vencido'
                        apoderado.save()
                        //println "Si se actualiza el status para el poder: " + otorgamientoDePoder                        
                    }
                }else{
                    //println "No se actualiza el status para el poder: " + otorgamientoDePoder 
                }
            }            
        }  
        def totalNotificaciones = poderCriticoList + poderSemicriticoList
        //println "totalNotificaciones: " + totalNotificaciones
                
        HashMap jsonMap = new HashMap()                
        jsonMap.poderes = totalNotificaciones.collect {poder ->
        return [id: poder.id, fechaVencimiento: poder.fechaVencimiento, solicitante: poder.creadaPor.firstName]
        }                                
        println jsonMap as JSON                
        
        def jsonStr = jsonMap.toString()
        
        println "jsonStr: " + jsonStr
        
        //nuevas notificaciones
        //mail para el resolvedor                  
        //AmazonSES enviarEmail21 = new AmazonSES()
        //enviarEmail21.sendMail(usuarioGestorPoderes.email, usuarioGestorPoderes.firstName +" "+ usuarioGestorPoderes.lastName, "SGCon: Reporte de Poderes por vencer.", "Lista de Poderes que están por expirar.", "pruebas", "seis", "siete")                                
        AmazonSES enviarEmail3 = new AmazonSES()
        enviarEmail3.sendMailDos(userGestor.email, userGestor.firstName +" "+ userGestor.lastName, "SGCon: Reporte de poderes por vencer.", "Lista de poderes que estan por vencer",  jsonStr)                                
        println "Envío de Notificaciones Finalizado."
    }
}
