package com.app.sgcon

import com.app.security.Usuario
import com.app.sgcon.Convenio

class HistorialDeConvenio {

    Convenio convenio
    Usuario usuario
    String campo
    String valorAnterior
    String valorActual
    Date dateCreated
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
