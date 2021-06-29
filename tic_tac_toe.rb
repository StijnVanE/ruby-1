class TicTacToe
  attr_accessor :board, :players, :player

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [6, 4, 2],
  [0, 4, 8]
]

  def display_board
    puts ""
    puts "#{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "---------"
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts "---------"
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}"
    puts ""
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(position, token='X')
    @board[position] = token
  end

  def position_taken?(input)
    @board[input] == "X" || @board[input] == "i"
  end

  def valid_move?(input)
    input.between?(0, 8) && !position_taken?(input)
  end


  def turn
    if @players == "1"
      if turn_count() % 2 == 1
        spot = rand(9)
        spot = input_to_index(spot)
        until valid_move?(spot)
          spot = rand(9)
          spot = input_to_index(spot)
        end
      else
        puts "kies een plek tussen 1-9"
        spot = gets.strip
        spot = input_to_index(spot)
      end
    else
      puts "kies een plek tussen 1-9"
      spot = gets.strip
      spot = input_to_index(spot)
    end
    if valid_move?(spot)
      move(spot, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    taken = 0
    @board.each do |i|
      if i == "X" || i == "i"
        taken += 1
      end
    end
    return taken
  end

  def current_player
    @player = nil
    if turn_count() % 2 == 0
      @player = 'X'
    else
      @player = 'i'
    end
    return @player
  end


  def won?
    WIN_COMBINATIONS.detect do |combo|
      @board[combo[0]] == @board[combo[1]] &&
      @board[combo[1]] == @board[combo[2]] &&
      position_taken?(combo[0])
    end
  end

  def full?
    turn_count == 9
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || full? || draw?
  end

  def winner
    won = ""
    if winner = won?
      won = @board[winner.first]
    end
  end

  def play
    puts "tegen computer of 2 spelers?(antwoord met 1 of 2)"
    @players = gets.strip
    until over?
      turn
    end

    if won?
      winner = winner()
      puts "#{winner} heeft gewonnen!"
    elsif draw?
      puts "gelijk!"
    end
    again?
  end
  def again?
    puts "wil je nog een keer spelen?(ja of nee)"
    again = gets.strip
    if again == "ja"
      initialize
      play
    elsif again == "nee"
      puts "oke tot de volgende keer"
    else
      puts "je hebt niet geantwoord met ja of nee"
      again?
    end
  end
end

game = TicTacToe.new
game.play
