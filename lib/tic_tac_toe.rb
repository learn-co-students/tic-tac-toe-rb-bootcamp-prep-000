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

def display_board(board)
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  puts "-----------"
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  puts "-----------"
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

def input_to_index(input)
  index = input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, position)
  if board[position] == " " ||   board[position] == ""
    return false
  else board[position] == "X" ||   board[position] == "O"
    return true
  end
end

def valid_move?(board, index)
  !position_taken?(board, index) && index <= 8 && index >= 0
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) && current_player(board) == "X"
    move(board, index, a_value =  "X")
    display_board(board)
  elsif valid_move?(board, index) && current_player(board) == "O"
    move(board, index, a_value =  "O")
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |turns|
   if turns == "X" || turns == "O"
       counter += 1
   end
  end
  counter
end

def current_player(board)

  if turn_count(board).even?
    "X"
  else turn_count(board).odd?
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_combination|
  # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
  # grab each index from the win_combination that composes a win.
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]


  position_1 = board[win_index_1] # load the value of the board at win_index_1
  position_2 = board[win_index_2] # load the value of the board at win_index_2
  position_3 = board[win_index_3] # load the value of the board at win_index_3


  if position_1 == "X" && position_2 == "X" && position_3 == "X"
    return win_combination # return the win_combination indexes that won.
  elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
    return win_combination
  else
    false
  end
  end
end

def full?(board)
  !board.detect{|i| i == " "}
  end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else won?(board)
    false
  end
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?board
   combo = won?(board)
    return board[combo[0]]
  else
    return nil
end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations #{winner(board)}!"
  else draw?(board)
    puts "Cats Game!"
  end
end
