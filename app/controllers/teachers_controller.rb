class TeachersController < ApplicationController
  get '/teachers' do
    erb :"teachers/index"
  end

  get '/teachers/login' do
    erb :"teachers/login"
  end

  get '/teachers/signup' do
    erb :"teachers/signup"
  end

  post '/teachers/signup' do
    @teacher=Teacher.create(first_name: params[:first_name], last_name: params[:last_name], preferred_name: params[:preferred_name], password: params[:password])
    @teacher.save
    redirect to '/teachers/login'
  end

  post '/teachers/signup' do
    @teacher=Teacher.find_by(first_name: params[:first_name], last_name: params[:last_name])
    if @teacher && @teacher.authenticate(params[:password])
    redirect to '/teachers/show'
  end
end
