
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
  puts "Player #{current_player(board)} please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  current_player = current_player(board)
  if valid_move?(board, index)
    move(board, index, current_player)
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    xCounter = 0
    oCounter = 0
    combination.each do |index|
      if board[index] == "X"
        xCounter +=1
      elsif board[index] == "O"
        oCounter +=1
      end
      if (xCounter == 3) || (oCounter == 3)
        return combination
      end
    end
  end
  false
end

def full?(board)
  board.none?{|index| index == " " || index == nil}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  index = won?(board)
  if !won?(board)
    nil
  elsif board[index[0]] == 'X' && board[index[1]] == 'X' && board[index[2]] == 'X'
    'X'
  else
    'O'
  end
end

def current_player(board)
  if turn_count(board) % 2 == 0
    'X'
  else
    'O'
  end
end

def turn_count(board)
  counter = 0
  board.each do |pos|
    if (pos == 'X') || (pos == 'O')
      counter += 1
    end
  end
  counter
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
  puts  "Congratulations #{winner(board)}!"
  else
  puts  "Cat's Game!"
  end
end
