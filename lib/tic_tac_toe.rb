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

# show the board
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Convert input to index
def input_to_index(input)
  input.to_i - 1
end

# put player symbol in board array
def move(board,index,current_player)
  board[index] = current_player
end

# T/F -- is there a symbol in board[index]
def position_taken?(board,index)
  !(board[index].nil? || board[index] == " " || board[index] == "")
end

# T/F -- is index valid?
def valid_move?(board,index)
  index.between?(0,8) && !position_taken?(board,index)
end

# Ask for input, 1..9 -- check validity and move then show board -- otherwise start over
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board,index,current_player(board))
  else
    puts "Hey, pay attention!"
    turn(board)
  end
  display_board(board)
end

# count turns per symbol presence in array
def turn_count(board)
  play_count = 0
  board.each do |play|
    if play == "X" || play == "O"
      play_count += 1
    end
  end
  play_count
end

# ternary -- is turn count even?, includes 0 -- truthy for X, or falsy -- same condition for O
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# Array/F -- return winning array or false
def won?(board)
  WIN_COMBINATIONS.find do |win_combo|
    # win index, calm down.
    windex_1 = win_combo[0]
    windex_2 = win_combo[1]
    windex_3 = win_combo[2]
    # setup position placeholder to compare arrays
    position_1 = board[windex_1]
    position_2 = board[windex_2]
    position_3 = board[windex_3]
    # check positions for all "X" or all "O"
    if ((position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O"))
      return win_combo
    end
  end
end

# T/F -- board array full
def full?(board)
  board.all?{|symbol| symbol == "X" || symbol == "O"} ? true : false
end

# T/F -- no win and full board
def scratch?(board)
  !won?(board) && full?(board)
end

# T/F -- any end state reached?
def over?(board)
  won?(board) || scratch?(board) || full?(board)
end

# return player symbol
def winner(board)
    won?(board) ? board[won?(board)[0]] : nil
end

# turn until over -- notification of end result
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif scratch?(board)
    puts "Cats Game!"
  end
end
