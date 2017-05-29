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

def display_board (board)
  def dashed_line
    11.times {print "-"}
    puts ""
  end
  puts " #{board[0]} " + "|" + " #{board[1]} " + "|" + " #{board[2]} "
  dashed_line
  puts " #{board[3]} " + "|" + " #{board[4]} " + "|" + " #{board[5]} "
  dashed_line
  puts " #{board[6]} " + "|" + " #{board[7]} " + "|" + " #{board[8]} "
end

def input_to_index(pos)
  board_pos = pos.to_i - 1
end

def move(array, index, x_or_o)
  array[index] = x_or_o
end

def position_taken?(array, index)
   !((array[index] == " ") || (array[index] == "") || (array[index] == nil))

end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0,8)

end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)

  occupied = 0

  board.each do |pos|
    if pos != '' && pos != ' ' && pos != nil
        occupied += 1
    end
  end

  occupied

end


def current_player(board)
  player = turn_count(board).even? ? 'X' : 'O'
end

def won?(board)

  WIN_COMBINATIONS.each do |win_combination|

    positions_to_check  = [board[win_combination[0]],
                          board[win_combination[1]],
                          board[win_combination[2]]]

    if positions_to_check.all?{|position| position == "X"} ||
        positions_to_check.all?{|position| position == "O"}
      return win_combination
    end
  end
  false # no winning combinations were found, return false
end

def full?(board)

  board.each_with_index do |val, index|
    if !position_taken?(board, index)
      return false
    end
  end
  true # all the positions must have been taken
end

def draw?(board)

  !won?(board) && full?(board)

end

def over?(board)

  won?(board) || draw?(board)

end

def winner(board)
  winning_positions = won?(board)
  if winning_positions
    return board[winning_positions[0]]
  end
end

def play(board)

  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end
