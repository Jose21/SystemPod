package com.app.sgpod

import com.app.security.Usuario
import com.app.sgpod.DocumentoDePoder
/**
* Domain class donde se guardar los datos que contiene una factura.
*/ 
class Factura {
    /**
    * Nota que acompaña la factura.
    */ 
    String nota
    /**
    * ¿A quien se asigno la factura?.
    */ 
    Usuario asignadoA
    /**
    * ¿Quien asigno la factura?.
    */
    Usuario asignadoPor
    /**
    * ¿Quien creo la factura?.
    */
    Usuario creadaPor
    /**
    * Fecha de envio de factura.
    */
    Date fechaDeEnvio
    /**
    * Fecha de posible pago de la factura.
    */
    Date fechaDePago
    /**
    * Número de cesta.
    */
    String numeroDeCesta
    /**
    * Comentario de rechazo de la factura.
    */
    String comentarioDeRechazo
    /**
    *campo para registrar si el documento fue cargado correctamente
    */
    boolean documentoCotizacion = false
    /**
    *campo para registrar si el documento fue cargado correctamente
    */
    boolean documentoXml = false
    /**
    *campo para registrar si el documento fue cargado correctamente
    */
    boolean documentoPdf = false
    /**
    * bandera para ocultar la factura de la bandeja del solicitante
    */
    boolean ocultadoPorResolvedor = false
    /**
    * bandera para ocultar la factura de la bandeja del usuario facturas
    */
    boolean ocultadoPorFacturas = false
    
    static hasMany = [ documentos : DocumentoDePoder ]

    static constraints = {
        nota nullable:true
        asignadoA nullable:true
        asignadoPor nullable:true
        fechaDeEnvio nullable:true
        fechaDePago nullable:true
        creadaPor nullable:true
        comentarioDeRechazo nullable:true
        documentoCotizacion blank:false
        documentoXml blank:false
        documentoXml blank:false
        numeroDeCesta nullable:true
        ocultadoPorResolvedor blank:false
        ocultadoPorFacturas blank:false
    }
}
