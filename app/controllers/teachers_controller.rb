class TeachersController < ApplicationController
  get '/teachers' do
    erb :"teachers/index"
  end
end
