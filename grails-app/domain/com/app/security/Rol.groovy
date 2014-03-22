package com.app.security
/**
* Domain class Rol que pertenece al rol que tiene cada unos de los usuarios del sistema.
*/


class Rol {
        /**
        * Propiedad que ayuda para el nombramiento del rol, por ejmplo: ROLE_PODERES_SOLICITANTE
        */
	String authority

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}
