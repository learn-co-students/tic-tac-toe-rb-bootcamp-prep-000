WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]


def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    position_1 = win_combo[0]
    position_2 = win_combo[1]
    position_3 = win_combo[2]
    
    if (board[position_1] == "X" && board[position_2] == "X" && board[position_3] == "X") || (board[position_1] =="O" && board[position_2] == "O" && board[position_3] == "O")
    return win_combo
   end
  end
  return false 
end


def full?(board)
  board.none? {|i| i == " " || i == ""}
end


def draw?(board)
  if (full?(board) == true && won?(board) == false) 
    return true
  end
end


def over?(board)
  if (won?(board) != false || full?(board) == true || draw?(board) == true)
    return true
  end
end


def winner(board)
  if (won?(board) != false)
    won?(board).each do|winner|
    if (board[winner] == "O")
      return "O"
    end
    return "X"
  end
 end
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def turn_count(board)
  counter = 0
  board.each do|turns|
  if turns == "X" || turns == "O" 
  counter += 1
   end
  end
  return counter
 end
 
 
 def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
  end
  
  
  def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def move(board, index, player_token)
  board[index] = player_token
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player_token = current_player(board)
  if valid_move?(board, index)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end


def input_to_index(user_input)
  user_input.to_i - 1
end

def play(board)
 until over?(board)
   turn(board)
  end
   if won?(board)
     puts "Congratulations #{winner(board)}!"
   end
     if draw?(board)
       puts "Cat's Game!"
   end
  end
 
