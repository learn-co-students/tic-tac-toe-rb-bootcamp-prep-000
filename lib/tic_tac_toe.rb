WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
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
  puts 'Please enter 1-9:'
  input = gets.strip
  input = input_to_index(input)

  if valid_move?(board, input) 
    move(board, input, current_player(board))
    display_board(board)
  else
    turn(board)
   end
end

def turn_count(board)
  counter = 0
  board.each do |board|
    if board == "X" || board == "O"
    counter+= 1 
    end
  end
  return counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

  def won?(board)
  WIN_COMBINATIONS.detect do |combos|
  (board[combos[0]] == board[combos[1]] && board[combos[1]] == board[combos[2]]) && (board[combos[0]]== 'X'|| board[combos[0]] == 'O')
    
end
end

def full?(board)
     board.all? do |letter|
       letter == 'X' || letter == 'O'
  end
end

def draw?(board)
    full?(board) && !won?(board) 
   
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  if !won?(board)
    return nil
    else
  return board[won?(board)[0]]
end
end

def play(board)

  while !over?(board) do
    turn(board)
  end
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cat's Game!"
    end
end  