def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2], #top row
  [3,4,5], #middle row
  [6,7,8], #bottom row
  [0,3,6], #left column
  [1,4,7], #middle column
  [2,5,8], #right column
  [0,4,8], #topltr diagnal
  [2,4,6] #toprtl diagnal
]

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    (board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X") ||
    (board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O")
    end
  end

  def full?(board)
    board.all? do |index|
      index == "X" || index == "O"
    end
  end

  def draw?(board)
    if (!won?(board) && full?(board))
        return true
    else
      return false
      end
    end

  def over?(board)
    if (won?(board) || draw?(board) || full?(board))
      return true
    else
      return false
    end
  end

  def winner(board)
    if(won?(board))
      return board[won?(board)[0]]
    end
  end


def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
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

def turn_count(board)
  counter = 0
  board.each do |ele|
    if ele == "X" || ele == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board) != nil
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
