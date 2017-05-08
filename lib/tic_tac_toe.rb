# WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

# Helper Methods

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.strip.to_i - 1
end

def position_taken?(board, index)
  !(board[index].strip.nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def move(board, index, character)
  board[index] = "#{character}"
  return board
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  index = input_to_index(gets)
  character = current_player(board)
  if valid_move?(board, index)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |cell|
    if cell != nil && cell == "X" || cell == "O"
       counter += 1
    end
  end
  return counter
end

def won?(board)

  !board.include?([" ", " ", " ", " ", " ", " ", " ", " ", " "])

  WIN_COMBINATIONS.each do |winning_combo|
    if board[winning_combo[0]] == board[winning_combo[1]] &&
       board[winning_combo[1]] == board[winning_combo[2]] &&
       position_taken?(board, winning_combo[0])
       return winning_combo
    end
  end
  false
end

def full?(board)
  board.none? {|element| element.to_s.strip == ""}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  end
end

def play(board)
  until over?(board) || turn_count(board) == 10
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts "Cats Game!"
  end
end
