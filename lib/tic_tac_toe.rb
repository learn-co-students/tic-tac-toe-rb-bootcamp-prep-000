WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

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
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  i = gets.strip
  index = input_to_index(i)
  m = valid_move?(board, index)
  if m == true
    move(board, index, current_player(board))
  else m == false
    until m == true
      puts "Sorry, that was an invalid move. Please enter 1-9:"
      display_board(board)
      i = gets.strip
      index = input_to_index(i)
      m = valid_move?(board, index)
      move(board, index, current_player(board))
    end
  end
end

def turn_count(board)
  count = 0
  board.each do |move|
    if move == "X" || move == "O"
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.find do |win_combo|
    board[win_combo[0]] == board[win_combo[1]] && board[win_combo[0]] == board[win_combo[2]] && position_taken?(board, win_combo[1])
  end
end



def full?(board)
  if board.include?(" ") || board.include?("")
    return false
else
    return true
  end
end

def draw?(board)
  if full?(board) == true && won?(board) == nil
    return true
  else
    return false
  end
end


def over?(board)
  draw?(board) == true ||  full?(board) == true
end



def winner(board)
  if won?(board) != nil
    winner = board[won?(board)[0]]
  end
end



# Define your play method below

def play(board)
  until over?(board) == true
    turn(board)
  end
  if draw?(board) == true
       puts "Cat's Game!"
  else won?(board) != nil
     puts "Congratulations #{winner(board)}!"
   end
end
