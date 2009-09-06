require 'user_interface'

class MineSweeper

  MINE = '*'
  EMPTY = '.'

  def initialize(size, mines)
    @size = {:width => size[0], :height => size[1]}
    @mines = mines
    create_empty_board
    add_mines_to_board
  end

  def draw_board
    @board.inject("") do |val, row|
      val << "#{row}\n"
    end
  end

  def complete
    (0..@size[:height]-1).each do |row|
      (0..@size[:width]-1).each do |col|
        next if @board[row][col] == MINE

        mines_around = 0
        relative_points([col, row]).each do |relative|
          mines_around += 1 if @board[relative[1]][relative[0]] == MINE
        end

        @board[row][col] = mines_around if mines_around > 0
      end
    end
  end

  def relative_points point
    relative_postions = [
            [-1, -1], [0, -1], [+1, -1],
            [-1, 0],           [+1, 0],
            [-1, +1], [0, +1], [+1, +1]
    ]

    locations = []
    relative_postions.each do |relative_point|
      relative = [point[0] + relative_point[0], point[1] + relative_point[1]]
      locations << relative if relative[0] < @size[:width] and relative[0] >= 0 and relative[1] < @size[:height] and relative[1] >= 0
    end

    locations
  end

  private

  def create_empty_board
    empty_width = Array.new(@size[:width]).fill(EMPTY)
    @board = Array.new(@size[:height]).fill{empty_width.dup}
  end

  def add_mines_to_board
    @mines.each do |mine|
      @board[mine[1]][mine[0]] = MINE
    end
  end

end

