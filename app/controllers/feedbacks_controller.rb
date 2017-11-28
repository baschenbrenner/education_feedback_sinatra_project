require 'rack-flash'
require 'pry'
class FeedbacksController < ApplicationController
 use Rack::Flash


 get '/feedbacks/new' do
   @student = Student.find(session[:user_id])
      erb :"/feedbacks/new"
 end

 post '/feedbacks/new' do
   binding.pry
   if params[:content] != ""
     @feedback = Feedback.create(content: params[:content])
    else
      @feedback = Feedback.create(content: params[:checkbox_feedback])
    end
   @student = Student.find(session[:user_id])
   @student.feedbacks << @feedback
   @feedback.save
   @student.save
   redirect to '/feedbacks/index'
 end

 get '/feedbacks/index' do
 @student = Student.find(session[:user_id])
 erb :"/feedbacks/index"
 end


  get '/feedbacks/edit/:id' do
    @feedback = Feedback.find(params[:id])
    erb :"/feedbacks/edit"
  end

  get '/feedbacks/delete/:id' do
    @feedback = Feedback.find(params[:id])
    erb :"/feedbacks/delete"
  end

  post '/feedbacks/edit/:id' do
    @feedback = Feedback.find(params[:id])
    @feedback.content = params[:content]
    @feedback.save
    redirect to "/feedbacks/index"
  end

  post '/feedbacks/delete/:id' do
    @feedback = Feedback.find(params[:id])
    @feedback.delete
    redirect to "/feedbacks/index"
  end

end
