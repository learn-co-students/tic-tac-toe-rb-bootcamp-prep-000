
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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  char = current_player(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, char)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |index|
    if index == "X" || index == "O"
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |array|
    if board[array[0]] == "X" && board[array[1]] == "X" && board[array[2]] == "X" ||
      board[array[0]] == "O" && board[array[1]] == "O" && board[array[2]] == "O"
      return array
     end
  end
  false
end

def full?(board)
   board.all? { |index| index == "X" || "O" }
   !(board.include?(" " || nil))
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || full?(board) || won?(board) != false
end

def winner(board)
  win_combo = won?(board)

  if win_combo == false
    nil
  else
    if board[win_combo[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)

 while over?(board) == false
    turn(board)
 end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end

=begin def play(board)

  until over?(board) == true
    turn(board)
    won?(board)
    draw?board
    if won?(board) != false
     if winner(board) == "X"
       puts "Congratulations X!"
       return
     elsif winner(board) == "O"
       puts "Congratulations O!"
       return
     end
    end

    if draw?(board)
     puts "Cats Game!"
     return
    end
  end

end
=end
