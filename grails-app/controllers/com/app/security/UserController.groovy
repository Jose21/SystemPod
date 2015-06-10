package com.app.security

class UserController extends grails.plugins.springsecurity.ui.UserController {

    
    
    def updateIt(Long id, Long version) {        
        def userInstance = Usuario.get(id)        
        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'user.label', default: 'Usuario')] as Object[],
                          "Otro usuario actualizó los datos mientras los estabas editando.")
                redirect(controller:"poderes", action: "editarNotario", id: userInstance.id)
                return
            }
        }

        userInstance.properties = params        
        if (!userInstance.save(flush: true)) {
            flash.message = ""
            redirect(controller:"poderes", action: "editarNotario", id: userInstance.id)
            return
        }

        flash.message = "Datos actualizados correctamente."
        redirect(controller:"poderes", action: "editarNotario")
    }
    
    def updateItUserExterno (Long id, Long version) {        
        def userInstance = Usuario.get(id)        
        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'user.label', default: 'Usuario')] as Object[],
                          "Otro usuario actualizó los datos mientras los estabas editando.")
                redirect(controller:"poderes", action: "editarSolicitanteExterno", id: userInstance.id)
                return
            }
        }

        userInstance.properties = params        
        if (!userInstance.save(flush: true)) {
            flash.message = ""
            redirect(controller:"poderes", action: "editarSolicitanteExterno", id: userInstance.id)
            return
        }

        flash.message = "Datos actualizados correctamente."
        redirect(controller:"poderes", action: "editarSolicitanteExterno")
    }
    
}
