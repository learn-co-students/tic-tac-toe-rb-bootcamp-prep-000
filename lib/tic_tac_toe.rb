
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2], #top row
  [3, 4, 5],  #middle row
  [6, 7, 8], #bottom row
  [0, 3, 6],  #left column
  [1, 4, 7],  #middle column
  [2, 5, 8],  #right column
  [0, 4, 8], #top-L to bottom-R diagonal
  [2, 4, 6],  #top-R to bottom-L diagonal
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts separate = "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts separate
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  user_input.to_i - 1
end


def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board)) # needed to change 'player' parameter to current_player method!
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == 'X' || position == 'O'
      counter += 1
    end
  end
  return counter
end

 def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def won?(board)
  #any returns true if block EVER returns true for any element passed thru it
  WIN_COMBINATIONS.any? do |win_combo|
    #here checks if any possible combos will return true
    if board[win_combo[0]] == board[win_combo[1]] && board[win_combo[1]] == board[win_combo[2]] && position_taken?(board, win_combo[0])
      return win_combo
    end
  end
end


def full?(board)
  !board.include?(" ")
end


def draw?(board)
  full?(board) && !won?(board)
end


def over?(board)
  won?(board) || draw?(board)
end


def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    draw?(board)
    turn(board)
  end

  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
