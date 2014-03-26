package com.app.sgpod

import com.app.security.Usuario

/**
* Domain class donde se registran las prorrogas.
*/
class Prorroga {
    /**
    * Título de la prorroga.
    */
    String titulo
    /**
    * Motivos de prorroga.
    */
    String motivos
    /**
    * Fecha de prorroga.
    */
    Date fechaProrroga
    /**
    * Usuario que crea la prorroga.
    */
    Usuario creadoPor
    /**
    * Usuario a quien se le asigna la prorroga.
    */
    Usuario asignadoA
    /**
    * Fecha de cuando se crea la prorroga.
    */
    Date dateCreated
    /**
    * Fecha de envio.
    */
    Date fechaDeEnvio    
    
    static constraints = {
        titulo nullable:false
        motivos nullable:true
        fechaProrroga nullable:true
        creadoPor nullable:true
        asignadoA nullable:true
        dateCreated nullable:true
        fechaDeEnvio nullable:true
    }
}
