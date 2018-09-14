WIN_COMBINATIONS = [
  [0, 1, 2], #top_row_win
  [3, 4, 5], #mid_row_win
  [6, 7, 8], #bot_row_win
  [0, 3, 6], #lef_col_win
  [1, 4, 7], #mid_col_win
  [2, 5, 8], #rig_col_win
  [0, 4, 8], #ri_diag_win
  [6, 4, 2]  #le_diag_win
  ]
  
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(input)
  input.to_i - 1
end
  
  
def player_move(board, index, token)
  board[index] = token
  return board
end 


def position_taken?(board, index)
  ! (board[index] == "" || board[index] == " " || board[index] == nil)
end  


def valid_move?(board, index)
  (index.between?(0,8) && !(position_taken?(board, index))) ? true : false
end


def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count += 1 
    end
  end
  return count
end


def current_player(board)
  turn_count(board).even? ? "X" : "O"
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  token = current_player(board)
  index = input_to_index(input)
  if valid_move?(board, index)
    player_move(board, index, token)
    display_board(board)
  else
    turn(board)
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
    if (position_1 == position_2) && (position_2 == position_3) && (position_3 == position_1)
        if position_1 == "X" || position_1 == "O"
          return win_combination
        end
      end
    end
  return false
end


def full?(board)
  board.all?{|i| i == "X" || i == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end


def over?(board)
  !! won?(board) || draw?(board) || full?(board) 
end


def winner(board)
  token = []
  winning_combo = won?(board)
  if winning_combo
    winning_combo.each do |i| 
      token.push(board[i])
      end
    return token.detect{|i| i == "X" || i == "O"}
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
