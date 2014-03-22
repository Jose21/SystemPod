package com.app.sgcon
/**
* Esta Domain class nos ayuda a agregar los responsables y los firmantes de un convenio.
*/
class Persona {
    /**
    * Campo para capturar el nombre de la persona.
    */
    String nombre
    /**
    * Cargo de la persona
    */
    String puesto
    /**
    * Área a la que pertenece.
    */
    String area
    /**
    * Institución de la que proviene.
    */
    String institucion
    /**
    * Correo electrónico de la persona.
    */
    String email
    /**
    * Teléfono de la persona.
    */
    String telefono
    /**
    * Extensión en caso de existir.
    */
    String extension
    /**
    * Fecha de creación.
    */
    Date dateCreated
    /**
    * Fecha de última actualización sobre el alguno de los registros.
    */
    Date lastUpdated   
    
    static constraints = {
        nombre blank:false
        puesto nullable:true, blank:true
        area nullable:true, blank:true
        institucion nullable:true, blank:true
        email nullable:true, email:true, blank:true
        telefono nullable:true, blank:true
        extension nullable:true, blank:true
    }
    
    String toString() {
        "${nombre}"
    }
}
