class PlantsController < ApplicationController

  get '/plants' do
    #READ plants
    if logged_in?
      @user = current_user
      @plants = Plant.all
      erb :"/plants/index.html"
    else
      redirect "/login"
    end
  end

  # GET: /plants/new
  get '/plants/new' do
    if logged_in?
      erb :"/plants/new.html"
    else
      redirect "/login"
     end
  end

  # POST: /plants
  post "/plants" do
    if params[:content] != ""
        @plant= Plant.create(params)
        user = User.find_by(:id => session[:user_id])
        @plant.user_id = user.id
        @plant.save
        redirect "/plants/#{@plant.id}"
    else 
        redirect "/plants/new"
    end
  end

  # GET: /plants/5
  get "/plants/:id" do
    if logged_in?
      @plant = Plant.find_by(:id => params[:id])
      @user = User.find_by(:id => @plant.user_id)
      erb :"/plants/show.html"
    else 
        redirect "/login"
    end
  end

  # GET: /plants/5/edit
  get "/plants/:id/edit" do
    if logged_in?
      @plant = Plant.find_by(:id => params[:id])
      @user = User.find_by(:id => @plant.user_id)
      erb :"/plants/edit.html"
    else
        redirect "/login" 
    end 
  end

  # PATCH: /plants/5
  patch "/plants/:id/patch" do
    if params["plant"] != ""
      @plant = Plant.find_by(:id => params[:id])
      if params[:name] != ""
        @plant.name = params["name"]
        @plant.save
      end
      if params[:light] != ""
        @plant.light = params["light"]
        @plant.save
      end
      if params[:notes] != ""
        @plant.notes = params ["notes"]
        @plant.save
      end
      redirect "/plants/#{@plant.id}"
    else   
        redirect "/plants/#{params[:id]}/edit"
    end
  end

  # DELETE: /plants/5/delete
  delete "/plants/:id/delete" do
    @plant = Plant.find_by(:id => params[:id])
    if logged_in? && current_user == User.find_by(:id => @plant.user_id)
        @plant.delete 
        redirect to '/plants'
    else
        redirect to '/plants' 
    end
  end

helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def current_plant
      Plant.find_by(:id => params[:id])
    end
  end
end
