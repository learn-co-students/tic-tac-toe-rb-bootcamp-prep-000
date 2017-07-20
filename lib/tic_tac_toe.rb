WIN_COMBINATIONS = [
  [0, 1, 2], [3, 4, 5], [6, 7, 8],
  [0, 3, 6], [1, 4, 7], [2, 5, 8],
  [0, 4, 8], [2, 4, 6]
]

def play (board)

  while over?(board) == false
    turn(board)
    if won?(board) == true
      winner(board)
      return
    end
  end









  if winner(board) == 'X'

  elsif winner(board) == 'O'
    puts "Congratulations O!"
  end

end



def display_board (board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move? (board, index)
  #con = position_taken? (board, index)
  if index > 8 || index < 0
    false
  elsif (position_taken?(board, index)) == false
    true
  end
end

def position_taken? (board, index)
  if board[index] == "" || board[index] == " " || board[index] == nil
    false
  else
    true
  end
end

def input_to_index (input)
  output = input.to_i - 1
  return output
end

def move(array, index, char)
  array[index] = char
  return array
end

def turn(board)

  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, 'X')
    display_board(board)
  else
    puts "Invalid input, try again"
  
      turn(board)


  end
end

def turn_count (board)
  turn = 0
  board.each do |cell|
    if cell == 'x' || cell == 'X' || cell == 'o' || cell == 'O'
      turn += 1
    end
  end
  turn
end

def current_player (board)
  current = ''
  if turn_count(board) % 2 == 0
    current = 'X'
  else
    current = 'O'
  end
  current
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end



#SHOUDL HAVE USED .each do |x| end BUT SHIT HAPPENS

def won? (board)
  if (board[WIN_COMBINATIONS[0][0]] == 'X' && board[WIN_COMBINATIONS[0][1]] == 'X' && board[WIN_COMBINATIONS[0][2]] == 'X')
    return WIN_COMBINATIONS[0]
  elsif (board[WIN_COMBINATIONS[0][0]] == 'O' && board[WIN_COMBINATIONS[0][1]] == 'O' && board[WIN_COMBINATIONS[0][2]] == 'O')
    return WIN_COMBINATIONS[0]
  end

  if (board[WIN_COMBINATIONS[1][0]] == 'X' && board[WIN_COMBINATIONS[1][1]] == 'X' && board[WIN_COMBINATIONS[1][2]] == 'X')
    return WIN_COMBINATIONS[1]
  elsif (board[WIN_COMBINATIONS[1][0]] == 'O' && board[WIN_COMBINATIONS[1][1]] == 'O' && board[WIN_COMBINATIONS[1][2]] == 'O')
    return WIN_COMBINATIONS[1]
  end

  if (board[WIN_COMBINATIONS[2][0]] == 'X' && board[WIN_COMBINATIONS[2][1]] == 'X' && board[WIN_COMBINATIONS[2][2]] == 'X')
    return WIN_COMBINATIONS[2]
  elsif (board[WIN_COMBINATIONS[2][0]] == 'O' && board[WIN_COMBINATIONS[2][1]] == 'O' && board[WIN_COMBINATIONS[2][2]] == 'O')
    return WIN_COMBINATIONS[2]
  end

  if (board[WIN_COMBINATIONS[3][0]] == 'X' && board[WIN_COMBINATIONS[3][1]] == 'X' && board[WIN_COMBINATIONS[3][2]] == 'X')
    return WIN_COMBINATIONS[3]
  elsif (board[WIN_COMBINATIONS[3][0]] == 'O' && board[WIN_COMBINATIONS[3][1]] == 'O' && board[WIN_COMBINATIONS[3][2]] == 'O')
    return WIN_COMBINATIONS[3]
  end

  if (board[WIN_COMBINATIONS[4][0]] == 'X' && board[WIN_COMBINATIONS[4][1]] == 'X' && board[WIN_COMBINATIONS[4][2]] == 'X')
    return WIN_COMBINATIONS[4]
  elsif (board[WIN_COMBINATIONS[4][0]] == 'O' && board[WIN_COMBINATIONS[4][1]] == 'O' && board[WIN_COMBINATIONS[4][2]] == 'O')
    return WIN_COMBINATIONS[4]
  end

  if (board[WIN_COMBINATIONS[5][0]] == 'X' && board[WIN_COMBINATIONS[5][1]] == 'X' && board[WIN_COMBINATIONS[5][2]] == 'X')
    return WIN_COMBINATIONS[5]
  elsif (board[WIN_COMBINATIONS[5][0]] == 'O' && board[WIN_COMBINATIONS[5][1]] == 'O' && board[WIN_COMBINATIONS[5][2]] == 'O')
    return WIN_COMBINATIONS[5]
  end
  if (board[WIN_COMBINATIONS[6][0]] == 'X' && board[WIN_COMBINATIONS[6][1]] == 'X' && board[WIN_COMBINATIONS[6][2]] == 'X')
    return WIN_COMBINATIONS[6]
  elsif (board[WIN_COMBINATIONS[6][0]] == 'O' && board[WIN_COMBINATIONS[6][1]] == 'O' && board[WIN_COMBINATIONS[6][2]] == 'O')
    return WIN_COMBINATIONS[6]
  end
  if (board[WIN_COMBINATIONS[7][0]] == 'X' && board[WIN_COMBINATIONS[7][1]] == 'X' && board[WIN_COMBINATIONS[7][2]] == 'X')
    return WIN_COMBINATIONS[7]
  elsif (board[WIN_COMBINATIONS[7][0]] == 'O' && board[WIN_COMBINATIONS[7][1]] == 'O' && board[WIN_COMBINATIONS[7][2]] == 'O')
    return WIN_COMBINATIONS[7]
  end
else
  return false
end

def full? (board)
  board.each do |index|
    if index == " " || index == nil
      return false
    end
  end
  return true
end

def draw? (board)
  result1 = won?(board)
  result2 = full?(board)

  if result1 == false && result2 == true
    puts "Cats Game!"
    return true
  else false
  end

end

def over? (board)
  won = won?(board)
  full = full?(board)
  draw = draw?(board)

  if won == true
    return true
  elsif full == true
    return true
  elsif draw == true
    return true
  else
    return false
  end
end



#PENDING FURTHER SOLUTION
def winner (board)
  if board[0] == 'X' && board[1] == 'X' && board[2] == 'X'
    puts "Congratulations X!"
    return "X"
  elsif board[3] == 'X' && board[4] == 'X' && board[5] == 'X'
    puts "Congratulations X!"
    return "X"
  elsif board[6] == 'X' && board[7] == 'X' && board[8] == 'X'
    puts "Congratulations X!"
    return "X"
  elsif board[2] == 'X' && board[4] == 'X' && board[6] == 'X'
    puts "Congratulations X!"
    return "X"
  elsif board[0] == 'X' && board[4] == 'X' && board[8] == 'X'
    puts "Congratulations X!"
    return "X"
  elsif board[0] == 'X' && board[3] == 'X' && board[6] == 'X'
    puts "Congratulations X!"
    return "X"
  elsif board[1] == 'X' && board[4] == 'X' && board[7] == 'X'
    puts "Congratulations X!"
    return "X"
  elsif board[2] == 'X' && board[5] == 'X' && board[8] == 'X'
    puts "Congratulations X!"
    return "X"

  elsif board[0] == 'O' && board[1] == 'O' && board[2] == 'O'
    puts "Congratulations O!"
      return "O"
    elsif board[3] == 'O' && board[4] == 'O' && board[5] == 'O'
      puts "Congratulations O!"
      return "O"
    elsif board[6] == 'O' && board[7] == 'O' && board[8] == 'O'
      puts "Congratulations O!"
      return "O"
    elsif board[2] == 'O' && board[4] == 'O' && board[6] == 'O'
      puts "Congratulations O!"
      return "O"
    elsif board[0] == 'O' && board[4] == 'O' && board[8] == 'O'
      puts "Congratulations O!"
      return "O"
    elsif board[0] == 'O' && board[3] == 'O' && board[6] == 'O'
      puts "Congratulations O!"
      return "O"
    elsif board[1] == 'O' && board[4] == 'O' && board[7] == 'O'
      puts "Congratulations O!"
      return "O"
    elsif board[2] == 'O' && board[5] == 'O' && board[8] == 'O'
      puts "Congratulations O!"
      return "O"
    end
end
