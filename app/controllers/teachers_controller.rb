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

  post '/teachers/login' do
    @teacher=Teacher.find_by(first_name: params[:first_name], last_name: params[:last_name])
    if @teacher && @teacher.authenticate(params[:password])
      session[:user_id]=@teacher.id
    redirect to "/teachers/show/#{@teacher.id}"
    end
  end

  get '/teachers/show/:id' do
    @teacher=Teacher.find(session[:user_id])
    erb :"teachers/show"
  end

  get '/teachers/student/:id' do
    @student = Student.find(params[:id])
    erb :"teachers/student"
  end

  get '/teachers/:id/feedback' do
    @teacher = Teacher.find(params[:id])
    erb :"/teachers/feedback"
  end
end
