package com.app.sgcon

import grails.plugins.springsecurity.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class StatusDelConvenioController {

    static scaffold = StatusDelConvenio
}
