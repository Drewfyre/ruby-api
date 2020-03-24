require_relative 'user_controller'
require 'test/unit'
require 'rack/test'

ENV['APP_ENV'] = 'test'

class UserControllerTest < Test::Unit::TestCase

    def test_index_says_coding_task
        browser = Rack::Test::Session.new(Rack::MockSession.new(UserController))
        browser.get '/'
        assert browser.last_response.ok?
        assert_equal 'Coding task!', browser.last_response.body
    end

    def test_it_inserts_a_user
        user_params = {"name" => "Mustermann", "email" => "mustermann@gmail.com"}
        browser = Rack::Test::Session.new(Rack::MockSession.new(UserController))
        browser.post '/users', user_params
        assert browser.last_response.created?
        assert browser.last_response.body.include?('"id":1')
    end

    def test_it_does_not_insert_a_user_if_name_is_null
        user_params = {"name" => nil, "email" => "mustermann@gmail.com"}
        browser = Rack::Test::Session.new(Rack::MockSession.new(UserController))
        browser.post '/users', user_params
        assert_equal 500, browser.last_response.status
        assert browser.last_response.body.include?('Name cannot be blank')
    end

    def test_it_does_not_insert_a_user_if_mail_is_null
        user_params = {"name" => "Mustermann", "email" => nil}
        browser = Rack::Test::Session.new(Rack::MockSession.new(UserController))
        browser.post '/users', user_params
        assert_equal 500, browser.last_response.status
        assert browser.last_response.body.include?('Email cannot be blank')
    end

    def test_it_returns_a_user
        browser = Rack::Test::Session.new(Rack::MockSession.new(UserController))
        browser.get '/users/1'
        assert_equal 200, browser.last_response.status
        assert browser.last_response.body.include?('"id":1,"name":"Mustermann"')
    end

    def test_it_returns_404_if_no_user_was_found
        browser = Rack::Test::Session.new(Rack::MockSession.new(UserController))
        browser.get '/users/40'
        assert_equal 404, browser.last_response.status
        assert browser.last_response.body.include?('User not found')
    end
end