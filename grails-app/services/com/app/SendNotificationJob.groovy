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
        //simple name: 'mySimpleTrigger', startDelay: 60000, repeatInterval: 60000
    }

    def execute() {
        log.info "Inicializando trabajo de Notificaciones..."
        def fechaHoy = new Date()
        def tareaList = Tarea.list()
        tareaList.each { it ->
            def fechaLimite = it.fechaLimite
            def alertaVencimiento = it.alertaVencimiento
            TimeDuration tiempo = TimeCategory.minus(fechaLimite, fechaHoy)
            log.info "tiempo entre intervalo  "+ tiempo.days
            //println "quien agrego la nota"+ it.notas.agregadaPor
            if(tiempo.days == (alertaVencimiento as int) && (it.notas.size() == 0)){
                notificacionesService.tareaPorVencer(it, it.creadaPor)
                notificacionesService.tareaPorVencer(it, it.responsable)
                log.info "Correo Enviado de Turno aun no atendido"
            }else{
                log.info "No se envia correo"
            }
        }
        log.info "Envío de Notificaciones Finalizado."
    }
}
