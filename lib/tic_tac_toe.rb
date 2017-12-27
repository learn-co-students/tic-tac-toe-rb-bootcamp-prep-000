
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


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  return input.to_i - 1
end

def move(board, index, mark)
  board[index] = mark
end

def position_taken?(board, index)
  return (board[index] == " " || board[index] == "" || board[index] == nil)? false : true
end

def valid_move?(board, index)
 return index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    mark = current_player(board)
    move(board, index, mark)
    display_board(board)
  else
    turn(board)
  end
end


def turn_count(board)
  number_of_turns_played = 0

  board.each do |turn|
    if turn == "X" || turn == "O"
      number_of_turns_played += 1
    end
  end
  return number_of_turns_played
end

def current_player(board)
  turns = turn_count(board)
  turns.even? ? "X" : "O"
end


def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if combination.all? {|index| board[index] == "X"}
      return combination
    elsif combination.all? {|index| board[index] == "O"}
      return combination
    end
  end
  return false
end

def full?(board)
  return board.all? {|index| index == "X" || index == "O"}
end


def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  return won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    winning_combo = won?(board)
    return board[winning_combo[0]]
  else return nil
  end
end

def play(board)
  while !over?(board) do
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
