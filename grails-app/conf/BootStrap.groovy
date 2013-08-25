import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol
import grails.util.Environment

class BootStrap {

    def init = { servletContext ->
        switch (Environment.current) {
            case Environment.DEVELOPMENT :
                
                new Usuario (
                    firstName : "Administrador",
                    lastName : "Del Sistema",
                    email : "admin@sgcon.com",
                    username : "admin",
                    password : "4dm1n!",
                    enabled : true,
                    accountExpired : false,
                    accountLocked : false,
                    passwordExpired : false
                ).save()
                new Rol (authority : "ROLE_ADMINISTRADOR").save()
                new UsuarioRol (usuario : Usuario.findByUsername("admin"), rol : Rol.findByAuthority("ROLE_ADMINISTRADOR")).save()
            case Environment.PRODUCTION :
                break
        }
    }
    def destroy = {
    }
}
