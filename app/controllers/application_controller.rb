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
  			params[:id].to_i == current_user.id
  		end

  		def current_user
        if session[:user_type]=="teacher"
          Teacher.find(session[:user_id])
        elsif session[:user_type]=="student"
          Student.find(session[:user_id])
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
