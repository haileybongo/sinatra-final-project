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

  get '/plants/new' do
    if logged_in?
      erb :"/plants/new.html"
    else
      redirect "/login"
     end
  end

  post "/plants" do
    if params[:content] != ""
        @plant= Plant.create(params)
        user = User.find(session[:user_id])
        @plant.user_id = user.id
        @plant.save
        redirect "/plants/#{@plant.id}"
    else 
        redirect "/plants/new"
    end
  end

  get "/plants/:id" do
    if logged_in?
      @plant = current_plant(params[:id])
      @water = Water.find_by(:plant_id => @plant.id)
      @user = User.find(@plant.user_id)
      @current_user = current_user
      erb :"/plants/show.html"
    else 
        redirect "/login"
    end
  end

  get "/plants/:id/edit" do
    if logged_in? 
      @plant = current_plant(params[:id])
      @user = User.find(@plant.user_id)
      if @user.id == current_user.id
        erb :"/plants/edit.html"
      else
        redirect "/plants/#{@plant.id}"
      end
    else
        redirect "/login" 
    end 
  end


  patch "/plants/:id/patch" do
    if params["plant"] != ""
      @plant = current_plant(params[:id])
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
    @plant = current_plant(params[:id])
    if logged_in? && current_user == User.find(@plant.user_id)
        @plant.delete 
        redirect to '/plants'
    else
        redirect to '/plants' 
    end
  end

private
    def current_plant(id)
      Plant.find(id)
    end

end
