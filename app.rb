require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/dog.db")
class Dog
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
end
DataMapper.finalize.auto_upgrade!

#home
get '/' do
  erb :home
end

#index
get '/dogs' do
  @dogs = Dog.all
  erb :"dogs/index"
end

#new
get '/dogs/new' do
  erb :"dogs/new"
end

#create
post '/dogs' do
  Dog.create({:name => params[:name]})
  redirect '/dogs'
end

#show
get '/dogs/:id' do
  @dog = Dog.get(params[:id])
  erb :"dogs/show"
end

#edit
get '/dogs/:id/edit' do
  @dog = Dog.get(params[:id])
  erb :"dogs/edit"
end

#update
patch '/dogs/:id' do
  dog = Dog.get(params[:id])
  dog.update({:name => params[:name]})
  redirect "/dogs/#{params[:id]}"
end

#destroy
delete '/dogs/:id/delete' do
  dog = Dog.get(params[:id])
  dog.destroy
  redirect '/dogs'
end

