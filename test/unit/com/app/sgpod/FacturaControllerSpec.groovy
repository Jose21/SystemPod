package com.app.sgpod



import grails.test.mixin.*
import spock.lang.*

@TestFor(FacturaController)
@Mock(Factura)
class FacturaControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.facturaInstanceList
            model.facturaInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.facturaInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def factura = new Factura()
            factura.validate()
            controller.save(factura)

        then:"The create view is rendered again with the correct model"
            model.facturaInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            factura = new Factura(params)

            controller.save(factura)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/factura/show/1'
            controller.flash.message != null
            Factura.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def factura = new Factura(params)
            controller.show(factura)

        then:"A model is populated containing the domain instance"
            model.facturaInstance == factura
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def factura = new Factura(params)
            controller.edit(factura)

        then:"A model is populated containing the domain instance"
            model.facturaInstance == factura
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"A 404 error is returned"
            status == 404

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def factura = new Factura()
            factura.validate()
            controller.update(factura)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.facturaInstance == factura

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            factura = new Factura(params).save(flush: true)
            controller.update(factura)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/factura/show/$factura.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            controller.delete(null)

        then:"A 404 is returned"
            status == 404

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def factura = new Factura(params).save(flush: true)

        then:"It exists"
            Factura.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(factura)

        then:"The instance is deleted"
            Factura.count() == 0
            response.redirectedUrl == '/factura/index'
            flash.message != null
    }
}
