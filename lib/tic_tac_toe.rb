WIN_COMBINATIONS = [
 [0,1,2], # Top row
 [3,4,5],  # Middle row
 [6,7,8],  # Bottom row
 [0,3,6],  # First column
 [1,4,7],  # Middle column
 [2,5,8],  # Last column
 [0,4,8],  # Diagonal from top left to bottom right
 [6,4,2]  # Diagonal from bottom left to top right
]

def current_player(board)
  player = turn_count(board).even? ? "X" : "O"
end

def draw?(board)
  full?(board) && !won?(board)
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def full?(board)
  return board.all? do |space|
    space != " " && space != nil
  end
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, character)
  board[index.to_i] = character
end

def over?(board)
  full?(board) || draw?(board) || won?(board)
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)

    character = turn_count(board) % 2 == 0 ? "X" : "O"

    if valid_move?(board, index)
      move(board, index, character)
      display_board(board)
      return
    else
      turn(board)
    end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space != nil && space.strip != ""
      count += 1
    end
  end
  return count
end

def valid_move?(board, index)
  if !index.between?(0,9)|| position_taken?(board, index)
    return false
  else
    return true
  end
end

def winner(board)
  winning_combo = won?(board)

  if winning_combo
    return board[winning_combo[0]]
  else
    return nil
  end
end

def won?(board)
  combination_moves = []
  won = false

  WIN_COMBINATIONS.each do |combination|

    combination_moves = [board[combination[0]],
                         board[combination[1]],
                         board[combination[2]]]

    won = (combination_moves.all? do |character|
        character == "X" end) ||
        (combination_moves.all? do |character|
        character == "O" end)

    if won
      return combination
    end
  end

  return false
end
