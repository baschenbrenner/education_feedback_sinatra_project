require 'rack-flash'
class StudentsController < ApplicationController
  use Rack::Flash

  get "/students" do
    erb :"students/index"
  end

  get "/students/login" do

    erb :"students/login"
  end

  get "/students/signup" do
    erb :"students/signup"
  end

  post "/students/login" do
    @student=Student.find_by(first_name: params[:first_name], last_name: params[:last_name])
    if @student && @student.authenticate(params[:password])
      session[:user_id]=@student.id
      session[:user_type]="student"
    redirect to "/students/show/#{@student.id}"
    else
      flash[:message]="You entered invalid login credentials."
      redirect '/students/login'
    end
  end


  post '/students/signup' do
    @student=Student.create(first_name: params[:first_name], last_name: params[:last_name], preferred_name: params[:preferred_name], password: params[:password])
    @teacher = Teacher.find(params[:teacher])
    @student.teacher=@teacher
    @student.save
    flash[:message]="You have successfully created an account. Now you can log in!"
    redirect to '/students/login'
  end

  get "/students/show/:id" do
    if session[:user_type]="student"
      if params[:id].to_i == session[:user_id].to_i
        @student= Student.find(params[:id])
        erb :"students/show"
      else
        flash[:message]="You don't have access to that page."
        redirect to '/students/login'
      end
    else
      flash[:message]="This page is for students."
      redirect to '/students/login'
    end
  end
end
