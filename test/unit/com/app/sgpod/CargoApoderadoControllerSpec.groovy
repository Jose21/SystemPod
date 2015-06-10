package com.app.sgpod



import grails.test.mixin.*
import spock.lang.*

@TestFor(CargoApoderadoController)
@Mock(CargoApoderado)
class CargoApoderadoControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.cargoApoderadoInstanceList
            model.cargoApoderadoInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.cargoApoderadoInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def cargoApoderado = new CargoApoderado()
            cargoApoderado.validate()
            controller.save(cargoApoderado)

        then:"The create view is rendered again with the correct model"
            model.cargoApoderadoInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            cargoApoderado = new CargoApoderado(params)

            controller.save(cargoApoderado)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/cargoApoderado/show/1'
            controller.flash.message != null
            CargoApoderado.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def cargoApoderado = new CargoApoderado(params)
            controller.show(cargoApoderado)

        then:"A model is populated containing the domain instance"
            model.cargoApoderadoInstance == cargoApoderado
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def cargoApoderado = new CargoApoderado(params)
            controller.edit(cargoApoderado)

        then:"A model is populated containing the domain instance"
            model.cargoApoderadoInstance == cargoApoderado
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"A 404 error is returned"
            status == 404

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def cargoApoderado = new CargoApoderado()
            cargoApoderado.validate()
            controller.update(cargoApoderado)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.cargoApoderadoInstance == cargoApoderado

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            cargoApoderado = new CargoApoderado(params).save(flush: true)
            controller.update(cargoApoderado)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/cargoApoderado/show/$cargoApoderado.id"
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
            def cargoApoderado = new CargoApoderado(params).save(flush: true)

        then:"It exists"
            CargoApoderado.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(cargoApoderado)

        then:"The instance is deleted"
            CargoApoderado.count() == 0
            response.redirectedUrl == '/cargoApoderado/index'
            flash.message != null
    }
}
