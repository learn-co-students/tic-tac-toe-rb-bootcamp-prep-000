
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
  index = input.to_i - 1

  if index < 0
    return -1
  end

  return index
end

def move(board, index, token)

  return board[index] = token

end

def position_taken?(board, index)

  !(board[index].nil? || board[index] == " ")

end

def valid_move?(board, index)

  index.between?(0, 8) && position_taken?(board, index) == false

end

def turn(board)
  puts "Please enter 1-9:"

  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    token = current_player(board)
    move(board, index, token)
    display_board(board)
  else
    puts "That isn't a valid move"
    turn(board)
  end
end

def turn_count(board)
  turns_played = 0

  board.each do |turn|
    if turn == 'X' || turn == 'O'
      turns_played += 1
    end
  end
  return turns_played
end

def current_player(board)

  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end

end

def won?(board)

  WIN_COMBINATIONS.each do |win_combo|
    #
    all_taken = win_combo.all? do |index|
      position_taken?(board, index)
    end #end all taken.all

    if all_taken
      # puts "full combo #{win_combo}"

      all_X = win_combo.all? do |index|
        board[index] == 'X'
      end  #end all X

      all_O = win_combo.all? do |index|
        board[index] == 'O'
      end  #end all O

    end #end if all taken
    #
    if all_X || all_O
      # puts "allX #{all_X} or All O #{all_O}"
      return win_combo
      return all_X
      return all_O
    end #end if all_X

  end #end WIN_COMBINATIONS each

  return false

end #end won?

def full?(board)
  board.all? do |index|
    !(index.nil? || index == " ")
    #position_taken?(board, index)
  end
  # puts full
end

def draw?(board)
  full = full?(board)
  won = won?(board)

  if full && !won
    return true
  end

  if !full && !won
    return false
  end

  if won
    return false
  end

end

def over?(board)

    full?(board) || draw?(board) || won?(board)
    # return full, draw, or won?
end

def winner(board)
  win_combo = won?(board)
  if win_combo != false

    if win_combo.all?{|index| board[index] == 'X'}
      return 'X'
    end

    if win_combo.all?{|index| board[index] == 'O'}
      return 'O'
    end
  end
end

def play(board)
  
  while !over?(board)
    turn(board)
    current_player = current_player(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end

  if draw?(board)
    puts "Cats Game!"
  end


end
