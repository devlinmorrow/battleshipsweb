require "sinatra"
require "sinatra/reloader"

get "/" do
  erb :index
end

get "/game" do
  if params[:point_one] 
    @point_one = "O"
  else @point_one = "X"
  end
  if params[:point_two] 
    @point_two = "O"
  else @point_two = "X"
  end
  erb :game
end



