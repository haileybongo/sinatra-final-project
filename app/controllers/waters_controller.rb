class WatersController < ApplicationController

  get '/waters' do
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
      @plant = Plant.find(params[:id]) 
      erb :"/waters/new.html"
    else
      redirect "/login"
     end
  end

  post "/waters" do
    if params[:content] != ""
        @water= Water.create(params)
        @plant = Plant.find(@water.plant_id)
        redirect "/plants/#{@plant.id}"
    else 
        redirect "/waters/new"
    end
  end

  get "/waters/:id" do
    if logged_in?
      @water= Water.find(params[:id])
      @plant = Plant.find(@water.plant_id)
      erb :"/waters/show.html"
    else 
        redirect "/login"
    end
  end

  get "/waters/:id/edit" do
    if logged_in?
      @water= Water.find(params[:id])
      erb :"/waters/edit.html"
    else
        redirect "/login" 
    end 
  end

  patch "/waters/:id/patch" do
    if params["water"] != ""
      @water = Water.find(params[:id])
      if params[:name] != ""
        @water.name = params["name"]
        @water.save
      end
      if params[:winter] != ""
        @water.winter = params["winter"]
        @water.save
      end
      if params[:summer] != ""
        @water.summer = params["summer"]
        @water.save
      end
      if params[:soil] != ""
        @water.soil = params["soil"]
        @water.save
      end
      if params[:humidity] != ""
        @water.humidity = params["humidity"]
        @water.save
      end
      redirect "/waters/#{@water.id}"
    else   
        redirect "/waters/#{params[:id]}/edit"
    end
  end

  delete "/waters/:id/delete" do
    @water = Water.find(params[:id])
    @plant = Plant.find(@water.plant_id)
    @id = @plant.id
    if logged_in? && current_user == User.find(@plant.user_id)
        @water.delete 
        redirect to "/plants/#{@plant.id}"
    else
      redirect to "/plants/#{@plant.id}" 
    end
  end

end
