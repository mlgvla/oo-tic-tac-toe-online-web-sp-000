class TicTacToe
  WIN_COMBINATIONS = [[0, 1, 2],
                      [3, 4, 5],
                      [6, 7, 8],
                      [0, 3, 6],
                      [1, 4, 7],
                      [2, 5, 8],
                      [0, 4, 8],
                      [6, 4, 2]]

  def initialize(board = nil)
    @board = board || @board = Array.new(9, " ")
  end

  def display_board
    puts(" #{@board[0]} | #{@board[1]} | #{@board[2]} ")
    puts("-----------")
    puts(" #{@board[3]} | #{@board[4]} | #{@board[5]} ")
    puts("-----------")
    puts(" #{@board[6]} | #{@board[7]} | #{@board[8]} ")
  end

  def input_to_index(number)
    number.to_i - 1
  end

  def move(index, value)
    @board[index] = value
  end

  def position_taken?(index)
    if(@board[index] == " " || @board[index] == "" || @board[index] == nil)
      return false
    end
    if (@board[index] == "X" || @board[index] == "O")
      return true
    end
  end

  def valid_move?(index)
    if index.between?(0,8)
      index_bool = true
    else
      index_bool = false
    end

    position_bool = position_taken?(index)

    if index_bool && !position_bool
      return true
    end
  end

  def turn_count
    @board.count{|token| token == "X" || token == "O"}
  end

  def current_player
    return  turn_count.even?? "X" : "O"
  end

  def turn
    value = current_player

    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)

    if valid_move?(index)
      move(index, value)
      display_board
    else
      turn
    end
  end

  def won?

    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = @board[win_index_1]
      position_2 = @board[win_index_2]
      position_3 = @board[win_index_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
        (position_1 == "O" && position_2 == "O" && position_3 == "O")
        return win_combination
      end
    end
    false
  end

  def full?
    am_I_full = @board.all? do |position|
      !(position.nil? || position == " ")
    end
    am_I_full
  end

  def draw?
    if (full? && !won?)
      return true
    elseif (!won? && !full?)
      return false
    elseif(won?)
      return false
    end
  end

  def over?
    #true if won, draw, or full
    if(won? || draw? || full? )
      return true
    end
    return false
  end

  def winner
    #check 1st element of win_combination array
    #if "X" return "X" otherwise return "O"
    win_combination = won?

    if !win_combination
      return nil
    end
    #return nil unless win_combination
    if @board[win_combination[0]] == "X"
      return "X"
    end
    if @board[win_combination[0]] == "O"
      return "O"
    end
  end

  def play
    until over?
        turn
    end

    if game_result = winner
      puts "Congratulations #{game_result}!"
    else
      puts "Cat's Game!"
    end
  end

end
