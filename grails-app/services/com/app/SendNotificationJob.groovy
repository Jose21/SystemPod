package com.app

import grails.plugin.asyncmail.AsynchronousMailService
import groovy.time.TimeDuration
import groovy.time.TimeCategory

import com.app.sgtask.Tarea
import com.app.NotificacionesService
import com.app.security.Usuario
import com.app.sgpod.OtorgamientoDePoder
import com.app.sgpod.ConfigurarParametro
import com.app.ses.AmazonSES

class SendNotificationJob {

    def grailsApplication
    AsynchronousMailService asyncMailService
    NotificacionesService notificacionesService
    
    static triggers = {
        cron name: 'notification', cronExpression: "0 05 09 * * ?"
        //intervalo de 60 segundos
        //simple name: 'mySimpleTrigger', startDelay: 60000, repeatInterval: 60000
    }

    def execute() {
        log.info "Inicializando trabajo de Notificaciones..."
        println "Inicializando trabajo de Notificaciones..."
        //NOTIFICACIONES DEL MÓDULO DE TAREAS
        println "Tareas"
        def fechaHoy = new Date()
        def tareaList = Tarea.list()
        def enviarCorreo = null
        def contador = 0
        tareaList.each { tarea ->
            if(tarea.alertaVencimiento != 0){
                def fechaLimite = tarea.fechaLimite
                def alertaVencimiento = tarea.alertaVencimiento
                TimeDuration tiempo = TimeCategory.minus(fechaLimite, fechaHoy)
                println "tiempo entre intervalo  "+ tiempo.days
                println "alerta en dias: " + alertaVencimiento
                if((tiempo.days as int) <= (alertaVencimiento as int) && !tarea.notas){
                    //notificacionesService.tareaPorVencer(tarea, tarea.creadaPor)
                    //notificacionesService.tareaPorVencer(tarea, tarea.responsable)
                    AmazonSES enviarEmail = new AmazonSES()
                    enviarEmail.sendMail(tarea.creadaPor.email,"SGCon: El turno ${tarea.id} no ha sido atendido.", "Folio: ${tarea?.id} ,Creador del Turno: ${tarea?.creadaPor?.firstName} ${tarea?.creadaPor?.lastName}, Asunto: ${tarea?.nombre}")                                
                    AmazonSES enviarEmail2 = new AmazonSES()
                    enviarEmail2.sendMail(tarea.responsable.email,"SGCon: El turno ${tarea.id} no ha sido atendido.", "Folio: ${tarea?.id} ,Creador del Turno: ${tarea?.creadaPor?.firstName} ${tarea?.creadaPor?.lastName}, Asunto: ${tarea?.nombre}")                                
                    
                    println "Correo Enviado de Turno aun no atendido"
                }else{
                    println "No se envia correo"
                }
                if(tiempo.days <= (alertaVencimiento as int) && tarea.notas){
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
                    AmazonSES enviarEmail = new AmazonSES()
                    enviarEmail.sendMail(tarea.creadaPor.email,"SGCon: El turno ${tarea.id} esta por vencer.", "Folio: ${tarea?.id} ,Creador del Turno: ${tarea?.creadaPor?.firstName} ${tarea?.creadaPor?.lastName}, Asunto: ${tarea?.nombre}")                                
                    AmazonSES enviarEmail2 = new AmazonSES()
                    enviarEmail2.sendMail(tarea.responsable.email,"SGCon: El turno ${tarea.id} esta por vencer.", "Folio: ${tarea?.id} ,Creador del Turno: ${tarea?.creadaPor?.firstName} ${tarea?.creadaPor?.lastName}, Asunto: ${tarea?.nombre}")                                
                    println "se envia correo desde la bandera enviar correo"
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
        def parameters = ConfigurarParametro.get(1 as long)
        listaPoderes.each {otorgamientoDePoder ->
            if(otorgamientoDePoder.fechaVencimiento){                
                def fechaVencimiento = otorgamientoDePoder.fechaVencimiento                
                def diasParaVencimiento = fechaVencimiento - fechaHoy                
                if(diasParaVencimiento <= parameters.estadoCriticoPoder){
                    poderCriticoList.add(otorgamientoDePoder)
                    //notificacionesService.poderPorVencer(otorgamientoDePoder, otorgamientoDePoder.responsable)
                    //notificacionesService.poderPorVencer(otorgamientoDePoder, otorgamientoDePoder.creadaPor)
                    AmazonSES enviarEmail = new AmazonSES()
                    enviarEmail.sendMail(otorgamientoDePoder.responsable.email,"SGCon: El Otorgamiento de Poder ${otorgamientoDePoder.id}-O está por expirar.", "Folio: ${otorgamientoDePoder?.id}-O ,Solicitado Por: ${otorgamientoDePoder?.creadaPor}")                                
                    AmazonSES enviarEmail2 = new AmazonSES()
                    enviarEmail2.sendMail(otorgamientoDePoder.creadaPor.email,"SGCon: El Otorgamiento de Poder ${otorgamientoDePoder.id}-O está por expirar.", "Folio: ${otorgamientoDePoder?.id}-O ,Solicitado Por: ${otorgamientoDePoder?.creadaPor}")                                
                    println "se envia correo critico"
                }else if(diasParaVencimiento <= parameters.estadoSemiPoder && diasParaVencimiento > parameters.estadoCriticoPoder ){
                    poderSemicriticoList.add(otorgamientoDePoder)
                    //notificacionesService.poderPorVencer(otorgamientoDePoder, otorgamientoDePoder.responsable)
                    //notificacionesService.poderPorVencer(otorgamientoDePoder, otorgamientoDePoder.creadaPor)
                    AmazonSES enviarEmail = new AmazonSES()
                    enviarEmail.sendMail(otorgamientoDePoder.responsable.email,"SGCon: El Otorgamiento de Poder ${otorgamientoDePoder.id}-O está por expirar.", "Folio: ${otorgamientoDePoder?.id}-O ,Solicitado Por: ${otorgamientoDePoder?.creadaPor}")                                
                    AmazonSES enviarEmail2 = new AmazonSES()
                    enviarEmail2.sendMail(otorgamientoDePoder.creadaPor.email,"SGCon: El Otorgamiento de Poder ${otorgamientoDePoder.id}-O está por expirar.", "Folio: ${otorgamientoDePoder?.id}-O ,Solicitado Por: ${otorgamientoDePoder?.creadaPor}")                                
                    println "se envia correo semi-critico"
                }
                println "no se envia correo poderes"
            }            
        }               
        println "Envío de Notificaciones Finalizado."
    }
}
