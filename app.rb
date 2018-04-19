require "sinatra"
require "sinatra/reloader"
require_relative "grid.rb"
require_relative "boat.rb"
require_relative "boat_list.rb"

enable :sessions

get "/" do
  session[:guesses_left] = 10
  session[:game_grid] = Grid.new
  session[:boat_1] = Boat.new([2,3])
  session[:boat_2] = Boat.new([14,19])
  session[:boat_3] = Boat.new([16,17])
  session[:boat_4] = Boat.new([7,8,9])
  session[:boat_5] = Boat.new([10,15,20,25])
  session[:boat_list] = BoatList.new([session[:boat_1], session[:boat_2], session[:boat_3], session[:boat_4], session[:boat_5]])
  erb :welcome
end

get "/play_game" do
  session[:boat_1]
  session[:boat_2]
  session[:boat_3]
  session[:boat_4]
  session[:boat_5]
  session[:boat_list]
  session[:guesses_left]

  if params[:user_input]
    user_input = params[:user_input].to_i

  #conversion of user input to corresponding grid array element number
    if user_input < 6
      session[:array_number] = user_input - 1
    end
    if user_input > 5 && user_input < 11
      session[:array_number] = user_input 
    end
    if user_input > 10 && user_input < 16
      session[:array_number] = user_input + 1
    end
    if user_input > 15 && user_input < 21
      session[:array_number] = user_input + 2
    end
    if user_input > 20
      session[:array_number] = user_input + 3
    end

  #check if grid point is hit or miss and run mechanics accordingly
  if session[:boat_list].any_boat_hit?(user_input)
    session[:game_grid].record_hit(session[:array_number])
    boat_hit = session[:boat_list].which_boat_hit?(user_input)
    boat_hit.record_hit(user_input)
    if boat_hit.sunk?
      session[:boat_sunk_message]
    end
  else
    session[:game_grid].record_miss(session[:array_number])
    session[:guesses_left] -= 1
  end
  end
  erb :play_game
end

get "/win" do
  erb :win
end

get "/lose" do
  erb :lose
end
