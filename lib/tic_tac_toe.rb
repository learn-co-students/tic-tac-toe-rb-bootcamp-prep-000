
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

def move(board, index, current_player )
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
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below


def turn_count(board)
count = 0
  board.each do |spot|
    if spot == "X" || spot == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn = turn_count(board)
    if turn % 2 == 0
      return "X"
    else
      return "O"
    end
end

def won?(board)
  WIN_COMBINATIONS.find do |sub|
    board[sub[0]] == board[sub[1]] && board[sub[1]] == board[sub[2]] && position_taken?(board,sub[0])
  end
end

def full?(board)
   !board.any? { |x| x == " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if !won?(board) && !full?(board)
    false
  else
    true
  end
end

def winner(board)
  if winner = won?(board)
    board[winner.first]
  end
end
def play(board)
  puts "You ready for some TIC TAC TOE??"
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "You won #{winner(board)}!"

  elsif draw?(board)
    puts "Guess what? You drawed!"
  end
end
