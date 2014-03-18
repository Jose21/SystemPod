package com.app.sgpod

import com.app.security.Usuario
import com.app.sgpod.DocumentoDePoder

class Factura {
    
    String nota
    Usuario asignadoA
    Usuario asignadoPor
    Usuario creadaPor
    Date fechaDeEnvio
    Date fechaDePago
    String comentarioDeRechazo
    
    static hasMany = [ documentos : DocumentoDePoder ]

    static constraints = {
        nota nullable:true
        asignadoA nullable:true
        asignadoPor nullable:true
        fechaDeEnvio nullable:true
        fechaDePago nullable:true
        creadaPor nullable:true
        comentarioDeRechazo nullable:true
    }
}
