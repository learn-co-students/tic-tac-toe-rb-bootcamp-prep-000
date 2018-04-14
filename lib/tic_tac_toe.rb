# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6],[0,3,6],[1,4,7],[2,5,8]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i-1
  return index
end

def move(board, index, player_token)
  board[index] = player_token
  return board
end

def valid_move?(board, index)
  if index.between?(0,8) &! position_taken(board, index)
    return true
  end
end

def position_taken(board, index)
  if board[index] == "" || board[index] ==" " || board[index] == nil
    return false
  elsif board[index] =="X" || board[index] == "O"
    return true
  end
end

def turn(board)
  puts "Please choose a free cell between 1-9"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board,index,current_player(board))
    display_board(board)
  else
    puts "#{input} is invalid or already taken, please try again"
    turn(board)
  end
end

def current_player(board)
  if turn_count(board) %2 ==0
    return "X"
  else
    return "O"
  end
end

def turn_count(board)
  count = 0
  board.each do |i|
    if i == "O" || i == "X"
      count +=1
    end
  end
  return count
end

def x_and_o(board)
  x_board = []
  o_board = []
  i = 0
  while i < board.length
    if board[i] == "X"
      x_board.push(i)
    elsif board[i] == "O"
      o_board.push(i)
    end
    i+=1
  end
  return [x_board, o_board]
end

def won?(board)
  x_and_o_arr = x_and_o(board)
  res_o=[]
  res_x =[]
  WIN_COMBINATIONS.each do |possibility|
      if (x_and_o_arr[0].include?(possibility[0]) && x_and_o_arr[0].include?(possibility[1]) && x_and_o_arr[0].include?(possibility[2]))
        res_x.push(possibility)
      elsif (x_and_o_arr[1].include?(possibility[0]) && x_and_o_arr[1].include?(possibility[1]) && x_and_o_arr[1].include?(possibility[2]))
        res_o.push(possibility)
      end
    end
    puts "#{res_o}"
    puts "#{res_x}"
    if res_o.length == 0 && res_x.length == 0
      return false
    elsif res_o.length > res_x.length
      return true, res_o[0]
    else
      return true, res_x[0]
    end
end

def full?(board)
  x_and_o_arr = x_and_o(board)
  if x_and_o_arr[0].length + x_and_o_arr[1].length < 9
    return false
  else
    return true
  end
end

def draw?(board)
  if full?(board) &! won?(board)
    return true
  elsif won?(board)
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
  x_and_o_arr = x_and_o(board)
  res_o=[]
  res_x =[]
  WIN_COMBINATIONS.each do |possibility|
     if (x_and_o_arr[0].include?(possibility[0]) && x_and_o_arr[0].include?(possibility[1]) && x_and_o_arr[0].include?(possibility[2]))
        res_x.push(possibility)
      elsif (x_and_o_arr[1].include?(possibility[0]) && x_and_o_arr[1].include?(possibility[1]) && x_and_o_arr[1].include?(possibility[2]))
        res_o.push(possibility)
      end
    end
    if res_o.length > res_x.length
      return "O"
    elsif res_o.length == res_x.length
      return nil
    else
      return "X"
    end
end

def play(board)
  while !over?(board) do
    turn(board)
  end
  if won?(board)
    win = winner(board)
    puts "Congratulations #{win}!"
  else
    puts "Cat\'s Game!"
  end
end
