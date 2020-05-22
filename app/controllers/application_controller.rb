require './config/environment'


class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "cb386f4f44f3fc2b7cea2901023d897016000cc7ccb497ecb2ed9dec208d12c8a9786e36eb2fe67a070168f2224a5aad8141b4a9f1b60c73c2301fcbd67a9b34"
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
