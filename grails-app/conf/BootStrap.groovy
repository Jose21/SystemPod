import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol
import grails.util.Environment
import com.app.sgtask.Grupo
import com.app.sgcon.StatusDelConvenio

class BootStrap {

    def init = { servletContext ->
        switch (Environment.current) {
            case Environment.DEVELOPMENT :
                
                new Usuario (
                    firstName : "Administrador",
                    lastName : "Del Sistema",
                    email : "the.real.thom@gmail.com",
                    username : "admin",
                    password : "4dm1n!",
                    enabled : true,
                    accountExpired : false,
                    accountLocked : false,
                    passwordExpired : false
                ).save()
                new Usuario (
                    firstName : "Test",
                    lastName : "Uno",
                    email : "kokoro.miramar@gmail.com",
                    username : "test1",
                    password : "test1",
                    enabled : true,
                    accountExpired : false,
                    accountLocked : false,
                    passwordExpired : false
                ).save()
                new Usuario (
                    firstName : "Test",
                    lastName : "Dos",
                    email : "tomas_mp@yahoo.com.mx",
                    username : "test2",
                    password : "test2",
                    enabled : true,
                    accountExpired : false,
                    accountLocked : false,
                    passwordExpired : false
                ).save()
                new Usuario (
                    firstName : "Test",
                    lastName : "Tres",
                    email : "the_real_thom@hotmail.com",
                    username : "test3",
                    password : "test3",
                    enabled : true,
                    accountExpired : false,
                    accountLocked : false,
                    passwordExpired : false
                ).save()
                
                new Rol (authority : "ROLE_ADMINISTRADOR").save()
                
                new UsuarioRol (usuario : Usuario.findByUsername("admin"), rol : Rol.findByAuthority("ROLE_ADMINISTRADOR")).save()
                new UsuarioRol (usuario : Usuario.findByUsername("test1"), rol : Rol.findByAuthority("ROLE_ADMINISTRADOR")).save()
                new UsuarioRol (usuario : Usuario.findByUsername("test2"), rol : Rol.findByAuthority("ROLE_ADMINISTRADOR")).save()
                new UsuarioRol (usuario : Usuario.findByUsername("test3"), rol : Rol.findByAuthority("ROLE_ADMINISTRADOR")).save()
                
                new Grupo(nombre:"Sin Categoría", descripcion: "asd").save()
                
                new StatusDelConvenio(nombre:"En Elaboración").save()
                new StatusDelConvenio(nombre:"Vigente").save()
                
                break
            case Environment.PRODUCTION :
                /*
                new Usuario (
                    firstName : "Administrador",
                    lastName : "Del Sistema",
                    email : "the.real.thom@gmail.com",
                    username : "admin",
                    password : "4dm1n!",
                    enabled : true,
                    accountExpired : false,
                    accountLocked : false,
                    passwordExpired : false
                ).save()
                
                new Rol (authority : "ROLE_ADMINISTRADOR").save()
                
                new UsuarioRol (usuario : Usuario.findByUsername("admin"), rol : Rol.findByAuthority("ROLE_ADMINISTRADOR")).save()
                
                new Grupo(nombre:"Sin Categoría", descripcion: "asd").save()
                
                new StatusDelConvenio(nombre:"En Elaboración").save()
                new StatusDelConvenio(nombre:"Vigente").save()
                */
                break
        }
    }
    def destroy = {
    }
}
