require 'sinatra'
require 'sinatra/json'
require 'bundler'

Bundler.require
require_relative './lib/user'

DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.finalize
DataMapper.auto_migrate!

class UserController < Sinatra::Base
    get '/' do
        "Coding task!"
    end

    get '/users/:id' do
        content_type :json

        user = User.get params[:id]
        unless user.nil?
            status 200
            json user
        else
            status 404
            "User not found"
        end
    end

    post '/users' do
        content_type :json

        user = User.new params
        if user.save
            status 201
            json user
        else
            status 500
            json user.errors.full_messages
        end
    end
end