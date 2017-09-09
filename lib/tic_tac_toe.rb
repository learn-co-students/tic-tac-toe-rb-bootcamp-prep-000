WIN_COMBINATIONS = [
  [0,1,2], # 1 Top row
  [3,4,5], # 2 Middle row
  [6,7,8], # 3 Bottom row
  [0,3,6], # 4 First column
  [1,4,7], # 5 Second column
  [2,5,8], # 6 Third column
  [0,4,8], # 7 Right slope diagonal
  [2,4,6]  # 8 Left slop diagonal
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

def move(board, index, character)
  board[index] = character
end

def position_taken? (board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else true
  end
end

def valid_move? (board, index)
  if position_taken?(board,index) == false && index.between?(0, 8) == true
    true
  else false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index) == true
    character = current_player(board)
    move(board, index, character)
    display_board(board)
  else
    puts "Invalid move"
    display_board(board)
    turn(board)
  end
end

def turn_count(board)
  turn = 0

  board.each do |space|
    if space == "X" || space == "O"
      turn += 1
    end
  end

  puts "It is turn #{turn}."
  turn

end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def won?(board)
  win_elements=[]
  board_elements = []
  WIN_COMBINATIONS.each do |win_combination|
    board_elements = []
    win_elements = []
    win_combination.each do |index|
      board_elements << board[index]
      win_elements << index
    end
    if (board_elements.all?{|c| c == "X"} ==  true) || (board_elements.all?{|c| c == "O"} ==  true)
      #win_elements
      break
    else
      win_elements = false
    end
  end

  return win_elements
 end

 def full?(board)
   board.all? do |index|
     index == "X" || index == "O"
   end
 end

def draw?(board)
  if (full?(board) == true) && (won?(board) == false)
    return true
  else
    return false
  end
end

def over?(board)
  if (draw?(board) == true) || (won?(board) != false)
    return true
  else
    return false
  end
end

def winner(board)
  win_array = []
  board_win_array = []
  if won?(board) != false
    win_array = won?(board)
    win_array.each do |index|
      board_win_array << board[index]
    end
    if (board_win_array.all?{|c| c == "X"} == true)
      return "X"
    elsif (board_win_array.all?{|c| c == "O"} == true)
      return "O"
    else
      nil
    end
  end
end

def play(board)
  if over?(board) == false
    turn_count(board)
    turn(board)
    play(board)
  elsif (over?(board) == true)
    if (draw?(board) == false)
      puts "Congratulations #{winner(board)}!"
    elsif (draw?(board) == true)
      puts "Cat's Game!"
    end
  end
end
