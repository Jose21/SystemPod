package com.app.sgpod

/**
* Domain class donde se configuran los principales parametros de las notificaciones de poderes.
*/
class ConfigurarParametro {
    /**
    * Parametros para vista en bandeja de Poderes por vencer y notificaciones por correo electrónico.
    * estado critico
    */    
    Integer estadoCriticoPoder
    /**
    * Parametros para vista en bandeja de Poderes por vencer y notificaciones por correo electrónico.
    * estado semi-critico
    */    
    Integer estadoSemiPoder    
        
    /**
    * Parametros para vista en bandeja de Solicitudes Pendientes.
    * estado critico.
    */    
    Integer estadoCriticoSolicitud
    /**
    * Parametros para vista en bandeja de Solicitudes Pendientes.
    * estado semi-critico.
    */
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
