package com.app.sgcon

import com.app.sgtask.Tarea
import java.text.SimpleDateFormat

/**
* Domain class Convenio 
*/

class Convenio {
    /**
    * Campo para capturar el numero del convenio. 
    */
    //String numeroDeConvenio
    /**
    * Campo para capturar el objeto del convenio. 
    */
    String objeto
    /**
    * Campo para susutento normativo el numero del convenio. 
    */
    String sustentoNormativo
    /**
    * Fecha de firma del convenio. 
    */
    Date fechaDeFirma
    /**
    * Fecha de vigencia para el convenio. 
    */
    Date vigencia
    /**
    * Campo para indentificar el status del convenio.
    */
    StatusDelConvenio status
    /**
    * Tipo del convenio. 
    */
    String tipoDeConvenio
    /**
    * Institucion con la que se realiza el convenio. 
    */
    String institucion
    /**
    * Compromisos del convenio. 
    */
    String compromisos
    /**
    * fecha de creacion. 
    */
    Date dateCreated
    /**
    * Fecha de ultima actualiacion de los datos. 
    */
    Date lastUpdated
    /**
    * Nombre del archivo de la copia electronica del convenio firmado. 
    */
    String nombreDeCopiaElectronica
    /**
    * Copia electronica del documentos firmado. 
    */
    byte[] copiaElectronica
    /**
    * Bandera para no permitir editar el convenio cuando ya esta adjuntado el archivo electronico. 
    */
    boolean editable = true
    /**
    * Palabras clave para busquedas. 
    */
    String tags
    /**
    * Convenios modificatorios al que mofica. 
    */
    Convenio modificaA
    /**
    * Convenio modificatorio. 
    */
    Convenio esModificadoPor
    
    /**
    *Baja lógica
    *
    */
   boolean eliminado = null
    
    static hasMany = [ 
        firmantes : Persona, 
        responsables : Persona, 
        usuariosDeConvenio : UsuarioDeConvenio,
        tareas : Tarea
    ]
    
    static constraints = {
        //numeroDeConvenio blank:false, maxSize:5000
        objeto blank: false, maxSize:5000
        sustentoNormativo blank: false, maxSize:5000
        tipoDeConvenio blank:false, maxSize:5000
        institucion blank:false, maxSize:5000
        
        fechaDeFirma blank : true, nullable : true
        vigencia nullable:true, blank:true
        status nullable:false        
        nombreDeCopiaElectronica nullable:true, maxSize:1000
        copiaElectronica nullable:true, maxSize:52428800
        editable blank:false
        compromisos nullable:true, blank: true, maxSize:1048576
        
        modificaA nullable:true
        esModificadoPor nullable:true
        
        firmantes nullable: true
        responsables nullable: true
        usuariosDeConvenio nullable:true
        tareas nullable:true
        tags nullable:true, maxSize:1000
        eliminado nullable:true
       }
    
    //String toString () {
      //  def sdf = new SimpleDateFormat("dd-MMM-yyyy")
        //"${id} - ${sdf.format(fechaDeFirma)}"
    //}
}
