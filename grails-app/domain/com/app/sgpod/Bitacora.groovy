package com.app.sgpod

/**
* Domain class para realizar una bitacora sobre las solicitudes de otorgamiento y revocación de poder. 
*/
class Bitacora {
    /**
    * Fecha de creación de la solicitud.
    */
    Date fechaDeCreacion
    /**
    * Fecha de envio de la solicitud.
    */
    Date fechaDeEnvio
    /**
    * Fecha de otorgamiento o revocacion de poder segun sea el caso.
    */
    Date fechaOtorgamientoRevocacion
    /**
    * Fecha de vencimiento del otorgamiento de poder.
    */
    Date fechaDeVencimiento
    /**
    * Dias Totales en caso de haber existido prorrogas.
    */
    Integer diasProrrogas
    /**
    * Fecha en que se ingreso la factura que perteneciente a la solicitud.
    */
    Date fechaFactura
    

    static constraints = {
    }
}
