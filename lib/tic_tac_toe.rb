WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Vertical left
  [1,4,7],  # Vertical middle
  [2,5,8],  # Vertical right
  [0,4,8],  # Diagonal
  [2,4,6]   # Diagonal
]

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp
  index = input_to_index(input)
  value = current_player(board)
  if valid_move?(board, index)
    move(board, index, value)
    display_board(board)
  else
    puts "invalid"
    turn(board)
  end
end

def input_to_index(input)
  input.to_i - 1
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    true
  else
    false
  end
end

def move(board, index, value)
  board[index] = value
end

def turn_count(board)
  counter = 0
  board.each { |spot| counter += 1 if spot == "X" || spot == "O" }
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  if board.none?{|i| i == "O" || i == "X" }
    #empty board
    false
  elsif
    WIN_COMBINATIONS.each do |win_combination|
      position_1 = board[win_combination[0]]
      position_2 = board[win_combination[1]]
      position_3 = board[win_combination[2]]
        if ( (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O") )
          return [win_combination[0], win_combination[1], win_combination[2]]
        end
    end
  elsif full?(board)
    false
  end
end


def full?(board)
  board.all?{|i| i == "X" || i == "O" } ? true : false
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  else 
    false
  end
end

def over?(board)
  true if won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    win_combination = won?(board)
    return board[win_combination[1]]
  else
    nil
  end
end
