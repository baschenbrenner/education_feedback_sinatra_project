require 'rack-flash'
require 'pry'
class FeedbacksController < ApplicationController
 use Rack::Flash


 get '/feedbacks/new' do
   if session[:user_type]="student"
     @student = Student.find(session[:user_id])
        erb :"/feedbacks/new"
   else
     flash[:message]="This page is for students."
     redirect to '/students/login'
   end

 end

 post '/feedbacks/new' do
   if params[:content] != ""
    @feedback = Feedback.create(content: params[:content])
   else
    @feedback = Feedback.create(content: params[:feedback])
  end
   @student = Student.find(session[:user_id])
   @student.feedbacks << @feedback

   @student.save
   redirect to '/feedbacks/index'
 end

 get '/feedbacks/index' do
   if session[:user_type]="student"
     @student = Student.find(session[:user_id])
     erb :"/feedbacks/index"
   else
     flash[:message]="This page is for students."
     redirect to '/students/login'
   end


 end


  get '/feedbacks/edit/:id' do
    if session[:user_type]="student"
      @feedback = Feedback.find_by(id: params[:id])
      if @feedback && @feedback.student_id == session[:user_id]

        erb :"/feedbacks/edit"
      else
        flash[:message]="You don't have access to that page."
        redirect to '/feedbacks'
      end
    else
      flash[:message]="This page is for students."
      redirect to '/students/login'
    end

  end

  get '/feedbacks/delete/:id' do
    if session[:user_type]="student"
      if Feedback.find(params[:id]).student.id == session[:user_id]
        @feedback = Feedback.find(params[:id])
        erb :"/feedbacks/delete"
      else
        flash[:message]="You don't have access to that page."
        redirect to '/students/login'
      end
    else
      flash[:message]="This page is for students."
      redirect to '/students/login'
    end


  end

  post '/feedbacks/edit/:id' do
    if session[:user_type]="student"
      if Feedback.find(params[:id]).student.id == session[:user_id]
        @feedback = Feedback.find(params[:id])
        @feedback.content = params[:content]
        @feedback.save
        redirect to "/feedbacks/index"
      else
        flash[:message]="You don't have access to that page."
        redirect to '/students/login'
      end
    else
      flash[:message]="This page is for students."
      redirect to '/students/login'
    end

  end

  post '/feedbacks/delete/:id' do
    if session[:user_type]="student"
      if Feedback.find(params[:id]).student.id == session[:user_id]
        @feedback = Feedback.find(params[:id])
        @feedback.delete
        redirect to "/feedbacks/index"
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

# helper methods

# current_user
# logged_in?

# private methods
# authenticate_teacher!
# authenticate_student!
