WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]         ]
ROW_CONTENTS = []


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(n)
  n.to_i - 1
end

def move(board, index, player)
  if valid_move?(board, index)
    board[index] = player
  else
    turn(board)
  end
end

def position_taken?(board, position)
  if board[position] == " " || board[position] == "" || board[position] == nil
    false
  elsif board[position] == "X" || board[position] == "O"
    true
  end
end

def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
      true
    else
      false
  end
end

def turn(board)
  puts "Please enter 1-9:" 
  input = gets.strip
  index = input_to_index(input)
  player= current_player(board)
  move(board, index, player)
  display_board(board)
end

def move(board, index, player)
  if valid_move?(board, index)
    board[index] = player
  else
    turn(board)
  end
end

def turn_count(board)
  turns_played = 0
  board.each do |space_content|
    if space_content == "X" || space_content == "O"
      turns_played += 1
    end
  end
  turns_played
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    "X"
  else
    "O"
  end
end
def won?(board) 
  WIN_COMBINATIONS.each do |combination|
    ROW_CONTENTS.clear
      combination.each do |index|
        if position_taken?(board, index)
          ROW_CONTENTS << board[index]
        end
        if (ROW_CONTENTS.length == 3 && ROW_CONTENTS[0] == ROW_CONTENTS[1] && ROW_CONTENTS[1] == ROW_CONTENTS[2])
          return combination
        end      
      end
    end
  return false
end

def full?(board)
  !board.include?(" ") 
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  while (!over?(board)) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

