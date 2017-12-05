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
  			!!session[:user_id]
  		end

  		def current_user
  			User.find(session[:user_id])
  		end
  	end


  private
    def authenticate_teacher!
      session[:user_type]=="teacher"
    end



end
