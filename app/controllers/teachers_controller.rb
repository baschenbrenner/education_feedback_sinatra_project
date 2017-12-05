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
    @teacher = Teacher.new(first_name: params[:first_name], last_name: params[:last_name], preferred_name: params[:preferred_name], username: params[:username], password: params[:password])
    if @teacher.save
      flash[:message]="You have successfully created an account. Now you can log in!"
    redirect to '/teachers/login'
    else
      flash[:message]="That username is already taken. Try another one."
      redirect 'teachers/signup'
    end
  end

  post '/teachers/login' do
    @teacher=Teacher.find_by(username: params[:username])
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
    if authenticate_teacher!
      if logged_in?
        @teacher=current_user
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
    if authenticate_teacher!
      if Student.find(params[:id]).teacher.id == current_user.id
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
    if authenticate_teacher!
      if logged_in?
        @teacher = current_user
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
