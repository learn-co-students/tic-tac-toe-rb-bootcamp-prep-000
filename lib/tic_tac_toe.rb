
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
  line = "-----------"
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts line
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts line
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#positions constant
POSITIONS = [0, 1, 2, 3, 4, 5, 6, 7, 8]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if position_taken?(board, combination[0]) && board[combination[0]] == board[combination[1]] && board[combination[1]] == board[combination[2]]
      return combination
    end
  end
  return false
end

def full?(board)
  !POSITIONS.find{|i| !position_taken?(board, i)}
end

def draw?(board)
  #assign won? and full? to variables to ensure spec works
  board_is_full = full?(board)
  board_is_won = won?(board)
  return board_is_full && !board_is_won
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if !won?(board)
    return nil
  else
    return board[won?(board)[0]]
  end
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if !(position == "" || position == nil || position == " ")
      counter +=1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def valid_move?(board, index)
  #check to see if position is taken
  if !index.between?(0,8)
    false
  else
    !position_taken?(board,index)
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  input_index = input_to_index(user_input)
  if valid_move?(board, input_index)
    move(board, input_index, current_player(board))
    display_board(board)
  else
    puts "Sorry, try again."
    turn(board)
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
