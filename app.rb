require 'sinatra'
require 'sinatra/json'
require 'bundler'

Bundler.require
require 'user'

DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.finalize
DataMapper.auto_migrate!

get '/' do
    "Coding task!"
end

get '/users/:id' do
    user = User.get(params[:id])
    unless user.nil?
        user.to_json
    else
        "Not found"
    end
end

post '/users' do
    user = User.new params
    if user.save
        status 201
        user.to_json
    else
        user.errors.full_messages.to_json
    end
end