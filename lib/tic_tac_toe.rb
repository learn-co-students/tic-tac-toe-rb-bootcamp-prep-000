WIN_COMBINATIONS = [
    # Horizontal Rows
    [0,1,2],
    [3,4,5],
    [6,7,8],
    
    # Vertical Rows
    [0,3,6],
    [1,4,7],
    [2,5,8],
    
    # Diagonal Rows
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
  
def input_to_index(input)
  input.to_i - 1
end

def player_move(board, index, char)
  board[index] = char
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board, index)
  if index.between?(0,8)
    !position_taken?(board, index)
  end
end

def turn(board)
  char = current_player(board)
  puts "Choose an open space to place your #{char} (1-9)"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player_move(board, index, char)
    display_board(board)
  else
    puts "Invalid move, please choose again"
    turn(board)
  end
end

def current_player(board)
  count = turn_count(board)
  count.odd? ? "O" : "X"
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if !(space == " " || space == "" || space = NIL)
      counter += 1
    end
  end
  return counter
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    holder = []
    combination.each do |space|
      holder << board[space]
    end
    if holder[0] == holder[1] && holder[0] == holder[2] && holder[0] != " "
      return combination
      break
    end
  end
  FALSE
end


def full? (board)
  !board.include?(" ")
end

def draw? (board)
  if won?(board)
    return FALSE
  elsif full?(board)
      return TRUE
  else
      return FALSE
  end
end

def over? (board)
  won?(board) || draw?(board) || full?(board)
end

def winner (board)
  if won?(board).is_a?(Array)
    return board[won?(board)[0]]
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end