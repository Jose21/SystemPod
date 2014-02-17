package com.app.sgpod

class ConfigurarParametro {
    
    //Parametros para vista en bandeja de Poderes por vencer y notificaciones por correo electrónico
    Integer estadoCriticoPoder
    Integer estadoSemiPoder    
    
    //Parametros para vista en bandeja de Solicitudes Pendientes
    Integer estadoCriticoSolicitud
    Integer estadoSemiSolicitud    

    static constraints = {        
        estadoSemiPoder min:0        
        estadoCriticoPoder validator: { val, obj ->
            if (val >= obj.estadoSemiPoder) return ['Valor Incorrecto']
        }
        
        
        estadoSemiSolicitud min:0        
        estadoCriticoSolicitud validator: { val, obj ->
            if (val >= obj.estadoSemiSolicitud) return ['Valor Incorrecto']
        }
    }
}
