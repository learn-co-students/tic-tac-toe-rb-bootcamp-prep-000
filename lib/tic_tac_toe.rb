WIN_COMBINATIONS = [
  [0, 1, 2], 
  [3, 4, 5], 
  [6, 7, 8], 
  [0, 3, 6], 
  [1, 4, 7], 
  [2, 5, 8], 
  [0, 4, 8], 
  [2, 4, 6]
]

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

def move(array, index, value)
  array[index] = value
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) && !position_taken?(board, index)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, value = current_player(board))
  else
    turn(board)
  end
  display_board(board)  
end

def turn_count(board)
  turn = 0
  board.each do |count|
    if count == "X" || count == "O"
      turn += 1
    end
  end
  turn
end

def current_player(board)
  turn = 0
  board.each do |count|
    if count == "X" || count == "O"
      turn += 1
    end
  end
  turn.even? ? "X" : "O"
end

def won?(board)
  winning_combo = []
  
  WIN_COMBINATIONS.each do |win_combos|
    counterX = 0
    counterO = 0
    
    win_combos.each do |win_index|
      if board[win_index] == "X"
        counterX += 1 
      elsif board[win_index] == "O"
        counterO += 1
      end
    end
    
    if counterX == 3 || counterO == 3
      winning_combo = [
        win_combos[0], 
        win_combos[1], 
        win_combos[2]
      ]
    end     
  end
  
  if winning_combo.length > 0
    winning_combo
  else
    false
  end
end

def full?(board)
  board.all? {|index| index == "X" || index == "O"}
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else 
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    win_combo = won?(board)
    if board[win_combo[0]] == "X"
      return "X"
    elsif board[win_combo[0]] == "O"
      return "O"
    end
  else
    return nil
  end
end

def play(board)
  until over?(board)
    current_player(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
