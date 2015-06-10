/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.app.sgpod

import com.app.security.Usuario

/**
 *
 * @author mauri
 */
class DocumentoDeProyecto {
    
    String descripcion
    String motivosDeRechazo   
    Date dateCreated
    Date fechaDeEnvio
    boolean voboCartaDeInstruccion
    Usuario asignadoA
    Usuario asignadoPor   
    
    
    static hasMany = [ documentos : DocumentoDePoder ]
    
    static belongsTo = [ otorgamientoDePoder : OtorgamientoDePoder]
    
    static constraints = {        
        descripcion blank:true, nullable:true, maxSize:10240
        motivosDeRechazo blank:true, nullable:true, maxSize:10240
        fechaDeEnvio nullable:true
        documentos nullable:true
        voboCartaDeInstruccion nullable:true
        asignadoA nullable: true
        asignadoPor nullable:true
        otorgamientoDePoder nullable:true
    }
    
	
}


