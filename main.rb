require 'sinatra'
require './student'
require 'sass'
require 'erb'

 configure do
  enable :sessions
  set :username, 'divya'
  set :password, 'drl'
end

configure :development do
  DataMapper.setup(:default, ENV['DATABASE_URL'] ||"sqlite3://#{Dir.pwd}/test.db")
end

configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end



get('/css/styles.css') do 
 scss :stylup 
end



get '/' do
   @title = "home"
  erb :home
end

get '/home' do
   @title = "home"
  erb :home
end


get '/about' do
  
  @title = "All About This Website"
  erb :about
end

get '/contact' do
   @title = "contact"
  erb :contact
end



not_found do
   @title = "not found"
  erb :not_found
end

get '/login' do
   @title = "login page"
  erb :login
end

post '/login' do
  if params[:username] == settings.username && params[:password] == settings.password
    session[:admin] = true
    redirect to('/students')
  else
    erb :login
  end
end

get '/logout' do
  session.clear
   session[:username] = nil
  erb :signout
end

