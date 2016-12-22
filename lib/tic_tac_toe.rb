#Variables & constants
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [0,3,6]
]

def play(board)
  until over?(board)
    turn(board)
  end
  if(won?(board))
    game_winner = winner(board);
    puts "Congratulations " + game_winner+"!"
  elsif(draw?(board))
    puts "Cats Game!"
  end
end

# Helper Methods
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

def position_taken?(board, location)
  if board[location] == " "
    false
  else
    true
  end
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  wins = []
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]


    if position_1 === "X" && position_2 === "X" && position_3 === "X"
      wins << [win_index_1,win_index_2,win_index_3]
    end

    if position_1 === "O" && position_2 === "O" && position_3 === "O"
      wins << [win_index_1,win_index_2,win_index_3]
    end
  end

  if wins.length == 0
    return false
  else
    return wins[0]
  end
end

def full?(board)
  board.all? do |pos|
    pos == 'X' || pos =='O'
  end
end

def draw?(board)
  game_full = full?(board)
  game_won = won?(board)
  if(game_full == true && game_won == false)
   return true
 end
 return false
end

def over?(board)
  if(won?(board) || draw?(board) || full?(board))
    return true
  end
   return false
end

def winner(board)
  if(won?(board))
    index = won?(board)[0]
    winner = board[index][0]
    return winner
  end
end
