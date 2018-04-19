class Grid

  attr_accessor :grid

  def initialize
    @grid = ["  01","  02","  03","  04","  05","<br>",
             "  06","  07","  08","  09","  10","<br>",
             "  11","  12","  13","  14","  15","<br>",
             "  16","  17","  18","  19","  20","<br>",
             "  21","  22","  23","  24","  25"]
  end

  def record_hit(grid_point)
    @grid[grid_point] = "⚓"
  end

  def record_miss(grid_point)
    @grid[grid_point] = "☠ "
  end
end
