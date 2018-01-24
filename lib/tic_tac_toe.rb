board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
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
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count += 1
    else
      count
    end
  end
  count
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    pos_1 = board[combo[0]]
    pos_2 = board[combo[1]]
    pos_3 = board[combo[2]]

    winning_array = [pos_1, pos_2, pos_3]

    if  (pos_1 == "X" && pos_2 == "X" && pos_3 == "X") || (pos_1 == "O" && pos_2 == "O" && pos_3 == "O")
        return combo
    end
  end
  return false
end



def full?(board)
  spaces = board.each_with_index.collect do |space, index|
    index
  end
  spaces.all? do |position|
    position_taken?(board, position)
  end
end

def draw?(board)
  full?(board) && won?(board) == false
end

def over?(board)
  if draw?(board)
    true
  elsif won?(board) != false && (full?(board) == true || full?(board) == false)
    true
  end
end

def winner(board)
  if won?(board) == false
    nil
  else won?(board).all? do |i|
      if board[i] == "X"
        return "X"
      elsif board[i] == "O"
        return "O"
      end
    end
  end
end

# Define your play method below
def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
