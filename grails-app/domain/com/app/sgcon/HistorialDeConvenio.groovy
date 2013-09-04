package com.app.sgcon

import com.app.Historial

class HistorialDeConvenio extends Historial {

    String que
    static belongsTo = [  convenio : Convenio ]
    
    static constraints = {
        que nullable:false, 
            inList : [
                "creó un convenio", 
                "editó la información de un convenio", 
                "cambió de estatus un convenio", 
            ]
        convenio nullable:false
    }
}
