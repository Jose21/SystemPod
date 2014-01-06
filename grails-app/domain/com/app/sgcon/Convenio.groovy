package com.app.sgcon

import com.app.sgtask.Tarea
import java.text.SimpleDateFormat

class Convenio {

    String numeroDeConvenio
    String objeto
    String sustentoNormativo
    Date fechaDeFirma
    Date vigencia
    StatusDelConvenio status
    String tipoDeConvenio
    String institucion
    String compromisos
    Date dateCreated
    Date lastUpdated
    String nombreDeCopiaElectronica
    byte[] copiaElectronica
    boolean editable = true
    String tags
    
    Convenio modificaA
    Convenio esModificadoPor
    
    static hasMany = [ 
        firmantes : Persona, 
        responsables : Persona, 
        usuariosDeConvenio : UsuarioDeConvenio,
        tareas : Tarea
    ]
    
    static constraints = {
        numeroDeConvenio blank:false, maxSize:5000
        objeto blank: false, maxSize:5000
        sustentoNormativo blank: false, maxSize:5000
        tipoDeConvenio blank:false, maxSize:5000
        institucion blank:false, maxSize:5000
        
        fechaDeFirma blank: false
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
       }
    
    String toString () {
        def sdf = new SimpleDateFormat("dd-MMM-yyyy")
        "${id} - ${sdf.format(fechaDeFirma)}"
    }
}
