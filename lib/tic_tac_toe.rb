
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
  # ETC, an array for each win combination
]

def won?(board)
  WIN_COMBINATIONS.detect do |wincombo|
    win_index_1 = wincombo[0]
    win_index_2 = wincombo[1]
    win_index_3 = wincombo[2]

    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3

    (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
  end
end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  if !won?(board)
    if full?(board)
    return true
  else
    false
  end
else
  false
end
end

def over?(board)
  if won?(board)
    true
  elsif
    draw?(board)
    true
  elsif full?(board)
    true
  else
  false
end
end

def winner(board)
  won = won?(board)
  if won?(board)
    return board[won[1]]
  end
  nil
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(user_input)
  return user_input.to_i - 1
end

def move(board,index,player)
  return board[index] = "#{player}"
end

def valid_move?(board,index)
  if (index < 9 && index >= 0)
    if !position_taken?(board,index)
      return true
    else
      return false
    end
    return false
  end
  return false
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip.to_i
  index = input_to_index(input)
  while (index >= 9 || index < 0 || !valid_move?(board,index))
    puts "Please enter a move between 1 and 9 and make sure that it is valid"
    input = gets.strip.to_i
    index = input_to_index(input)
  end
    move(board,index,current_player(board))
    display_board(board)
end

def turn_count(board)
  turncounter = 0
  board.each do |play|
    if play == "X" || play == "O"
      turncounter+=1
    end
  end
  return turncounter
end

def current_player(board)
  if (turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def play(board)
  until (over?(board)) do
    turn(board)
  end

  if(won?(board))
    puts "Congratulations #{winner(board)}!"
    else
    puts "Cats Game!"
  end
end
