class UsersController < ApplicationController

  get "/signup" do
    #CREATE user 
    if logged_in?
      @user = current_user 
      redirect '/home'
    else
      erb :'users/new.html'
    end
  end
    
  post "/signup" do
    #CREATE User
    binding.pry
    @user = User.create(params)
    if user.save && user.username != ""
      session[:user_id] = user.id
      @user = current_user 
      redirect "/home"
    else
      redirect "/signup"
    end
  end
    # if params[:username] != "" && params[:password] != ""  && params[:email]!= "" 
    #   if User.find_by(:email => params[:email]) == nil
    #     if User.find_by(:username => params[:username]) == nil
    #       user = User.create(:username => params[:username], :password => params[:password], :email => params[:email]) 	
    #         if user.save && user.username != ""
    #           session[:user_id] = user.id
    #           @user = current_user 
    #           redirect "/home"
    #         else
    #           redirect "/signup"
    #         end
    #     else
    #       @username = params[:username]
    #       erb :'users/signup2.html'
    #     end
    #   else
    #     @email = params[:email]
    #     erb :'users/signup2.html'
    #   end
    # else
    #   redirect "/signup"
    # end


  get "/home" do 
    if logged_in?
      @user = current_user 
      erb :"/users/home.html"
    else
      redirect '/login'
    end
  end

  get '/users/:id' do
    #READ User 
    @user = User.find_by(:id => params[:id])
    @plants = Plant.all.select {|plant| plant.user_id == @user.id}
    erb :"/users/show.html"
  end

  get "/users/:id/edit" do
    #UPDATE user
    erb :"/plants/edit.html"
  end


  patch "/users/:id" do
    #UPDATE user
    redirect "/users/:id"
  end

  delete "/plants/:id/delete" do
    #DELETE User
    redirect "/plants"
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
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/home"
    else
      redirect "/failure"
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
