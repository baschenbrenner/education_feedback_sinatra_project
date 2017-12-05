class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :session_secret, "password_security"
  set :views, Proc.new { File.join(root, "../views/") }

  get "/" do
    session.clear
    erb :index
  end

  get "/index" do
    session.clear
    erb :index
  end

  get "/about" do
    erb :about
  end


  helpers do
  		def logged_in?
        !!current_user
  		end

  		def current_user
        if authenticate_teacher!
          @current_user ||= Teacher.find_by(id: session[:user_id]) if session[:user_id]
        elsif authenticate_student!
          @current_user ||= Student.find_by(id: session[:user_id]) if session[:user_id]
        else
          return nil
        end
  		end
  	end


  private
    def authenticate_teacher!
      session[:user_type]=="teacher"
    end
    def authenticate_student!
      session[:user_type]=="student"
    end


end
