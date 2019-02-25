WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6],
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
  
  
  def move(board, index, character)
  board[index] = character
end

  def position_taken?(board, index)
 !(board[index].nil? || board[index] == " ")
  end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn_count(board)
  turn = 0
  board.each do |ele| 
    if ele == "X" || ele == "O"
    turn += 1
    end
  end
  return turn
end


def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def turn(board)
  puts "Please enter 1-9:"
  num = gets.chomp 
  index = input_to_index(num)
  if valid_move?(board, index) 
    player_token = current_player(board)
    move(board, index, player_token)
    display_board(board)
  else 
    turn(board)
  end
end




    def won?(board)
    
  WIN_COMBINATIONS.each do |combo|
    index_0 = combo[0]
    index_1 = combo[1]
    index_2 = combo[2]

    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return combo
    end
  end
  return false
end

def full?(board)
  
  board.all? {|combo| combo == "X" || combo == "O"}

end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end

def winner(board)
  index = []
  index = won?(board)
  if won?(board) == false
    return nil
  else
    if board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  until over?(board) == true
    turn(board)
end

if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
