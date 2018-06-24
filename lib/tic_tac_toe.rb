# I originally wrote most of these methods in TIC TAC TOE TURN.  Some of those were then modified by LEARN in TIC TAC TOE PLAY LOOP. 
# I originally wrote turn_count(board) and current_player(board) in TIC TAC TOE CURRENT PLAYER. 
# I wrote the remainder and the array in TIC TAC TOE GAME STATUS.
# And here, in TIC TAC TOE.RB, I have modified some or all of the above. 

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  user_input.to_i - 1
end 


def move(board, index, current_player)
  board[index] = current_player
end


def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  turn_count = board.count("X") + board.count("O")
end


def current_player(board)
    if turn_count(board).even? 
      current_player = "X" 
    else current_player = "O"
    end 
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination 
    else 
      false
    end
  end 
  if !WIN_COMBINATIONS.include?(["X", "X", "X"]) &&  !WIN_COMBINATIONS.include?(["O", "O", "O"])
    false
  end
end


def full?(board)
  board.all? do |board_element| 
    board_element == "X" || board_element == "O"
  end
end

def draw?(board)
!won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    if (position_1 == "X" && position_2 == "X" && position_3 == "X")
      return "X"
      elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return "O"
    end 
    if !won?(board)
      return nil 
    end
  end 
end

 
    

# Define your play method below


def play(board)
  until !board.include?("   ") && !board.include?(" ")
    turn(board)
  end
end

