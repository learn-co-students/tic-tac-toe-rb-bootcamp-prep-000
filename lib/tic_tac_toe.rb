v1 = [0,3,6]
v2 = [1,4,7]
v3 = [2,5,8]
h1 = [0,1,2]
h2 = [3,4,5]
h3 = [6,7,8]
d1 = [0,4,8]
d2 = [2,4,6]
WIN_COMBINATIONS = [v1, v2, v3, h1, h2, h3, d1, d2]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end
  
  def input_to_index(input)
    index = input.to_i - 1
  end
  
  def move(board,index,character = "X")
    board[index] = character
  end

  def position_taken?(board, index)
    if board[index] == " " || board[index] == "" || board[index] == nil
      false
    else
      true
    end
  end

  def valid_move?(board, index)
    index = index.to_i
    if index >= 0 && index < 9 && !position_taken?(board,index)
      true
    else
      false
    end
  end

#   def valid_move?(board, index)
#     index.between?(0,8) && !(position_taken?(board, index))
#   end

  def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    input = input_to_index(input)
    index = input
    if valid_move?(board, index)
      move(board, input, value = "X")
      display_board(board)
    else
      turn(board)
    end
  end 

  def turn_count(board)
    count = 0
    board.each do |value|
      if value == "X" || value == "O"
        count += 1
      end
    end
    count
  end
  
  def current_player(board)
    if turn_count(board) % 2 == 0
      "X"
    else
      "O"
    end
  end

def won?(board)
  x_combo = []
  y_combo = []
  board.each_with_index do |v, i|
    if v == "X"
      x_combo << i
    elsif v == "O"
      y_combo << i
    end
  end
   WIN_COMBINATIONS.each do |v|
      if (x_combo.include?(v[0]) && x_combo.include?(v[1]) && x_combo.include?(v[2])) || (y_combo.include?(v[0]) && y_combo.include?(v[1]) && y_combo.include?(v[2]))
        return v
      end
    end
  return false
end

def full?(board)
    board.all? do |i|
      if i == "X" || i == "O"
        true
      else
        false
      end
    end
  end
  
  def draw?(board)
    !won?(board) && full?(board)
  end
  
  def over?(board)
    if won?(board) || draw?(board) || full?(board)
      true
    else
      false
    end
  end
  
  def winner(board)
    combo = won?(board)
    if combo != false
      return board[combo[0]]
    else
      return nil
    end
  end
  
  def play(board)
    i = 0
    while i < 9 && over?(board) == false
      turn(board)
      i += 1
    end
  end
  

