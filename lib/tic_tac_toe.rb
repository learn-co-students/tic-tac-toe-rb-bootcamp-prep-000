WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,4,8], [6,4,2], [0,3,6], [1,4,7], [2,5,8] ]

def display_board(board)
  puts " "
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  puts " "
end

board = [" "," "," "," "," "," "," "," "," "]
display_board(board)

def input_to_index(user_input)
    user_input.to_i - 1
end

def move(board, position, character)
  board[position] = character
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
    userInput = gets.strip
    index = input_to_index(userInput)
    if !valid_move?(board, index)
      turn(board)
    else
      move(board, index, current_player(board))
    end
  display_board(board)
end

def turn_count(board)
    count = 0
  board.each do |index|
    if index != " "
      count += 1
    end
  end
    count
 end

 def current_player(board)
   if turn_count(board) % 2 == 0
        return "X"
   else
        return "O"
   end
 end

 def won?(board)
    board.all? {|i| i != " " || i != ""}
    win = WIN_COMBINATIONS.detect do |winning_array|
      if winning_array.all? {|position| board[position] == "X" } == true
        win.inspect
        true
      elsif winning_array.all? {|position| board[position] == "O" } == true
        win.inspect
        true
      end
    end
  end

def full?(board)
  board.all? do |position|
    position == "X" || position == "O"
  end
end

def draw?(board)
  if (won?(board) == nil) && full?(board) == true
    draw = true
  else
    draw = false
  end
end

def over?(board)
   if (won?(board) != nil) || (draw?(board) == true) || (full?(board) == true)
     over = true
   else
     over = false
   end
 end

def winner(board)
  if (draw?(board) || !full?(board)) && !won?(board)
      return nil
    elsif (board[won?(board)[0]] == "X")
      return "X"
    elsif (board[won?(board)[0]] == "O")
      return "O"
    end
  end

def play(board)
   while !over?(board) && !won?(board) && !draw?(board)
     turn(board)
   end
   if won?(board)
     puts "Congratulations #{winner(board)}!"
    end
   if draw?(board)
     puts "Cat's Game!"
   end
  end
