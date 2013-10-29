package com.app.sgpod



import grails.test.mixin.*
import spock.lang.*

@TestFor(PoderController)
@Mock(Poder)
class PoderControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.poderInstanceList
            model.poderInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.poderInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            def poder = new Poder()
            poder.validate()
            controller.save(poder)

        then:"The create view is rendered again with the correct model"
            model.poderInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            poder = new Poder(params)

            controller.save(poder)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/poder/show/1'
            controller.flash.message != null
            Poder.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def poder = new Poder(params)
            controller.show(poder)

        then:"A model is populated containing the domain instance"
            model.poderInstance == poder
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def poder = new Poder(params)
            controller.edit(poder)

        then:"A model is populated containing the domain instance"
            model.poderInstance == poder
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            controller.update(null)

        then:"A 404 error is returned"
            status == 404

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def poder = new Poder()
            poder.validate()
            controller.update(poder)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.poderInstance == poder

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            poder = new Poder(params).save(flush: true)
            controller.update(poder)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/poder/show/$poder.id"
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
            def poder = new Poder(params).save(flush: true)

        then:"It exists"
            Poder.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(poder)

        then:"The instance is deleted"
            Poder.count() == 0
            response.redirectedUrl == '/poder/index'
            flash.message != null
    }
}
