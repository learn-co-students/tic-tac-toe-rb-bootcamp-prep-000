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

def play(board)
  while !over?(board)
    turn(board)
  end

  if won?(board)
    token = won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end

end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def won?(board)
  status = false

  WIN_COMBINATIONS.each do | win_index |
    win_index.each do
      i = 0
      win_array = []
      while i < 3
        if board[win_index[i]] != nil || " "
          win_array.push(board[win_index[i]])
        else
          status = false
        end
      i += 1
      end
     if win_array[0] == "X" && win_array[1] == "X" && win_array[2] == "X"
       return win_index
     elsif win_array[0] == "O" && win_array[1] == "O" && win_array[2] == "O"
       return win_index
     else
       status = false
     end
    end
  end
  return status
end


def full?(board)
  board.all?{|token| token == "X" || token == "O"}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if won?(board)
    return true
  elsif draw?(board)
    return true
  else
    return false
  end
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  board[index]== "X" || board[index] == "O"
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn_count(board)
  board.count{|token| token == "X" || token == "O"}
end

def move(board, index, player)
  board[index] = player
end



def winner(board)

  if won?(board) != false
    token_array = won?(board)

    if board[token_array[0]] == "X"
      return "X"
    elsif board[token_array[0]] == "O"
      return "O"
    end
   return nil

  end

end
