require "sinatra"
require "sinatra/reloader"

get "/" do
  erb :index
end

get "/game/:points" do
  @grid_state = params[:points]
  @grid_state += "#{params.key(params[:point])}=#{params[:point]}"
  if @grid_state.include?("01") 
    @point_01 = "O"
  else 
    @point_01 = "X"
  end
  if @grid_state.include?("02") 
    @point_02 = "O"
  else 
    @point_02 = "X"
  end
  if @grid_state.include?("03") 
    @point_03 = "O"
  else 
    @point_03 = "X"
  end
  if @grid_state.include?("04") 
    @point_04 = "O"
  else 
    @point_04 = "X"
  end
  if @grid_state.include?("05") 
    @point_05 = "H"
  else 
    @point_05 = "X"
  end
  if @grid_state.include?("06") 
    @point_06 = "H"
  else 
    @point_06 = "X"
  end
  if @grid_state.include?("07") 
    @point_07 = "O"
  else 
    @point_07 = "X"
  end
  if @grid_state.include?("08") 
    @point_08 = "O"
  else 
    @point_08 = "X"
  end
  if @grid_state.include?("09") 
    @point_09 = "O"
  else 
    @point_09 = "X"
  end
  @grid_points = [@point_01, @point_02, @point_03, "<br>", @point_04, @point_05, @point_06, "<br>", @point_07, @point_08, @point_09]
  erb :game
end



