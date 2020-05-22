class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      @user = current_user 
      redirect '/home'
    else
      erb :'users/new.html'
    end
  end
    
  post "/signup" do
    @user = User.create(params)
    if @user.save && @user.username != "" && @user.email != ""
      session[:user_id] = @user.id
      @user = current_user 
      redirect "/home"
    else
      @errors = @user.errors.full_messages
      erb :'users/new.html'
    end
  end

  get "/home" do 
    if logged_in?
      @user = current_user 
      erb :"/users/home.html"
    else
      redirect '/login'
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    @plants = Plant.all.select {|plant| plant.user_id == @user.id}
    erb :"/users/show.html"
  end

  get '/login' do
    if logged_in?
      redirect '/home'
    else
      erb :'users/login.html'
    end  
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user != nil && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/home"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end


end
