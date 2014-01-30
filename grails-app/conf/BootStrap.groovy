
import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol
import grails.util.Environment
import com.app.sgtask.Grupo
import com.app.sgcon.StatusDelConvenio
import com.app.sgpod.CartaDeInstruccion
import com.app.sgpod.CategoriaDeTipoDePoder
import com.app.sgpod.Delegacion
import com.app.sgpod.FormatoDeCartaDeInstruccion
import com.app.sgpod.MotivoDeOtorgamiento
import com.app.sgpod.MotivoDeRevocacion
import com.app.sgpod.TipoDePoder


class BootStrap {

    def init = { servletContext ->
        switch (Environment.current) {
        case Environment.DEVELOPMENT :
                
            new Usuario (
                firstName : "Claudia",
                lastName : "Luna",
                email : "j230589t@hotmail.com",
                username : "claudia.luna",
                password : "claudia",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false
            ).save()
            new Usuario (
                firstName : "Administrador",
                lastName : "Del Sistema",
                email : "kokoro.miramar@gmail.com",
                username : "admin",
                password : "4dm1n!",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false
            ).save()
            new Usuario (
                firstName : "Solicitante",
                lastName : "Uno",
                email : "the_real_thom@hotmail.com",
                username : "solicitante1",
                password : "solicitante1",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false
            ).save()
            new Usuario (
                firstName : "Notario",
                lastName : "Uno",
                email : "kokoro.miramar@gmail.com",
                username : "notario1",
                password : "notario1",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false
            ).save()                                
            new Usuario (
                firstName : "Notario",
                lastName : "Dos",
                email : "tomas_mp@yahoo.com.mx",
                username : "notario2",
                password : "notario2",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false
            ).save()            
                
            new Rol (authority : "ROLE_ADMINISTRADOR").save()
            new Rol (authority : "ROLE_PODERES").save()
            new Rol (authority : "ROLE_PODERES_ADMINISTRADOR").save()
            new Rol (authority : "ROLE_PODERES_NOTARIO").save()
            new Rol (authority : "ROLE_PODERES_SOLICITANTE").save()
                
            new UsuarioRol (usuario : Usuario.findByUsername("admin"), rol : Rol.findByAuthority("ROLE_ADMINISTRADOR")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("claudia.luna"), rol : Rol.findByAuthority("ROLE_PODERES_ADMINISTRADOR")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("solicitante1"), rol : Rol.findByAuthority("ROLE_PODERES_SOLICITANTE")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("notario1"), rol : Rol.findByAuthority("ROLE_PODERES_NOTARIO")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("notario2"), rol : Rol.findByAuthority("ROLE_PODERES_NOTARIO")).save()
                
            new Grupo(nombre:"Sin Categoría", descripcion: "asd").save()
                
            new StatusDelConvenio(nombre:"En Elaboración").save()
            new StatusDelConvenio(nombre:"Vigente").save()
                
            new FormatoDeCartaDeInstruccion(
                registro:"REG:SGJ/XXX-XX", 
                fecha:"México, D.F., a XX de XXXX de 2013", 
                contenido: "<p><strong>Lic. XXXX (Nombre y Apellidos)</strong></p> <p><strong>Notario P&uacute;blico N&uacute;mero XX (N&uacute;mero)</strong></p> <p><strong>Del XXXXXXXXXX</strong></p> <p><strong>PRESENTE</strong></p> <p>&nbsp;</p> <p><strong>Solicito se</strong> elaboren/revoquen <strong>los siguientes poderes con las facultades que se relacionan:</strong></p> <p><strong>1.</strong></p> <p><strong>2.</strong></p> <p>&nbsp;</p> <p><strong>ATENTAMENTE</strong></p> <p>T&iacute;tulo y Nombre: ()</p> <p>Puesto: (Subdirector General)</p>"
            ).save()
            
            new MotivoDeOtorgamiento(nombre:"Cambio de Adscripción").save()
            new MotivoDeRevocacion(nombre:"Cambio de Adscripción").save()
            
            new Delegacion(nombre:"HERMOSILLO,SON.").save()
            new Delegacion(nombre:"CHIHUAHUA, CHIH.").save()
            new Delegacion(nombre:"MONTERREY, N.L.").save()
            new Delegacion(nombre:"CULIACAN, SIN.").save()
            new Delegacion(nombre:"SAN LUIS POTOSI, S.L.P.").save()
            new Delegacion(nombre:"GUADALAJARA, JAL. ").save()
            new Delegacion(nombre:"ESTADO DE MEXICO (TOLUCA)").save()
            new Delegacion(nombre:"PUEBLA, PUE.").save()
            new Delegacion(nombre:"METROPOLITANA DEL VALLE DE MÉXICO (TLALNEPANTLA)").save()
            new Delegacion(nombre:"JALAPA, VER.").save()
            new Delegacion(nombre:"MORELOS").save()
            new Delegacion(nombre:"YUCATAN").save()
            new Delegacion(nombre:"TAMAULIPAS SUBD. N.LAREDO").save()
            new Delegacion(nombre:"COAHUILA").save()
            new Delegacion(nombre:"BAJA CALIFORNIA SUBD. TIJUANA").save()
            new Delegacion(nombre:"GUANAJUATO").save()
            new Delegacion(nombre:"OAXACA").save()
            new Delegacion(nombre:"MICHOACAN").save()
            new Delegacion(nombre:"BAJA CALIFORNIA SUR").save()
            new Delegacion(nombre:"GUERRERO").save()
            new Delegacion(nombre:"TABASCO").save()
            new Delegacion(nombre:"DURANGO CESI GOMEZ PALACIO").save()
            new Delegacion(nombre:"QUERETARO").save()
            new Delegacion(nombre:"ZACATECAS").save()
            new Delegacion(nombre:"AGUASCALIENTES.").save()
            new Delegacion(nombre:"HIDALGO.").save()
            new Delegacion(nombre:"TLAXCALA").save()
            new Delegacion(nombre:"COLIMA.").save()
            new Delegacion(nombre:"NAYARIT.").save()
            new Delegacion(nombre:"CHIAPAS").save()
            new Delegacion(nombre:"CAMPECHE").save()
            new Delegacion(nombre:"QUINTANA ROO").save()                        
            
            new TipoDePoder(nombre:"INTERNO").save()
            new TipoDePoder(nombre:"EXTERNO").save()
            new TipoDePoder(nombre:"ESPECIAL").save()
            
            new CategoriaDeTipoDePoder(nombre:"Modelo-A1.-Pleitos y Cobranzas con falcultades para cancelar hipotecas", tipoDePoder: TipoDePoder.get(1)).save()
            new CategoriaDeTipoDePoder(nombre:"Modelo-A2.-DELEGADOS", tipoDePoder: TipoDePoder.get(1)).save()
            new CategoriaDeTipoDePoder(nombre:"Modelo-A3.-Gerente de CESI",  tipoDePoder: TipoDePoder.get(1)).save()
            new CategoriaDeTipoDePoder(nombre:"Modelo-A4.-Gerente y Subgerente de Cobranza", tipoDePoder: TipoDePoder.get(1)).save()
            new CategoriaDeTipoDePoder(nombre:"Modelo-A5.-Facultades Amplias",  tipoDePoder: TipoDePoder.get(1)).save()
            new CategoriaDeTipoDePoder(nombre:"Modelo-A6.-Gerente Jurídico",  tipoDePoder: TipoDePoder.get(1)).save()
            new CategoriaDeTipoDePoder(nombre:"Modelo-B1.-Pleitos y Cobranzas con facultades para transigir", tipoDePoder: TipoDePoder.get(2)).save()
            new CategoriaDeTipoDePoder(nombre:"Modelo-B2.-Pleitos y Cobranzas para representar al apoderante en materia laboral", tipoDePoder: TipoDePoder.get(2)).save()
            new CategoriaDeTipoDePoder(nombre:"Modelo-C1.-Pleitos y Cobranzas", tipoDePoder: TipoDePoder.get(3)).save()
            new CategoriaDeTipoDePoder(nombre:"Modelo-C2.-Pleitos y Cobranzas y facultades para titular", tipoDePoder: TipoDePoder.get(3)).save()
            new CategoriaDeTipoDePoder(nombre:"Modelo-C3.-Especiales", tipoDePoder: TipoDePoder.get(3)).save()
            
            
            
            /*new Persona (
            nombre : "Administrador Del Sistema",
            usuario : Usuario.findByUsername("admin")
            ).save()
            new Persona (
            nombre : "Test Uno",
            usuario : Usuario.findByUsername("test1")
            ).save()
            new Persona (
            nombre : "Test Dos",
            usuario : Usuario.findByUsername("test2")
            ).save()
            new Persona (
            nombre : "Test Tres",
            usuario : Usuario.findByUsername("test3")
            ).save()*/
            break
        case Environment.PRODUCTION :
            
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
             
            break
        }
    }
    def destroy = {
    }
}
