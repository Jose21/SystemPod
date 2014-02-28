package com.app.sgpod

import com.app.security.Usuario

class Prorroga {
    
    String titulo
    String motivos
    Integer dias
    Usuario creadoPor
    Usuario asignadoA
    Date dateCreated
    Date fechaDeEnvio    
    
    static constraints = {
    }
}
