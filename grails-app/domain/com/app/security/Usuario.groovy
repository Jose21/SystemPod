package com.app.security

/**
*Domain class que nos sirve para guardar la informacion de los usuarios del sistema.
*/
class Usuario implements Serializable {

    transient springSecurityService
    /**
    *Propiedad referente al nombre de usuario con que se autentificara.
    */
    String username
    /**
    *Propiedad referente a la contaseña del usuario.
    */
    String password
    /**
    *Campo referente al correo electronico del usuario.
    */
    String email
    /**
    *Propiedad para el o los nombres del usuario.
    */
    String firstName
    /**
    *Propiedad para los apellidos del usuario.
    */
    String lastName
    /**
    *Propiedad para bloquear algun usuario.
    */
    boolean enabled
    /**
    *Campo que nos ayuda para saber si esta activa la cuenta del usuario.
    */
    boolean accountExpired
    /**
    *Propiedad que ayuda a bloquear una cuenta de usuario.
    */
    boolean accountLocked
    /**
    *Propiedad que ayuda a saber si expiro la contaseña del usuario.
    */
    boolean passwordExpired
    /**
    *Campo para capturar la fecha que se creo en el sistema al usuario.
    */
    Date dateCreated
    /**
    *Campo que registra la fecha de la ultima modificacion sobre un usuario.
    */
    Date lastUpdated
    
    /**
    *campos para usuarios notarios
    */
    String notaria_titular
    String notaria_numero
    String notaria_entidad
    String nombreDespachoExterno
    
    static constraints = {
        username blank: false, unique: true
        password blank: false
        email blank:true, email:true
        notaria_titular  nullable:true
        notaria_numero   nullable:true
        notaria_entidad  nullable:true
        nombreDespachoExterno  nullable:true
    }

    static mapping = {
        password column: '`password`'
        autoTimestamp true
    }

    Set<Rol> getAuthorities() {
        UsuarioRol.findAllByUsuario(this).collect { it.rol } as Set
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }
    
    String toString() {
        "${firstName} ${lastName}"
    }    
}
