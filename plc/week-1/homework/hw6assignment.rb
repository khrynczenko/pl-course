# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
               rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
               [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
               [[0, 0], [0, -1], [0, 1], [0, 2]]],
               rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
               rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
               rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
               rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
               rotations([[0, 0], [1, 0], [0, 1], [1, 1], [2, 1]]),
               rotations([[0, 0], [0, 1], [0, 2], [0, 3], [0, 4]]),
               rotations([[0, 0], [0, 1], [1, 1]]),
] 

  Cheat_Piece = [[[0, 0]]]

  # your enhancements here
  def self.next_piece (board, cheat = false)
    if cheat
      MyPiece.new(Cheat_Piece[0], board)
    else
      MyPiece.new(All_My_Pieces.sample, board)
    end
  end

end

class MyBoard < Board
  # your enhancements here
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    @make_next_piece_as_cheat = false
  end

  def next_piece
    if @make_next_piece_as_cheat
      @current_block = MyPiece.next_piece(self, @make_next_piece_as_cheat)
      @current_pos = nil
      @make_next_piece_as_cheat = false
    else
      @current_block = MyPiece.next_piece(self)
      @current_pos = nil
    end
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..@current_block.current_rotation.length - 1).each { |index|
      current = locations[index];
      grid_x = current[1] + displacement[1]
      grid_y = current[0] + displacement[0]
      @grid[grid_x][grid_y] = @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end

  def make_cheat_piece
    if !@cheat && @score >= 100
      @score -= 100
      @make_next_piece_as_cheat = true
    end
  end

end

class MyTetris < Tetris
  # your enhancements here
  
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_clockwise; @board.rotate_clockwise}) 
    @root.bind('c', proc {activate_cheat}) 
  end

  def activate_cheat
    @board.make_cheat_piece
    update_score
  end

end
