package com.app

import grails.plugins.springsecurity.Secured
import com.app.security.Usuario

@Secured(['ROLE_ADMINISTRADOR'])
class DashboardController {

    def springSecurityService
    
    def test() {    
    }
    
    def index() { 
        [ user : springSecurityService.currentUser ]
    }
    
    def changeinfo () {
        def user = params.id ? Usuario.get(params.id as long) : springSecurityService.currentUser
        [ user : user ]
    }
    
    def updateinfo() {
        def user = springSecurityService.currentUser
        if (!params.email?.trim() || !params.firstName?.trim() || !params.lastName?.trim()) {
            flash.error = "Todos los campos deben ser llenados correctamente."
        } else {
            user.properties = params
            if (!user.save(flush:true)) {
                flash.error = "Los datos no pudieron ser actualizados."
            } else {
                flash.message = "Los datos han sido actualizados satisfactoriamente."
            }   
        }        
        redirect action:"changeinfo", id : user.id
    }
    
    def changepasswd () {}
    
    def updatepasswd () {
        
        def oldPasswd = params.oldPasswd
        def newPasswd1 = params.newPasswd1
        def newPasswd2 = params.newPasswd2
        def user = springSecurityService.currentUser
        
        //Checar que el oldPasswd sea correcto
        oldPasswd = springSecurityService.encodePassword(oldPasswd)
        
        println "currentPasswd : " + user.password
        println "oldPasswd : " + oldPasswd
        println "newPasswd1 : " + newPasswd1
        println "newPasswd2 : " + newPasswd2
        
        if (oldPasswd != user.password) {
            flash.error = "La contraseña actual es incorrecta. Favor de verificarla."
        } else{
            if (newPasswd1 != newPasswd2) {
                flash.error = "La contraseña nueva no coincide con su confirmación. Favor de verificarla."
            } else {
                user.password = newPasswd1
                if (!user.save(flush:true)) {
                    flash.error = "La contraseña no se puedo actualizar. Favor de reintentarlo."
                } else {
                    flash.message = "La contraseña se actualizó satisfactoriamente."
                }
            }
        }        
        redirect action:"changepasswd"
    }
}
