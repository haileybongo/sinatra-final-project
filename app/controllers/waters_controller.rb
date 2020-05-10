class WatersController < ApplicationController

  get '/waters' do
    #READ waters
    if logged_in?
      @user = current_user
      @waters = Water.all
      erb :"/waters/index.html"
    else
      redirect "/login"
    end
  end

  get '/waters/new' do
    if logged_in?
      erb :"/waters/new.html"
    else
      redirect "/login"
     end
  end

  post "/waters" do
    if params[:content] != ""
        @water= Water.create(params)
        plant = Plant.find_by(:id => params[:plant_name])
        @water.plant_id = plant.id
        @water.save
        redirect "/water/#{@water.id}"
    else 
        redirect "/waters/new"
    end
  end

  # GET: /waters/5
  get "/waters/:id" do
    if logged_in?
      @water= water.find_by(:id => params[:id])
      @user = User.find_by(:id => @plant.user_id)
      erb :"/waters/show.html"
    else 
        redirect "/login"
    end
  end

  # GET: /waters/5/edit
  get "/waters/:id/edit" do
    if logged_in?
      @water= water.find_by(:id => params[:id])
      @user = User.find_by(:id => @plant.user_id)
      erb :"/waters/edit.html"
    else
        redirect "/login" 
    end 
  end

  # PATCH: /waters/5
  patch "/waters/:id/patch" do
    if params["water"] != ""
      @water = water.find_by(:id => params[:id])
      if params[:name] != ""
        @water.name = params["name"]
        @water.save
      end
      if params[:light] != ""
        @water.light = params["light"]
        @water.save
      end
      if params[:notes] != ""
        @water.notes = params ["notes"]
        @water.save
      end
      redirect "/waters/#{@water.id}"
    else   
        redirect "/waters/#{params[:id]}/edit"
    end
  end

  # DELETE: /waters/5/delete
  delete "/waters/:id/delete" do
    @water = water.find_by(:id => params[:id])
    if logged_in? && current_user == User.find_by(:id => @water.user_id)
        @water.delete 
        redirect to '/waters'
    else
        redirect to '/waters' 
    end
  end

helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def current_plant(id)
      water.find_by(:id => id)
    end
  end
end
