package com.app.sgpod

import com.app.security.Usuario

/**
* Domain class donde se registran las prorrogas.
*/
class Prorroga { 
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
    /**
    * bandera para ocultar la prorroga de la bandeja del solicitante
    */
    boolean ocultado = false
    
    static constraints = {        
        motivos nullable:true
        fechaProrroga nullable:true
        creadoPor nullable:true
        asignadoA nullable:true
        dateCreated nullable:true
        fechaDeEnvio nullable:true
        ocultado blank:false
    }
}
