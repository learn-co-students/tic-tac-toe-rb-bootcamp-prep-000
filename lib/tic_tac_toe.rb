

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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if turn_count(board).even?
    player = "X"
  else
    player = "O"
  end
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |item|
    if item == "X" || item == "O"
      count += 1
    end
  end
  return count
end


def current_player(board)
  if turn_count(board).even?
    "X"
  else
    "O"
  end
end



def won?(board)

  WIN_COMBINATIONS.detect do |win_combo|

    board[win_combo[0]] == board[win_combo[1]] && \
    board[win_combo[1]] == board[win_combo[2]] && \
    position_taken?(board, win_combo[0])

  end

end


def full?(board)
  board.all? do |item|
    item == "X" || item == "O"
  end
end

def draw?(board)
  if full?(board)
    if !won?(board)
      true
    end
  end
end


def over?(board)
  if draw?(board) || full?(board) || won?(board)
    true
  end
end

def winner(board)
  if won?(board)
    winning_space = won?(board)
    board[winning_space[0]]
  end
end


def play(board)
  if !over?(board)
    turn(board)
    play(board)
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end
