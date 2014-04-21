package com.app.sgpod

import com.app.security.Usuario

/**
* Domain class para realizar una bitacora sobre las solicitudes de otorgamiento y revocación de poder. 
*/
class Bitacora {
    
    Usuario quien
    Date cuando
    String que        
    
    static constraints = {
        quien nullable:false
        cuando nullable:false
        que nullable:false        
    }
    
}
