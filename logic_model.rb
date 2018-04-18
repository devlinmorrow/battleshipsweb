class GameLogic

  attr_accessor :guesses_left, :game_boat_list
  attr_reader :game_grid, :target_grid_point 

  LETTERCOLLECTION = ("A".."Z").to_a

  def initialize
    @guesses_left = 20
    @game_grid = Grid.new
    @game_boat_list = BoatList.new(create_boat_list)
  end

  def create_boat_list
    [@boat_1 = Boat.new([[9,1]]),
     @boat_2 = Boat.new([[8,3]]),
     @boat_3 = Boat.new([[7,1]]),
     @boat_4 = Boat.new([[2,7]]),
     @boat_5 = Boat.new([[6,5],[6,6]]),
     @boat_6 = Boat.new([[6,2],[6,3]]),
     @boat_7 = Boat.new([[3,1],[4,1],[5,1]]),
     @boat_8 = Boat.new([[2,9],[3,9],[4,9]]),
     @boat_9 = Boat.new([[9,2],[9,3],[9,4],[9,5]])]
  end

  def play_game
    initial_message
    make_guesses
    if game_is_won
      win_message
    else
      lose_message
    end
  end

  def initial_message
    @output.puts "Welcome to Battleships! You have #{@guesses_left} guesses to sink #{@game_boat_list.count_boats_not_sunk} boats.\nI will tell you when you have sunk a boat and you won't lose a guess if you hit a boat. Good luck!"
  end

  def make_guesses
    while @guesses_left > 0 && !game_is_won
      @game_grid.display_board
      guesses_and_boats_left_message
      take_and_convert_user_input
      if @game_boat_list.any_boat_hit?(@target_grid_point)
        run_hit_mechanics
      else
        run_miss_mechanics
      end
    end
  end

  def game_is_won
    @game_boat_list.all_boats_sunk?
  end

  def guesses_and_boats_left_message
    @output.print "You have "
    if @guesses_left == 1 
      @output.print "1 guess"
    else
      @output.print "#{guesses_left} guesses"
      @output.print " left to sink"
    end
    if @game_boat_list.count_boats_not_sunk == 1 
      @output.print " 1 boat."
    else
      @output.print " #{@game_boat_list.count_boats_not_sunk} boats."
    end
  end

  def take_and_convert_user_input
    input = take_input_until_correct
    @target_grid_point = convert_input_to_grid_point(input)
  end

  def take_input_until_correct
    input = take_user_input
    until input_is_valid?(input)
      input = take_user_input
    end
    input
  end

  def take_user_input
    @output.puts "\nPlease pick the coordinates you wish to attack (in the format: letter-number)."
    @input.gets.chomp.to_s
  end

  def input_is_valid?(user_input)
    if input_is_not_in_correct_format?(user_input)
      @output.puts "\nOops, looks like you entered something silly!"
    elsif input_has_previously_been_entered?(user_input)
      @output.puts "\nOops, looks like you've already tried that one!"
    else true
    end
  end

  def input_is_not_in_correct_format?(user_input)
    user_input = user_input.chars
    return true unless user_input[0] =~ /[a-j]/i
    return true unless user_input[1] =~ /[1-9]/
    if user_input[2]
      return true unless user_input[1] =~ /1/
      return true unless user_input[2] =~ /0/
    end
    return true if user_input[3]
    false
  end

  def input_has_previously_been_entered?(user_input)
    grid_point = convert_input_to_grid_point(user_input)
    @game_grid.grid[grid_point[0]][grid_point[1]] != "║  ☺  ║"
  end

  def convert_input_to_grid_point(user_input)
    user_input = user_input.chars
    if user_input[2] == "0"
      user_input.pop
      user_input[1] = "10"
    end
    column = LETTERCOLLECTION.index(user_input[0].upcase) + 1 
    row = user_input[1].to_i
    [row, column]
  end

  def run_hit_mechanics
    hit_message
    @game_grid.record_hit(@target_grid_point)
    boat_hit = @game_boat_list.which_boat_hit?(@target_grid_point)
    boat_hit.record_hit(@target_grid_point)
    if boat_hit.sunk?
      boat_sunk_message
    end
  end

  def hit_message
    @output.puts "You hit one! You don't lose a guess."
  end

  def boat_sunk_message
    @output.puts "Yay! You sank a boat!"
  end

  def run_miss_mechanics
    miss_message
    @game_grid.record_miss(@target_grid_point)
    @guesses_left -= 1
  end

  def miss_message
    @output.puts "Ah... Looks like you missed. You lose a guess."
  end

  def win_message
    @output.puts "Yay! You won!"
  end

  def lose_message
    @output.puts "Oh dear. Looks like you lost!"
  end
end

@dev_game = BattleshipsGame.new
