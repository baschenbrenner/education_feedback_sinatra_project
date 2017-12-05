require 'rack-flash'
require 'pry'
class FeedbacksController < ApplicationController
 use Rack::Flash


 get '/feedbacks/new' do
   if authenticate_student! && logged_in?
     @student = current_user
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
   @student = current_user
   @student.feedbacks << @feedback
   @student.save
   redirect to '/feedbacks/index'
 end

 get '/feedbacks/index' do
   if authenticate_student! && logged_in?
     @student = current_user
     erb :"/feedbacks/index"
   else
     flash[:message]="This page is for students."
     redirect to '/students/login'
   end


 end


  get '/feedbacks/edit/:id' do
    if authenticate_student! && logged_in?
      @feedback = Feedback.find_by(id: params[:id])
      if @feedback && @feedback.student == current_user

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
    if authenticate_student! && logged_in?
      if Feedback.find(params[:id]).student == current_user
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

  patch '/feedbacks/:id/edit' do
    if authenticate_student! && logged_in?
      if Feedback.find(params[:id]).student == current_user
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

  delete '/feedbacks/:id/delete' do
    if authenticate_student! && logged_in?
      if Feedback.find(params[:id]).student == current_user
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
