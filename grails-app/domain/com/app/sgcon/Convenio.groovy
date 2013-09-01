package com.app.sgcon

import java.text.SimpleDateFormat

class Convenio {

    String numeroDeConvenio
    String objeto
    String sustentoNormativo
    Date fechaDeFirma 
    StatusDelConvenio status
    String tipoDeConvenio
    String institucion
    String compromisos
    Date dateCreated
    Date lastUpdated
    String nombreDeCopiaElectronica
    byte[] copiaElectronica
    
    Convenio modificaA
    Convenio esModificadoPor
    
    static hasMany = [ firmantes : Persona, responsables : Persona ]
    
    static constraints = {
        numeroDeConvenio blank:false, maxSize:20
        objeto blank: false, maxSize: 100
        sustentoNormativo blank: false, maxSize: 200
        fechaDeFirma blank: false
        status nullable:false
        tipoDeConvenio blank:false
        institucion blank:false        
        nombreDeCopiaElectronica nullable:true        
        copiaElectronica nullable:true, maxSize:5242880        
        compromisos nullable:true, blank: true, maxsize:1048576
                
        modificaA nullable:true
        esModificadoPor nullable:true
        
        firmantes nullable: true
        responsables nullable: true
    }
    
    String toString () {
        def sdf = new SimpleDateFormat("dd-MMM-yyyy")
        "${id} - ${sdf.format(fechaDeFirma)}"
    }
}
