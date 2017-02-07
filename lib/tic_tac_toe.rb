def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

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
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(input)
   input.to_i - 1
end

def move(board, index, value )
  board[index] = value
  board
end

def position_taken? (board,index)
  if board[index] == " " || board[index] == ""
    false
  elsif board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  index.to_i - 1
  if index.between?(0, 8) && !position_taken?(board,index)
    true
  else
    false
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  new_index = input_to_index(input)

  until valid_move?(board,new_index)
  puts "Invalid move, please enter 1-9"
  new_input = gets.strip
  new_index = input_to_index(new_input)
  end
  move(board, new_index, current_player(board))
  display_board(board)

end


def turn_count(board)
  count = 0
 board.each do |token|
  if token == "X" || token =="O"
    count+=1
  end
end
return count
end

def current_player(board)
 count = turn_count(board)
 if count%2==0
   token="X"
 elsif count%2!=0
   token = "O"
 end
 end


def won?(board)
    WIN_COMBINATIONS.find do |combination_array|
     if combination_array.all? do |index|
          board[index]=="X"
        end
           true
     elsif combination_array.all? do |index|
             board[index]=="O"
           end
            true
     else
         false
     end
   end
end

def full?(board)
   if board.any? do |index|
     index == " " || index == "" || index == nil
     end
     return false
   else
     return true
   end
end


def draw?(board)
    if won?(board) && full?(board)
      return false
    elsif full?(board)
      return true
    end
end

def over?(board)
    if draw?(board) || full?(board) || won?(board)
      return true
    else
      return false
    end
end

def winner(board)
    if over?(board)
      winning_array = won?(board)
      current_position = winning_array[0]
      current_winner = board[current_position]
      return current_winner
    else
      nil
    end
end


def play(board)
  until over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cats Game!"
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"


end

end
