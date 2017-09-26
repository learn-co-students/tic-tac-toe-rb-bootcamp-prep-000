
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
  WIN_COMBINATIONS.detect do |combination|
    win_index_1 = combination[0]
    win_index_2 = combination[1]
    win_index_3 = combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    # puts position_1 + "," + position_2 + "," + position_3

    if ((position_1 == "X" && position_2 == "X" && position_3 == "X") ||
        position_1 == "O" && position_2 == "O" && position_3 == "O")
      true
    else
      false
    end
  end
end

def full?(board)
  #all_full = board.all? do |cell|
  #              cell == "X" || cell == "O"
  #            end
  board.all?{|cell| cell == "X" || cell == "O"}
end

def draw?(board)
  res_full = full?(board)
  res_won = won?(board)
  if res_full && !res_won
    true
  elsif !res_full && !res_won
    false
  elsif res_won
    false
  end
end

def over?(board)
  if draw?(board)
    true
  elsif won?(board) && full?(board)
    true
  elsif won?(board) && !full?(board)
    true
  else
    false
  end
end

def winner(board)
  if over?(board)
    winning_line = won?(board)
    cell = winning_line[0]
    char = board[cell]
    char
  else
    nil
  end
end

def turn_count(board)
  count = 0
  board.each do |cell|
    if cell == "X" || cell =="O"
      count += 1
    end
  end

  count
end

def current_player(board)
  curr = turn_count(board)%2
  if curr == 0
    "X"
  else
    "O"
  end
end

# Helper Methods
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
  index = input_to_index(input)
  curr_player = current_player(board)

  if valid_move?(board, index)
    move(board, index, curr_player)
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  count = 0
  while !over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
=begin
  while count < 9 do
    turn(board)
    count += 1
  end
=end
end
