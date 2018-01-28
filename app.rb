require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'sinatra'
require 'sinatra/json'
require './models.rb'
require 'open-uri'
require 'time'

require './models'

enable :sessions

helpers do
	def current_user
		User.find_by(id: session[:user])
	end
end

#ROOT------------------------------------------------------------------
get '/' do
	@userdbs = User.all
	erb :index
end

get '/signin' do
	erb :index
end

get '/signup' do
	#, layout: nilを完成ご消す。
	erb :sign_up, layout: nil
end

get '/fast' do
	erb :fast
end
get '/runa' do
	erb :_runa
end
get '/tuti' do
	erb :_tuchida
end
get '/momo' do
	erb :_momo
end
get '/iga' do
	erb :_igarashi
end

get '/hama' do
	erb :_hamasaki
end

#USER------------------------------------------------------------------
post '/signup' do
	user = User.create(
		name: params[:name],
		unique_id: params[:unique_id],
		password: params[:password],
		password_confirmation: params[:password_confirmation]
	)
	if user.persisted?
		session[:user] = user.id
	end
	redirect '/'
end

post '/signin' do
	user = User.find_by(unique_id: params[:unique_id])
	if user && user.authenticate(params[:password])
		p session[:user] = user.id
	else
		p @sign_message = "IDまたはpasswordが間違って居ます。"
		redirect '/'
	end
	if session[:user] == 1
		redirect '/signup'
	end
	if session[:user] == 2
		redirect '/runa'
	end
	if session[:user] == 3
		redirect '/tuti'
	end
	if session[:user] == 4
		redirect '/momo'
	end
	if session[:user] == 5
		redirect '/iga'
	end
	if session[:user] == 6
		redirect '/hama'
	end

	redirect '/'
end

get '/signout' do
	session.clear
	redirect '/'
end

