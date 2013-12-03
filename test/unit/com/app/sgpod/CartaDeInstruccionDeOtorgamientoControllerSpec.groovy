package com.app.sgpod



import grails.test.mixin.*
import spock.lang.*

@TestFor(CartaDeInstruccionDeOtorgamientoController)
@Mock(CartaDeInstruccionDeOtorgamiento)
class CartaDeInstruccionDeOtorgamientoControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.cartaDeInstruccionDeOtorgamientoInstanceList
            model.cartaDeInstruccionDeOtorgamientoInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.cartaDeInstruccionDeOtorgamientoInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def cartaDeInstruccionDeOtorgamiento = new CartaDeInstruccionDeOtorgamiento()
            cartaDeInstruccionDeOtorgamiento.validate()
            controller.save(cartaDeInstruccionDeOtorgamiento)

        then:"The create view is rendered again with the correct model"
            model.cartaDeInstruccionDeOtorgamientoInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            cartaDeInstruccionDeOtorgamiento = new CartaDeInstruccionDeOtorgamiento(params)

            controller.save(cartaDeInstruccionDeOtorgamiento)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/cartaDeInstruccionDeOtorgamiento/show/1'
            controller.flash.message != null
            CartaDeInstruccionDeOtorgamiento.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def cartaDeInstruccionDeOtorgamiento = new CartaDeInstruccionDeOtorgamiento(params)
            controller.show(cartaDeInstruccionDeOtorgamiento)

        then:"A model is populated containing the domain instance"
            model.cartaDeInstruccionDeOtorgamientoInstance == cartaDeInstruccionDeOtorgamiento
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def cartaDeInstruccionDeOtorgamiento = new CartaDeInstruccionDeOtorgamiento(params)
            controller.edit(cartaDeInstruccionDeOtorgamiento)

        then:"A model is populated containing the domain instance"
            model.cartaDeInstruccionDeOtorgamientoInstance == cartaDeInstruccionDeOtorgamiento
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"A 404 error is returned"
            status == 404

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def cartaDeInstruccionDeOtorgamiento = new CartaDeInstruccionDeOtorgamiento()
            cartaDeInstruccionDeOtorgamiento.validate()
            controller.update(cartaDeInstruccionDeOtorgamiento)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.cartaDeInstruccionDeOtorgamientoInstance == cartaDeInstruccionDeOtorgamiento

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            cartaDeInstruccionDeOtorgamiento = new CartaDeInstruccionDeOtorgamiento(params).save(flush: true)
            controller.update(cartaDeInstruccionDeOtorgamiento)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/cartaDeInstruccionDeOtorgamiento/show/$cartaDeInstruccionDeOtorgamiento.id"
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
            def cartaDeInstruccionDeOtorgamiento = new CartaDeInstruccionDeOtorgamiento(params).save(flush: true)

        then:"It exists"
            CartaDeInstruccionDeOtorgamiento.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(cartaDeInstruccionDeOtorgamiento)

        then:"The instance is deleted"
            CartaDeInstruccionDeOtorgamiento.count() == 0
            response.redirectedUrl == '/cartaDeInstruccionDeOtorgamiento/index'
            flash.message != null
    }
}
