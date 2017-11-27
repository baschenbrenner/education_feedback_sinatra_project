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


end
