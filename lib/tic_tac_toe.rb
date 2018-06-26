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

def move(array, index, character)
  array[index] = character
end

# code your #valid_move? method here
def valid_move?(board, index)
  if position_taken?(board, index) == false && (index >= 0 && index <= 8)
    true
  else
    false
  end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else 
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)
  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  counter = 1
  while counter < 10
    turn(board)
    counter += 1
  end
end

def turn_count(board)
  counter = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
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

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
    ]
    
def won?(board)
  WIN_COMBINATIONS.each do |win|
    if position_taken?(board, win[0]) == true && board[win[0]] ==  board[win[1]] && board[win[1]]== board[win[2]] && board[win[0]] == board[win[2]]
      return win
    end
  end
  return false
end

def full?(board)
  board.all? do |position| 
    position == "X" || position == "O"
  end
end

def draw?(board)
  if won?(board) == false
    return true
  elsif won?(board) == true
    return false
  end
end
  
def draw?(board)
  if won?(board) == false && full?(board) == true
    true
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  end
end

def winner(board)
  if won?(board)
    win_combo = won?(board)
    return board[win_combo[0]]
  end
end
