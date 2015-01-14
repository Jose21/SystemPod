package com.app

import com.app.security.Usuario
import com.app.sgcon.Convenio
import com.app.sgcon.HistorialDeConvenio
import com.app.sgcon.Persona

class HistorialDeConvenioService {
    def springSecurityService
    def agregar(Convenio convenioModificado, Convenio convenioOriginal, String accion) {    
        
        convenioModificado.getProperties().each { property ->    
            if (convenioModificado.isDirty(property.key.toString())) {
                def historialDeConvenio = new HistorialDeConvenio()
                historialDeConvenio.convenio = convenioModificado     
                historialDeConvenio.usuario = springSecurityService.currentUser
                historialDeConvenio.campo = property.key.toString()
                historialDeConvenio.valorAnterior = convenioOriginal."${property.key.toString()}"
                historialDeConvenio.valorActual = convenioModificado."${property.key.toString()}"
                historialDeConvenio.accion = accion
                historialDeConvenio.save()       
            }
        }
    }
    def updateItConvenioToHistorial(Persona personaModificado, Persona personaOriginal, Convenio convenioInstance, String accion) {
        personaModificado.getProperties().each { property ->
            if (personaModificado.isDirty(property.key.toString())) {
                def historialDeConvenio = new HistorialDeConvenio()
                historialDeConvenio.convenio = convenioInstance     
                historialDeConvenio.usuario = springSecurityService.currentUser
                historialDeConvenio.campo = property.key.toString()
                historialDeConvenio.valorAnterior = personaOriginal."${property.key.toString()}"
                historialDeConvenio.valorActual = personaModificado."${property.key.toString()}"
                historialDeConvenio.accion = accion
                historialDeConvenio.save()       
            }
        }
    }
    def addPersonaToHistorial(Persona personaInstance, Convenio convenioInstance, String campo, String valorAnterior, String accion){
        def historialDeConvenio = new HistorialDeConvenio()
        historialDeConvenio.convenio = convenioInstance     
        historialDeConvenio.usuario = springSecurityService.currentUser
        historialDeConvenio.campo = campo
        historialDeConvenio.valorAnterior = valorAnterior
        historialDeConvenio.valorActual = personaInstance.nombre
        historialDeConvenio.accion = accion
        historialDeConvenio.save(flush:true)   
    }
    def removePersonaToHistorial(Persona personaInstance, Convenio convenioInstance, String campo, String valorActual, String accion){
        def historialDeConvenio = new HistorialDeConvenio()
        historialDeConvenio.convenio = convenioInstance     
        historialDeConvenio.usuario = springSecurityService.currentUser
        historialDeConvenio.campo = campo
        historialDeConvenio.valorAnterior = personaInstance.nombre
        historialDeConvenio.valorActual =valorActual
        historialDeConvenio.accion = accion
        historialDeConvenio.save(flush:true)   
    }
    def addCopiaFirmaToHistorial(Convenio convenioInstance, String campo, String valorAnterior, String accion){
        def historialDeConvenio = new HistorialDeConvenio()
        historialDeConvenio.convenio = convenioInstance     
        historialDeConvenio.usuario = springSecurityService.currentUser
        historialDeConvenio.campo = campo
        historialDeConvenio.valorAnterior = valorAnterior
        historialDeConvenio.valorActual = convenioInstance.nombreDeCopiaElectronica
        historialDeConvenio.accion = accion
        historialDeConvenio.save(flush:true)   
    }
    def addNewConvenioToHistorial(Convenio convenioInstance, String campo, String valorAnterior, String accion){
        def historialDeConvenio = new HistorialDeConvenio()
        historialDeConvenio.convenio = convenioInstance     
        historialDeConvenio.usuario = springSecurityService.currentUser
        historialDeConvenio.campo = campo
        historialDeConvenio.valorAnterior = valorAnterior
        //historialDeConvenio.valorActual = convenioInstance.numeroDeConvenio
        historialDeConvenio.accion = accion
        historialDeConvenio.save(flush:true)   
    }
    def addTurnosToHistorial(Usuario usuarioInstance, Convenio convenioInstance,String valorAnterior, String accion){
        def historialDeConvenio = new HistorialDeConvenio()
        historialDeConvenio.convenio = convenioInstance     
        historialDeConvenio.usuario = springSecurityService.currentUser
        //historialDeConvenio.campo = campo
        historialDeConvenio.valorAnterior = usuarioInstance 
        historialDeConvenio.accion = accion
        historialDeConvenio.save(flush:true)   
    }
}
