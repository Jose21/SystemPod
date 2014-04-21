package com.app

import com.app.security.Usuario
import com.app.sgpod.Bitacora
import com.app.sgpod.OtorgamientoDePoder
import com.app.sgpod.RevocacionDePoder

class BitacoraService {
           
        def agregarOtorgamiento(OtorgamientoDePoder otorgamientoDePoder, Usuario quien, String que) {        
        def bitacoraInstance = new Bitacora()
        def otorgamientoDePoderInstance = otorgamientoDePoder
        bitacoraInstance.quien = quien
        bitacoraInstance.que = que
        bitacoraInstance.cuando = new Date()               
        bitacoraInstance.save(flush:true)
        otorgamientoDePoderInstance.addToBitacoras(bitacoraInstance)
    }
    
    def agregarRevocacion(RevocacionDePoder revocacionDePoder, Usuario quien, String que) {        
        def bitacoraInstance = new Bitacora()
        def revocacionDePoderInstance = revocacionDePoder
        bitacoraInstance.quien = quien
        bitacoraInstance.que = que
        bitacoraInstance.cuando = new Date()                
        bitacoraInstance.save(flush:true)
        revocacionDePoderInstance.addToBitacoras(bitacoraInstance)
    }

    
}
