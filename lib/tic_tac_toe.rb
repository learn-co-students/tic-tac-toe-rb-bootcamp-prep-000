def turn_count(board)
  turns = 0
  board.each do |value|
    if value == "X" || value ==  "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turns = turn_count(board) + 1
  if turns % 2 == 0
    "O"
  else
    "X"
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
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  if board.all?{|v| v == " "}
    return false
  end
  WIN_COMBINATIONS.each do | winning_combo_indicies |
    winning_index_one = winning_combo_indicies[0]
    winning_index_two = winning_combo_indicies[1]
    winning_index_three = winning_combo_indicies[2]
    if board[winning_index_three] == "" || board[winning_index_three] == " " || board[winning_index_three] == nil
      false
    elsif board[winning_index_one] == board[winning_index_two] && board[winning_index_two] == board[winning_index_three]
      return winning_combo_indicies
    end
  end
  false
end

def full?(board)
  !(board.any?{|i| i == " "})
end

def draw?(board)
  full?(board) && !(won?(board))
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  winningCombo = won?(board)
  if winningCombo
    winner = board[winningCombo[0]]
  end
end


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def play(board)
  while !(over?(board))
    turn(board)
  end
  if(won?(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
