# WIN_COMBINATIONS a constant
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]


def current_player(board)
  turn_number = turn_count(board) + 1
  turn_number.odd? ? current_player = "X" : current_player =  "O"

  return current_player
end


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end


def full?(board)
  board.each do |position|
    if position != "X" && position != "O"
      return false
    end
  end
  return true
end


def input_to_index(gets)
  index = gets.to_i - 1
end


def move(board, index, value)
  board[index] = value
end


def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
end


def play(board)

  while !over?(board)
    turn(board)
  end

  if draw?(board)
    puts "Cat's Game!"
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  while valid_move?(board, index) == false
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end

  player=  current_player(board)
  move(board, index, player)
  display_board(board)
end


def turn_count(board)
  turn_count = 0
  board.each do |turn|
    if turn == "X" || turn == "O"
      turn_count += 1
    end
  end
  return turn_count
end

def winner(board)
  winning_combination = won?(board)
  if winning_combination
    return board[winning_combination[0]]
  else
    return nil
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|

    if position_taken?(board, combination[0]) && position_taken?(board, combination[1]) && position_taken?(board, combination[2])
      position_1 = board[combination[0]]
      position_2 = board[combination[1]]
      position_3 = board[combination[2]]

      if position_1 == position_2 && position_2 == position_3
        return combination
      end
    end
  end
  return false
end


def valid_move?(board, index)

  if index.between?(0, 8)
    if position_taken?(board, index) == false
      return true
    else
      return false
    end
  else
    return false
  end
end
