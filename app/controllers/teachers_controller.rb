require 'rack-flash'

class TeachersController < ApplicationController
  use Rack::Flash

  get '/teachers' do
    session.clear
    erb :"teachers/index"
  end

  get '/teachers/login' do
    session.clear
    erb :"teachers/login"
  end

  get '/teachers/signup' do
    erb :"teachers/signup"
  end

  post '/teachers/signup' do
    @teacher=Teacher.create(first_name: params[:first_name], last_name: params[:last_name], preferred_name: params[:preferred_name], password: params[:password])
    @teacher.save
    flash[:message]="You have successfully created an account. Now you can log in!"
    redirect to '/teachers/login'
  end

  post '/teachers/login' do
    @teacher=Teacher.find_by(first_name: params[:first_name], last_name: params[:last_name])
    if @teacher && @teacher.authenticate(params[:password])
      session[:user_id]=@teacher.id
      session[:user_type]="teacher"
    redirect to "/teachers/show/#{@teacher.id}"
    else
      flash[:message]="You entered invalid login credentials."
      redirect '/teachers/login'
    end
  end

  get '/teachers/show/:id' do
    if session[:user_type]=="teacher"
      if params[:id].to_i == session[:user_id].to_i
        @teacher=Teacher.find(session[:user_id])
        erb :"teachers/show"
      else
        flash[:message]="This path belongs to another teacher."
        redirect to "/teachers/login"
      end
    else
      flash[:message]="You do not have access to teacher content."
      redirect to "/students/login"
    end

   end

  get '/teachers/student/:id' do
    if session[:user_type]=="teacher"
      if Student.find(params[:id]).teacher.id == session[:user_id].to_i
        @student = Student.find(params[:id])
        erb :"teachers/student"
      else
        flash[:message]="This student belongs to another teacher."
        redirect to "/teachers/login"
      end
    else
      flash[:message]="You do not have access to teacher content."
      redirect to "/students/login"
    end

  end

  get '/teachers/:id/feedback' do
    if session[:user_type]=="teacher"
      if params[:id].to_i == session[:user_id].to_i
        @teacher = Teacher.find(params[:id])
        erb :"/teachers/feedback"
      else
        flash[:message]="This path belongs to another teacher."
        redirect to "/teachers/login"
      end
    else
      flash[:message]="You do not have access to teacher content."
      redirect to "/students/login"
    end
  end


end
