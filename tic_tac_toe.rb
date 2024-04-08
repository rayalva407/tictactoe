 class TicTacToe
    def initialize
      @board = Array.new(3) { Array.new(3, " ") }
      @player1 = Player.new("Player 1", "X")
      @player2 = Player.new("Player 2", "O")
      @current_player = @player1
    end

    def play
      loop do
        print_board
        puts "#{@current_player.name}, enter your move (row [0-2], column [0-2]):"
        row, col = gets.chomp.split.map(&:to_i)
        if @board[row][col] == " "
          @board[row][col] = @current_player.symbol
          if winner?
            print_board
            puts "#{@current_player.name} wins!"
            break
          end
          if draw?
            print_board
            puts "It's a draw!"
            break
          end
          switch_player
        else
          puts "Invalid move, try again."
        end
      end
    end

    def switch_player
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
  end

  def print_board
    @board.each { |row| puts row.map { |e| e }.join(" | ") }
  end

  def play
    loop do
      print_board
      puts "Player #{@current_player}, enter your move (row [0-2], column [0-2]):"
      row, col = gets.chomp.split.map(&:to_i)
      if @board[row][col] == " "
        @board[row][col] = @current_player
        if winner?
          print_board
          puts "Player #{@current_player} wins!"
          break
        end
        if draw?
          print_board
          puts "It's a draw!"
          break
        end
        switch_player
      else
        puts "Invalid move, try again."
      end
    end
  end

  def winner?
    winning_combinations = [
      [[0, 0], [0, 1], [0, 2]], # top row
      [[1, 0], [1, 1], [1, 2]], # middle row
      [[2, 0], [2, 1], [2, 2]], # bottom row
      [[0, 0], [1, 0], [2, 0]], # left column
      [[0, 1], [1, 1], [2, 1]], # middle column
      [[0, 2], [1, 2], [2, 2]], # right column
      [[0, 0], [1, 1], [2, 2]], # diagonal top-left to bottom-right
      [[0, 2], [1, 1], [2, 0]]  # diagonal top-right to bottom-left
    ]
    winning_combinations.any? do |positions|
      positions.all? { |row, col| @board[row][col] == @current_player }
    end
  end

  def draw?
    @board.all? { |row| row.none? { |e| e == " " } }
  end

  def switch_player
    @current_player = @current_player == "X" ? "O" : "X"
  end