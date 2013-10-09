package com.app.sgtask

import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class GrupoController {

    static scaffold = Grupo
}
