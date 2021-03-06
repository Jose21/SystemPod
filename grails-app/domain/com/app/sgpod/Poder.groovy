package com.app.sgpod

import com.app.security.Usuario
import com.app.sgtask.Tarea
import com.app.sgtask.Nota

/**
 * Domain class de una solicitud de poder que hereda a las domain class Otorgamiento y Revocación de poder.
 * En esta tabla se guardan las solicitudes. 
 */
class Poder {
    /**
     * Fecha de cuando se crea la solicitud.
     */
    Date registroDeLaSolicitud
    /**
     * Categoría que tiene una solicitud.
     */
    CategoriaDeTipoDePoder categoriaDeTipoDePoder
    /**
     * Delegación del solicitante.
     */
    Delegacion delegacion
    /**
     * Usuario creador de la solicitud.
     */
    Usuario creadaPor
    /**
     * Número de escritura publica de la solicitud.
     */
    String escrituraPublica
    /**
     * Usuario que tiene asignada la solicitud.
     */
    Usuario asignar
    /**
     * Usuario que asignó la solicitud.
     */
    Usuario asignadaPor
    /**
     * Campo Comentarios dentro de la solicitud.
     */
    String comentarios
    /**
     * Campo que hace refencia a la carta de instrucción. 
     */
    CartaDeInstruccion cartaDeInstruccion
    /**
     * Palabras clave para la búsqueda.
     */
    String tags
    /**
     * Usuario resposanble a quien le llegan las notificaciones sobre la solicitud.
     */
    Usuario responsable
    /**
     * Fecha de cuando se envia la solicitud.
     */
    Date fechaDeEnvio
    /**
     * Usuario gestor dentro del sistema.
     */
    Usuario usuarioGestor
    /**
     * Notario que generó la escritura pública.
     */
    Usuario notarioCorrespondiente
    /**
     * bandera que se usa para saber si ya esta facturada una solicitud.
     */
    boolean facturado = false
    /**
     * Factura correspondiente.
     */
    Factura factura
    /**
     * bandera para ocultar la solicitud de la bandeja del solicitante
     */
    boolean ocultadoPorSolicitante = false
    /**
     * bandera para ocultar la solicitud de la bandeja del usuario resolvedor
     */
    boolean ocultadoPorResolvedor = false
    /**
     * Copia electronica del documentos firmado. 
     */
    byte[] datosUsuarioExterno
    /**
     * nombre del archivo 
     */
    String nombreDatosUsuarioExterno
    
    //documento de proyecto para solicitar vo bo de carta de instruccion entre el notario y el resolvedor   
    DocumentoDeProyecto documentoDeProyecto   
    
    
    /**
     * Esta es la relación que tiene con otras tablas en una relacion tipo  1-n.
     */
    static hasMany = [ 
        documentos : DocumentoDePoder,
        tareas : Tarea,
        apoderados : Apoderado,
        notas : Nota,
        prorrogas : Prorroga,
        bitacoras : Bitacora
    ]
    
    static constraints = {
        
        registroDeLaSolicitud nullable:false
        categoriaDeTipoDePoder blank:false
        delegacion nullable:false
        creadaPor nullable:false
        escrituraPublica nullable:true, blank:true
        
        comentarios nullable:true, blank:true, maxSize:1048576
        
        asignar nullable:true, blank:true
        asignadaPor nullable:true, blank:true
        cartaDeInstruccion nullable:true
        documentos nullable:true
        tareas nullable:true
        tags nullable:true, maxSize:1000
        apoderados nullable:true
        responsable nullable:true,blank:true
        notas nullable:true
        fechaDeEnvio nullable:true
        prorrogas nullable:true
        usuarioGestor nullable:true,blank:true
        notarioCorrespondiente nullable:true,blank:true
        facturado blank:false
        factura nullable:true
        bitacoras nullable:true
        ocultadoPorSolicitante blank:false
        ocultadoPorResolvedor blank:false
        datosUsuarioExterno nullable:true, maxSize:52428800
        nombreDatosUsuarioExterno nullable:true, maxSize:1000   
        documentoDeProyecto nullable: true 
    }
    
    String toString() {
        "${id}"
    }
}
