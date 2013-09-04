package com.app

import com.app.security.Usuario

class Historial {

    Usuario quien
    Date cuando
    
    static constraints = {
        quien nullable:false
        cuando nullable:false
    }
}
