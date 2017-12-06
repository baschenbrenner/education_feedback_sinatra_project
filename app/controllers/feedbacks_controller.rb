require 'rack-flash'
require 'pry'
class FeedbacksController < ApplicationController
 use Rack::Flash


 get '/feedbacks/new' do
   authenticate_student!
        erb :"/feedbacks/new"

 end

 post '/feedbacks/new' do
   if params[:content] != ""
    @feedback = Feedback.create(content: params[:content])
   else
    @feedback = Feedback.create(content: params[:feedback])
   end
   current_user.feedbacks << @feedback
   current_user.save
   redirect to '/feedbacks/index'
 end

 get '/feedbacks/index' do
    authenticate_student!
     erb :"/feedbacks/index"
   end


  get '/feedbacks/edit/:id' do
    authenticate_student!
      @feedback = Feedback.find_by(id: params[:id])
      if @feedback && @feedback.student == current_user
        erb :"/feedbacks/edit"
      else
        flash[:message]="You don't have access to that page."
        redirect to '/feedbacks'
      end
  end

  get '/feedbacks/delete/:id' do
    authenticate_student!
      if Feedback.find(params[:id]).student == current_user
        @feedback = Feedback.find(params[:id])
        erb :"/feedbacks/delete"
      else
        flash[:message]="You don't have access to that page."
        redirect to '/students/login'
      end
  end

  patch '/feedbacks/:id/edit' do
    authenticate_student!
      if Feedback.find(params[:id]).student == current_user
        @feedback = Feedback.find(params[:id])
        @feedback.content = params[:content]
        @feedback.save
        redirect to "/feedbacks/index"
      else
        flash[:message]="You don't have access to that page."
        redirect to '/students/login'
      end

  end

  delete '/feedbacks/:id/delete' do
    authenticate_student!
      if Feedback.find(params[:id]).student == current_user
        @feedback = Feedback.find(params[:id])
        @feedback.delete
        redirect to "/feedbacks/index"
      else
        flash[:message]="You don't have access to that page."
        redirect to '/students/login'
      end
  
  end

end
