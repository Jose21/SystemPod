package com.app

import grails.plugins.springsecurity.Secured

class DashboardController {

    @Secured(['ROLE_ADMINISTRADOR'])
    def index() { }
}
