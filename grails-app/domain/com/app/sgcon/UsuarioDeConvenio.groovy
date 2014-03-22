package com.app.sgcon

import com.app.security.Usuario

/**
* Domain class que es necesaria para saber quien es el creador del convenio. 
*/
class UsuarioDeConvenio {
    /**
    * Datos del usuario creador
    */
    Usuario usuario
    /**
    * Bandera para idenficar si es el creador o no.
    */
    boolean owner
    
    static belongsTo = [ convenio : Convenio ]
    
    static constraints = {
        usuario nullable:false
        owner blank:false
        convenio nullable:false
    }
}
