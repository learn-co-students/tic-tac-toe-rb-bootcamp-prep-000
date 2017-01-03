def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#MAIN GAMEPLAY

def play(board)
     while !over?(board)
       turn(board)
     end
      if won?(board)
        puts "Congratulations #{winner(board)}!"
      elsif draw?(board)
        puts "Cats Game!"
      end
   end

def turn(board)
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
    else
      puts "That is not a valid move."
      turn(board)
    end
    display_board(board)
end

#TURN HELPERS


def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0
  board.each do |move|
    if move == "X" or move == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end







def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
 [0, 1, 2],
 [3, 4, 5],
 [6, 7, 8],
 [0, 3, 6],
 [1, 4, 7],
 [2, 5, 8],
 [0, 4, 8],
 [2, 4, 6],
]

def won?(board)
  if
  WIN_COMBINATIONS.each do |win_combination|
    position_1 = win_combination[0]
    position_2 = win_combination[1]
    position_3 = win_combination[2]
     if board[position_1] == "X" && board[position_2] == "X" && board[position_3] == "X"
       return win_combination
     elsif board[position_1] == "O" && board[position_2] == "O" && board[position_3] == "O"
       return win_combination
   end
 end
 else
   return false
 end
end

def full?(board)
 board.all? do |index|
   !(index == nil || index == " " || index == "")
 end
end

def empty?(board)
  board.all? do |index|
    (index == nil || index == " " || index == "")
  end
 end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if !won?(board)
    return nil
  else
    won?(board).each do |index|
      return board[index]
    end
  end
end
