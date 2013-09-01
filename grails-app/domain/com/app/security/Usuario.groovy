package com.app.security

class Usuario implements Serializable {

    transient springSecurityService

    String username
    String password
    String email
    String firstName
    String lastName
    boolean enabled
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired

    Date dateCreated
    Date lastUpdated
    
    static constraints = {
        username blank: false, unique: true
        password blank: false
        email blank:true, email:true
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
        "${username}"
    }    
}
