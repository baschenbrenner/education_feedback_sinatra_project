class TeachersController < ApplicationController
  get '/teachers' do
    erb :"teachers/index"
  end

  get '/teachers/login' do
    erb :"teachers/login"
  end

  get '/teachers/signup' do
    erb :"teachers/signup"
  end
end
