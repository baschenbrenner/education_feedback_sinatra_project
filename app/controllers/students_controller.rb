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
    @student=Student.find_by(username: params[:username])
    if @student && @student.authenticate(params[:password])
      session[:user_id]=@student.id
      session[:user_type]="student"
    redirect to "/students/#{@student.id}/show"
    else
      flash[:message]="You entered invalid login credentials."
      redirect '/students/login'
    end
  end


  post '/students/signup' do
    @student=Student.new(first_name: params[:first_name], last_name: params[:last_name], preferred_name: params[:preferred_name], username: params[:username], password: params[:password])
    if @student.save
      if params[:teacher] != nil
      @student.teacher = Teacher.find(params[:teacher])
      @student.save
      end
    flash[:message]="You have successfully created an account. Now you can log in!"
    redirect to '/students/login'
    else
      flash[:message]="That username is already taken. Try again!"
      redirect to '/students/signup'
    end
  end

  get "/students/:id/show" do
    authenticate_student!
        erb :"students/show"
  end
end
