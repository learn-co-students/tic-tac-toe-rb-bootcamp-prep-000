def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],

  [0,3,6],
  [1,4,7],
  [2,5,8],

  [0,4,8],
  [2,4,6],
]

def input_to_index(input)
  input.to_i-1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board,index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,position)
  position.between?(0,8) && !position_taken?(board, position)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, character = current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if position == "X" || position == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else turn_count(board) % 2 == 1
    return "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    combination.all? { |index| board[index] == 'X' } || combination.all? { |index| board[index] == 'O' }
  end
end

def full?(board)
  board.all? { |space|
    space == "X" || space == "O"  }
  end

  def draw?(board)
    !won?(board) && full?(board)
  end

  def over?(board)
    full?(board) || won?(board) || draw?(board)
  end

  def winner(board)
    if won?(board) == nil
      return nil
    else
      win_array = won?(board)
    end
    if board [win_array[0]] == "X"
      return "X"
    else
      return "O"
    end
  end

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
