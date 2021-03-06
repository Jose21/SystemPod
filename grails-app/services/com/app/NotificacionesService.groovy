package com.app

import grails.plugin.asyncmail.AsynchronousMailService
import com.app.sgtask.Tarea
import com.app.security.Usuario
import com.app.sgpod.OtorgamientoDePoder

class NotificacionesService {

    AsynchronousMailService asyncMailService
    
    boolean tareaAsignada(Tarea tareaInstance, Usuario asignarA) {
        boolean flag = false
        def emailPattern = /[_A-Za-z0-9-]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})/
        //def email = params.alertaPorEmail.trim()
        def email = asignarA.email
        def message = "SGCon: Tienes un nuevo turno asignado."
        if (email ==~ emailPattern) { 
            asyncMailService.sendMail {
                to email
                subject message
                html (
                    view: "/tarea/notificationByEmail", 
                    model: [ 
                        tareaInstance : tareaInstance,
                        message : "",
                        usuarioInstance : asignarA
                    ]
                )
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
        //def message = "SGCon: Tienes un nuevo turno compartido."
        def message = "SGCon: El turno ${tareaInstance.id} no ha sido atendido."
        if (email ==~ emailPattern) { 
            asyncMailService.sendMail {
                to email
                subject message
                html (
                    view: "/tarea/notificationByEmail", 
                    model: [ 
                        tareaInstance : tareaInstance,
                        message : "",
                        usuarioInstance : compartidaCon
                    ]
                )
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
        def message = "SGCon: El turno ${tareaInstance.id} ha sido cerrado."
        if (email ==~ emailPattern) { 
            asyncMailService.sendMail {
                to email
                subject message
                html (
                    view: "/tarea/notificationByEmail", 
                    model: [ 
                        tareaInstance : tareaInstance,
                        message : "",
                        usuarioInstance : avisarA
                    ]
                )
            }
            flag = true
        } else {
            flag = false
        }
        flag
    }
    boolean tareaPorVencer(Tarea tareaInstance, Usuario avisarA) {
        boolean flag = false
        def emailPattern = /[_A-Za-z0-9-]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})/
        //def email = params.alertaPorEmail.trim()
        def email = avisarA.email
        def message = "SGCon: El turno ${tareaInstance.id} no ha sido atendido."
        if (email ==~ emailPattern) { 
            asyncMailService.sendMail {
                to email
                subject message
                html (
                    view: "/tarea/alertaVencimiento", 
                    model: [ 
                        tareaInstance : tareaInstance,
                        message : "",
                        usuarioInstance : avisarA
                    ]
                )
            }
            flag = true
        } else {
            flag = false
        }
        flag
    }
    boolean poderPorVencer(OtorgamientoDePoder otorgamientoDePoderInstance, Usuario avisarA) {
        boolean flag = false
        def emailPattern = /[_A-Za-z0-9-]+(\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\.[A-Za-z0-9]+)*(\.[A-Za-z]{2,})/
        //def email = params.alertaPorEmail.trim()
        def email = avisarA.email
        def message = "SGCon: El Otorgamiento de Poder ${otorgamientoDePoderInstance.id}-O está por expirar."
        if (email ==~ emailPattern) { 
            asyncMailService.sendMail {
                to email
                subject message
                html (
                    view: "/otorgamientoDePoder/alertaVencimiento", 
                    model: [ 
                        otorgamientoDePoder : otorgamientoDePoderInstance,
                        message : "",
                        usuarioInstance : avisarA
                    ]
                )
            }
            flag = true
        } else {
            flag = false
        }
        flag
    }
}

