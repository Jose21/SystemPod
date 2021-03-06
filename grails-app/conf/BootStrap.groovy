
import com.app.security.Usuario
import com.app.security.Rol
import com.app.security.UsuarioRol
import grails.util.Environment
import com.app.sgtask.Grupo
import com.app.sgcon.StatusDelConvenio
import com.app.sgpod.CartaDeInstruccion
import com.app.sgpod.CategoriaDeTipoDePoder
import com.app.sgpod.ConfigurarParametro
import com.app.sgpod.Delegacion
import com.app.sgpod.FormatoDeCartaDeInstruccion
import com.app.sgpod.MotivoDeOtorgamiento
import com.app.sgpod.MotivoDeRevocacion
import com.app.sgpod.TipoDePoder


class BootStrap {

    def init = { servletContext ->
        switch (Environment.current) {
        case Environment.DEVELOPMENT :
                
            /*
            new Usuario (
                firstName : "Juan",
                lastName : "Martinez",
                email : "ejemplo2@hotmail.com",
                username : "resolvedor1",
                password : "resolvedor1",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save()            
            new Usuario (
                firstName : "Lic. Pedro",
                lastName : "Chavez",
                email : "ejemplo@yahoo.com.mx",
                username : "gestor1",
                password : "gestor1",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save()
            new Usuario (
                firstName : "Administrador",
                lastName : "Del Sistema",
                email : "sgcon@nuuptech.com",
                username : "admin",
                password : "4dm1n!",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save()            
            new Usuario (
                firstName : "LIC. ARTURO",
                lastName : "CARMONA",
                email : "ejemplo@hotmail.com",
                username : "solicitante1",
                password : "solicitante1",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save()
            new Usuario (
                firstName : "LIC. JORGE",
                lastName : "SANCHEZ",
                email : "ejemplo@gmail.com",
                username : "notario1",
                password : "notario1",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : "LIC. JORGE SANCHEZ",
                notaria_numero  : "Notaria 86",
                notaria_entidad : "Estado de México"
            ).save()                                
            new Usuario (
                firstName : "LIC. CARLOS",
                lastName : "LOPEZ",
                email : "ejemplo3@yahoo.com.mx",
                username : "notario2",
                password : "notario2",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : "LIC. CARLOS LOPEZ",
                notaria_numero  : "Notaria 129",
                notaria_entidad : "Distrito Federal"
            ).save() 
            new Usuario (
                firstName : "admin",
                lastName : "convenios",
                email : "ejemplo4@yahoo.com.mx",
                username : "convenios",
                password : "convenios",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save() 
            new Usuario (
                firstName : "Enrique",
                lastName : "Mejia Díaz",
                email : "dostres@yahoo.com.mx",
                username : "facturas",
                password : "facturas",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save() 
            new Usuario (
                firstName : "Arturo",
                lastName : "Carmona Sanchez",
                email : "carmona@yahoo.com.mx",
                username : "turnos",
                password : "turnos",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save()            
            new Usuario (
                firstName : "Joel",
                lastName : "Ramirez Sanchez",
                email : "joel@yahoo.com.mx",
                username : "solicitanteExterno",
                password : "solicitanteExterno",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save()
            new Usuario (
                firstName : "Laura",
                lastName : "Jimenez Sanchez",
                email : "laura@yahoo.com.mx",
                username : "gestorExterno",
                password : "gestorExterno",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save()
            new Usuario (
                firstName : "Arturo",
                lastName : "Cruz Jiménez",
                email : "acruz@infonavit.org.mx",
                username : "097682",
                password : "12345678",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save()
             new Usuario (
                firstName : "Saul",
                lastName : "Legorreta Paez",
                email : "lego@yahoo.com.mx",
                username : "solicitanteEspecial",
                password : "solicitanteEspecial",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save()
                
                                                                          
            new Rol (authority : "ROLE_ADMINISTRADOR").save()
            new Rol (authority : "ROLE_PODERES").save()
            new Rol (authority : "ROLE_PODERES_RESOLVEDOR").save()
            new Rol (authority : "ROLE_PODERES_NOTARIO").save()
            new Rol (authority : "ROLE_PODERES_SOLICITANTE").save()
            new Rol (authority : "ROLE_PODERES_GESTOR").save()
            new Rol (authority : "ROLE_SOLICITANTE_EXTERNO").save()
            new Rol (authority : "ROLE_GESTOR_EXTERNO").save()
            new Rol (authority : "ROLE_CONVENIOS_ADMIN").save()
            new Rol (authority : "ROLE_CONVENIOS_STANDARD").save()
            new Rol (authority : "ROLE_FACTURAS").save()
            new Rol (authority : "ROLE_TURNOS_ADMIN").save()
            new Rol (authority : "ROLE_TURNOS_STANDARD").save()
            new Rol (authority : "ROLE_PODERES_ENLACE").save()  
            new Rol (authority : "ROLE_SOLICITANTE_ESPECIAL").save()  
            
                
            new UsuarioRol (usuario : Usuario.findByUsername("admin"), rol : Rol.findByAuthority("ROLE_ADMINISTRADOR")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("resolvedor1"), rol : Rol.findByAuthority("ROLE_PODERES_RESOLVEDOR")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("solicitante1"), rol : Rol.findByAuthority("ROLE_PODERES_SOLICITANTE")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("notario1"), rol : Rol.findByAuthority("ROLE_PODERES_NOTARIO")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("notario2"), rol : Rol.findByAuthority("ROLE_PODERES_NOTARIO")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("gestor1"), rol : Rol.findByAuthority("ROLE_PODERES_GESTOR")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("convenios"), rol : Rol.findByAuthority("ROLE_CONVENIOS_ADMIN")).save()           
            new UsuarioRol (usuario : Usuario.findByUsername("facturas"), rol : Rol.findByAuthority("ROLE_FACTURAS")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("turnos"), rol : Rol.findByAuthority("ROLE_TURNOS_ADMIN")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("gestorExterno"), rol : Rol.findByAuthority("ROLE_GESTOR_EXTERNO")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("solicitanteExterno"), rol : Rol.findByAuthority("ROLE_SOLICITANTE_EXTERNO")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("097682"), rol : Rol.findByAuthority("ROLE_PODERES_ENLACE")).save()
            new UsuarioRol (usuario : Usuario.findByUsername("solicitanteEspecial"), rol : Rol.findByAuthority("ROLE_SOLICITANTE_ESPECIAL")).save()
            
                
            new Grupo(nombre:"Sin Categoría", descripcion: "asd").save()
                
            new StatusDelConvenio(nombre:"En Elaboración").save()
            new StatusDelConvenio(nombre:"Liberado").save()
            new StatusDelConvenio(nombre:"Firmado").save()
                
            new FormatoDeCartaDeInstruccion(
                registro:"REG:SGJ/XXX-XX", 
                fecha:"México, D.F., a XX de XXXX de 2014", 
                contenido: "<p><strong>M en D. José Octavio Tinajero Zenil</strong></p> <p><strong>Subdirector General Jurídico</strong></p> <p><strong>P R E S E N T E</strong></p> <p>&nbsp;</p> <p><strong>Solicito se</strong> elaboren/revoquen <strong>los siguientes poderes con las facultades que se relacionan:</strong></p> <p><strong>1.</strong></p> <p><strong>2.</strong></p> <p>&nbsp;</p>"
            ).save()
            
            new FormatoDeCartaDeInstruccion(
                registro:"REG:SGJ/XXX-XX", 
                fecha:"México, D.F., a XX de XXXX de 2014", 
                contenido: "<p><strong>M en D. José Octavio Tinajero Zenil</strong></p> <p><strong>Subdirector General Jurídico</strong></p> <p><strong>P R E S E N T E</strong></p> <p>&nbsp;</p> <p>Por este medio solicito que se realice la revocación del Poder Notarial Contenido en la escritura publica No. @escrituraPublica@  pasada ante la fe del correspondiente Notario Público No.______ a cargo del Lic. @notario@ a favor de los siguientes.</p> <p>&nbsp;</p>"
            ).save()
            
            new MotivoDeOtorgamiento(nombre:"Cambio de Adscripción").save()
            new MotivoDeOtorgamiento(nombre:"Cambio de Funciones").save()
            new MotivoDeOtorgamiento(nombre:"Nuevo Ingreso").save()
            new MotivoDeOtorgamiento(nombre:"Nuevo Nombramiento").save()
            new MotivoDeRevocacion(nombre:"Cambio de Adscripción").save()
            new MotivoDeRevocacion(nombre:"Cambio de Funciones").save()
            new MotivoDeRevocacion(nombre:"Baja del Instituto").save() 
            new MotivoDeRevocacion(nombre:"Baja del Despacho").save()
            
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
            
            new CategoriaDeTipoDePoder(nombre:"Modelo-A1.-Pleitos y Cobranzas con facultades para cancelar hipotecas", tipoDePoder: TipoDePoder.get(1)).save()
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
            
            
            new ConfigurarParametro(
                estadoCriticoPoder:"3", estadoSemiPoder:"5",
                estadoCriticoSolicitud:"10", estadoSemiSolicitud:"15"
            ).save()
             
            */
              
            /*
            new Persona (
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
            ).save()
            */
                                                                         
            break
            
        case Environment.PRODUCTION :
           
            new Usuario (
                firstName : "Administrador",
                lastName : "Del Sistema",
                email : "sgcon@nuuptech.com",
                username : "admin",
                password : "4dm1n!",
                enabled : true,
                accountExpired : false,
                accountLocked : false,
                passwordExpired : false,
                notaria_titular : null,
                notaria_numero  : null,
                notaria_entidad : null
            ).save()
                
            new Rol (authority : "ROLE_ADMINISTRADOR").save()                
            new UsuarioRol (usuario : Usuario.findByUsername("admin"), rol : Rol.findByAuthority("ROLE_ADMINISTRADOR")).save()
            
            /*
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
