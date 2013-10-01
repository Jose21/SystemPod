package com.app.sgcon

import com.app.security.Usuario

class UsuarioDeConvenio {

    Usuario usuario
    boolean owner
    
    static belongsTo = [ convenio : Convenio ]
    
    static constraints = {
        usuario nullable:false
        owner blank:false
        convenio nullable:false
    }
}
