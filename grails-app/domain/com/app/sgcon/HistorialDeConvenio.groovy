package com.app.sgcon

import com.app.security.Usuario
import com.app.sgcon.Convenio
/**
* Domain class para el historial de un convenio. 
*/
class HistorialDeConvenio {
    /**
    * Campo para hacer la relacion del historial al convenio. 
    */
    Convenio convenio
    /**
    * campo que nos ayuda a saber quien hizo la operacion dentro del historial. 
    */
    Usuario usuario
    /**
    * Propiedad que nombra al campo que sufrio una operacion.
    */
    String campo
    /**
    * Valor anterior del campo.
    */
    String valorAnterior
    /**
    * Valor nuevo para el campo.
    */
    String valorActual
    /**
    * Fecha de la operacion sobre un convenio
    */
    Date dateCreated
    /**
    * Campo para renombrar la accion que se realizo.
    */
    String accion
    
    static constraints = {
        
        convenio nullable: false
        usuario nullable: false
        campo nullable: true, blank: true
        valorAnterior nullable: true, blank: true
        valorActual nullable: true, blank:true
        accion blank: false
        
    }
    
}
