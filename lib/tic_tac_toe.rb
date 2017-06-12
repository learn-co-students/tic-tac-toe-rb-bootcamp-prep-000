
WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

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

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)

  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  elsif !over?(board)
    turn(board)
  end

end


def play(board)
  t = 1
  while (t <= 9) do
    break if over?(board)
    turn(board)

    t += 1
  end

  if draw?(board)
    puts "Cats Game!"
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end


end


def turn_count(board)
  count = 0
  board.each{ |slot| (count += 1) if (slot == "X" || slot == "O")}
  return count
end

def current_player(board)
  if (turn_count(board)%2 == 0)
    return "X"
  else
    return "O"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def won?(board)
   winning = WIN_COMBINATIONS.detect{ |combo| combo.all? { |position| board[position] == "X"} || combo.all? { |position| board[position] == "O"}}
   if winning == []
     return false
   else
     return winning
   end
end

def full?(board)
  (0..8).all? {|x| position_taken?(board, x)}
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return true
  end
end

def winner(board)
  winner = won?(board)
    if winner
      return board[winner[0]]
    end
end
