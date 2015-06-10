package com.app.sgpod



import grails.test.mixin.*
import spock.lang.*

@TestFor(CategoriaDeTipoDePoderController)
@Mock(CategoriaDeTipoDePoder)
class CategoriaDeTipoDePoderControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.categoriaDeTipoDePoderInstanceList
            model.categoriaDeTipoDePoderInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.categoriaDeTipoDePoderInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def categoriaDeTipoDePoder = new CategoriaDeTipoDePoder()
            categoriaDeTipoDePoder.validate()
            controller.save(categoriaDeTipoDePoder)

        then:"The create view is rendered again with the correct model"
            model.categoriaDeTipoDePoderInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            categoriaDeTipoDePoder = new CategoriaDeTipoDePoder(params)

            controller.save(categoriaDeTipoDePoder)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/categoriaDeTipoDePoder/show/1'
            controller.flash.message != null
            CategoriaDeTipoDePoder.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def categoriaDeTipoDePoder = new CategoriaDeTipoDePoder(params)
            controller.show(categoriaDeTipoDePoder)

        then:"A model is populated containing the domain instance"
            model.categoriaDeTipoDePoderInstance == categoriaDeTipoDePoder
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def categoriaDeTipoDePoder = new CategoriaDeTipoDePoder(params)
            controller.edit(categoriaDeTipoDePoder)

        then:"A model is populated containing the domain instance"
            model.categoriaDeTipoDePoderInstance == categoriaDeTipoDePoder
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"A 404 error is returned"
            status == 404

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def categoriaDeTipoDePoder = new CategoriaDeTipoDePoder()
            categoriaDeTipoDePoder.validate()
            controller.update(categoriaDeTipoDePoder)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.categoriaDeTipoDePoderInstance == categoriaDeTipoDePoder

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            categoriaDeTipoDePoder = new CategoriaDeTipoDePoder(params).save(flush: true)
            controller.update(categoriaDeTipoDePoder)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/categoriaDeTipoDePoder/show/$categoriaDeTipoDePoder.id"
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
            def categoriaDeTipoDePoder = new CategoriaDeTipoDePoder(params).save(flush: true)

        then:"It exists"
            CategoriaDeTipoDePoder.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(categoriaDeTipoDePoder)

        then:"The instance is deleted"
            CategoriaDeTipoDePoder.count() == 0
            response.redirectedUrl == '/categoriaDeTipoDePoder/index'
            flash.message != null
    }
}
