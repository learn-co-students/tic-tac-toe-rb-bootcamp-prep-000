
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
puts " #{board[0]} | #{board[1]} | #{board[2]} \n-----------\n #{board[3]} | #{board[4]} | #{board[5]} \n-----------\n #{board[6]} | #{board[7]} | #{board[8]} \n"
end

def input_to_index(x)
 x.to_i - 1
end

def move(board, index, character)
  board[index] = character
  return board
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if position_taken?(board,index) == false && index.between?(0, 8)
    return true
  else
    puts "This is not a valid move!"
    return false
  end
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.chomp.to_i
  index = input_to_index(input)
  if valid_move?(board,index)
    character = current_player(board)
    move(board, index, character)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |square|
  if square == "X" || square == "O"
    count += 1
  end
end
  return count
end

def current_player(board)
   turn_count(board) % 2 == 0 ?  "X":  "O"
end


def won?(board)
    WIN_COMBINATIONS.each do |win_combination|
      win_index_1 = win_combination[0]
      win_index_2 = win_combination[1]
      win_index_3 = win_combination[2]

      position_1 = board[win_index_1]
      position_2 = board[win_index_2]
      position_3 = board[win_index_3]

      if (position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O")
         return win_combination
      end
   end
   return false
end


def full?(board)
board.each do |position|
  if position == " "
    return false
  end
end
  return true
end

def draw?(board)
  if won?(board)
     return false
  else
     if full?(board)
       return true
     else
       return false
     end
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
    if won?(board) == false
        return nil
      else
      win = won?(board)
      x    =  win[0]
    if board[x] == "X"
        return "X"
      elsif board[x] == "O"
        return "O"
      end
    end
end

def play(board)
  until over?(board) do
    turn(board)
  end
  if won?(board)
    winner = winner(board)
    puts "Congratulations #{winner}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
