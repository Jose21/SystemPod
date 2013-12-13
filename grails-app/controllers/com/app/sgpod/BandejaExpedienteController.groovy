package com.app.sgpod

import org.springframework.dao.DataIntegrityViolationException
import java.text.SimpleDateFormat
import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class BandejaExpedienteController {
    def springSecurityService

    def index() {
        flash.warn = null
        //Mis Poderes que tengo asignados, poderes que yo cree y que aun no eh asignado
        def poderesList1 = OtorgamientoDePoder.findAllByAsignarOrAsignarIsNull(springSecurityService.currentUser)
        def poderesList2 = RevocacionDePoder.findAllByAsignarOrAsignarIsNull(springSecurityService.currentUser)
        def poderesList = poderesList1 + poderesList2
        //Poderes Asignados que yo cree
        //lista de otorgamiento
        def c = OtorgamientoDePoder.createCriteria()
        def asignadosOtorgamiento = c.list {
            eq ("creadaPor", springSecurityService.currentUser)
            ne ("asignar", springSecurityService.currentUser)
        } 
        //lista de revocacion
        def d = RevocacionDePoder.createCriteria()
        def asignadosRevocacion = d.list {
            eq ("creadaPor", springSecurityService.currentUser)
            ne ("asignar", springSecurityService.currentUser)
        } 
        def poderesAsignadosList = asignadosOtorgamiento + asignadosRevocacion
        render (
            view: "index", 
            model: [
                otorgamientoInstanceList:poderesList1,
                revocacionInstanceList:poderesList2,
                poderInstanceTotal: poderesList.size(),
                otorgamientoAsignadosInstanceList:asignadosOtorgamiento,
                revocacionAsignadosInstanceList : asignadosRevocacion,
                poderesAsignadosInstanceTotal : poderesAsignadosList.size()
            ]
        )
    }
}
