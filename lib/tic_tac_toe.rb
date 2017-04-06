board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

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
  index = user_input.to_i - 1
end

def move(board, index, char)
  #char = current_player(board)
  board[index] = char
end

def position_taken?(board, index)
  !(board[index] == " " || board[index] == "" || board[index] == nil)
end

def valid_move?(board, index)
  index.between?(0, 8) && position_taken?(board, index) == false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip

  index = input_to_index(input)

  if valid_move?(board, index)
    char = current_player(board)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each {|space| count += 1 if space == "X" || space == "O"}
  return count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.find {|w| w if board[w[0]] == board[w[1]] && board[w[1]] == board[w[2]] && board[w[0]] != " "}
end

def full?(board)
  board.all? {|i| i != " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    won?(board).find do |i|
      if board[i] == "X"
        return "X"
      elsif board[i] == "O"
        return "O"
      end
    end
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
