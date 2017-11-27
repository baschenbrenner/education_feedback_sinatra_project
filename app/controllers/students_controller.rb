class StudentsController < ApplicationController

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
    redirect to "/teachers/show/#{@student.id}"
    else
      flash[:message]="You entered invalid login credentials."
      redirect '/teachers/login'
    end
  end
end
