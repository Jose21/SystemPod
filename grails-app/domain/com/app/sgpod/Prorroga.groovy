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
    * Los dias que se piden como prorroga.
    */
    Integer dias
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
    }
}
