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

  get '/waters/:id/new' do
    if logged_in?
      @plant = Plant.find_by(:id => params[:id]) 
      erb :"/waters/new.html"
    else
      redirect "/login"
     end
  end

  post "/waters" do
    if params[:content] != ""
        @water= Water.create(params)
        redirect "/waters/#{@water.id}"
    else 
        redirect "/waters/new"
    end
  end

  # GET: /waters/5
  get "/waters/:id" do
    if logged_in?
      @water= Water.find_by(:id => params[:id])
      @plant = Plant.find_by(:id => @water.plant_id)
      erb :"/waters/show.html"
    else 
        redirect "/login"
    end
  end

  # GET: /waters/5/edit
  get "/waters/:id/edit" do
    if logged_in?
      @water= Water.find_by(:id => params[:id])
      erb :"/waters/edit.html"
    else
        redirect "/login" 
    end 
  end

  # PATCH: /waters/5
  patch "/waters/:id/patch" do
    if params["water"] != ""
      @water = Water.find_by(:id => params[:id])
      if params[:name] != ""
        @water.name = params["name"]
        @water.save
      end
      if params[:winter] != ""
        @water.winter = params["winter"]
        @water.save
      end
      if params[:summer] != ""
        @water.notes = params ["summer"]
        @water.save
      end
      if params[:soil] != ""
        @water.notes = params ["soil"]
        @water.save
      end
      if params[:humidity] != ""
        @water.notes = params ["humidity"]
        @water.save
      end
      redirect "/waters/#{@water.id}"
    else   
        redirect "/waters/#{params[:id]}/edit"
    end
  end

  # DELETE: /waters/5/delete
  delete "/waters/:id/delete" do
    @water = Water.find_by(:id => params[:id])
    @plant = Plant.find_by(:id => @water.plant_id)
    @id = @plant.id
    if logged_in? && current_user == User.find_by(:id => @plant.user_id)
        @water.delete 
        redirect to "/plants/#{@plant.id}"
    else
      redirect to "/plants/#{@plant.id}" 
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
