def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
  final = []
  WIN_COMBINATIONS.each do |row|
    if board[row[0]] == "X" && board[row[1]] == "X" && board[row[2]] == "X"
      final << row
    elsif board[row[0]] == "O" && board[row[1]] == "O" && board[row[2]] == "O"
      final << row
    end
  end

  if final.empty?
    return false
  else
    return final[0]
  end

end

def valid_move?(board, index)
  if index < 0 || index > 9
    return false
  elsif position_taken?(board, index) == true
      return false
  elsif position_taken?(board, index) == false
      return true
  end
end

def full?(board)
  return true if board.none?{|el| el == " "} && !won?(board)
end

def draw?(board)
  if full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  return true if draw?(board)
  return true if full?(board)
  return true if won?(board)
  return false
end

def winner(board)
  winning_row = won?(board)
  return nil if winning_row == false
  return "O" if board[winning_row[0]] == "O"
  return "X" if board[winning_row[0]] == "X"
end

def input_to_index(guess)
  guess_int = guess.to_i
  if guess_int > 0
    guess_int = guess_int - 1
  else
    guess_int = -1
  end

  return guess_int
end

def move(board, position, mark)
  board[position] = mark
end

def turn(board)
puts "Please enter 1-9:"
move = gets.strip
num_move = input_to_index(move)
  if valid_move?(board, num_move)
    move(board, num_move, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  board.count{|el| el == "X" || el == "O"}
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  elsif turn_count(board).odd?
    return "O"
  end
end

def play(board)

    until over?(board)
     turn(board)
    end

    if draw?(board)
      puts "Cats Game!"
    end
    who_won = winner(board)
    puts "Congratulations #{who_won}!"
end
