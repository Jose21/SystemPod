/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.app.sgpod

/**
 *
 * @author mauri
 */
class CargoApoderado {    
    String nombreCargo  
    static hasMany = [         
        categoriasDeTipoDePoder : CategoriaDeTipoDePoder       
    ]

    static constraints = {
        
        nombreCargo blank:false, unique:true
        categoriasDeTipoDePoder nullable:true, blank:true 
    }
    String toString() {
        "${nombreCargo}"
    }
}