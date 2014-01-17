package com.app

import grails.plugin.asyncmail.AsynchronousMailService
import groovy.time.TimeDuration
import groovy.time.TimeCategory

import com.app.sgtask.Tarea
import com.app.NotificacionesService
import com.app.security.Usuario

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
        def fechaHoy = new Date()
        def tareaList = Tarea.list()
        def enviarCorreo = null
        tareaList.each { tarea ->
            if(tarea.alertaDeVencimiento != 0){
                def fechaLimite = tarea.fechaLimite
                def alertaVencimiento = tarea.alertaVencimiento
                TimeDuration tiempo = TimeCategory.minus(fechaLimite, fechaHoy)
                log.info "tiempo entre intervalo  "+ tiempo.days
                if(tiempo.days == (alertaVencimiento as int) && !tarea.notas){
                    notificacionesService.tareaPorVencer(tarea, tarea.creadaPor)
                    notificacionesService.tareaPorVencer(tarea, tarea.responsable)
                    log.info "Correo Enviado de Turno aun no atendido"
                }else{
                    log.info "No se envia correo"
                }
                if(tiempo.days == (alertaVencimiento as int) && tarea.notas){
                    tarea.notas.each { nota ->
                        if(nota.agregadaPor != tarea.responsable){
                            enviarCorreo = true
                        }else{
                            enviarCorreo = false
                        }
                    }   
                }
                if(enviarCorreo == true){
                    notificacionesService.tareaPorVencer(tarea, tarea.creadaPor)
                    notificacionesService.tareaPorVencer(tarea, tarea.responsable)
                    log.info "se envia correo desde la bandera enviar correo"
                }else{
                    log.info "no se envia correo desde la bandera enviar correo"
                }
            }else{
                println "No se envia correo electronico porque es una tarea de otorgamiento de poder"
            }
        }
        log.info "Envío de Notificaciones Finalizado."
    }
}
