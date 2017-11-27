require 'rack-flash'
class FeedbacksController < ApplicationController
 use Rack::Flash


 get '/feedbacks/new' do
   
   erb :"/feedbacks/new"
 end

 post '/feedbacks/new' do
   @feedback = Feedback.create(content: params[:content])
   @student = Student.find(session[:user_id])
   @student.feedbacks << @feedbacks
   @feedback.save
   @student.save
   redirect to '/feedbacks/index'
 end

end
