package com.app

import grails.plugin.asyncmail.AsynchronousMailService
import com.app.sgtask.Tarea
import com.app.security.Usuario

class NotificacionesService {

    AsynchronousMailService asyncMailService
        
    boolean tareaAsignada(Tarea tareaInstance, Usuario asignarA) {
        boolean flag = false
        def emailPattern = /[_A-Za-z0-9-]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})/
        //def email = params.alertaPorEmail.trim()
        def email = asignarA.email
        if (email ==~ emailPattern) { 
            asyncMailService.sendMail {
                to email
                subject "Tienes un nuevo turno asignado."
                html "<body><b>Te han asignado el turno con folio ${tareaInstance.id}.</b></body>"
            }
            flag = true
        } else {
            flag = false
        }
        flag
    }
    
    boolean tareaCompartida(Tarea tareaInstance, Usuario compartidaCon) {
        boolean flag = false
        def emailPattern = /[_A-Za-z0-9-]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})/
        //def email = params.alertaPorEmail.trim()
        def email = compartidaCon.email
        if (email ==~ emailPattern) { 
            asyncMailService.sendMail {
                to email
                subject "Tienes un nuevo turno compartido."
                html "<body><b>Te han compartido el turno con folio ${tareaInstance.id}.</b></body>"
            }
            flag = true
        } else {
            flag = false
        }
        flag
    }
    
    boolean tareaCerrada(Tarea tareaInstance, Usuario avisarA) {
        boolean flag = false
        def emailPattern = /[_A-Za-z0-9-]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})/
        //def email = params.alertaPorEmail.trim()
        def email = avisarA.email
        if (email ==~ emailPattern) { 
            asyncMailService.sendMail {
                to email
                subject "El turno ${tareaInstance.id} ha sido cerrado."
                html "<body><b>El turno con folio ${tareaInstance.id} fue cerrado.</b></body>"
            }
            flag = true
        } else {
            flag = false
        }
        flag
    }
}

