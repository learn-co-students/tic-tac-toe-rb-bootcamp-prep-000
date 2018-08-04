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

def display_board(array)
  puts " #{array[0]} | #{array[1]} | #{array[2]} "
  puts "-----------"
  puts " #{array[3]} | #{array[4]} | #{array[5]} "
  puts "-----------"
  puts " #{array[6]} | #{array[7]} | #{array[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(array, position, marker)
  array[position]= marker
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(array)
  turns = 0
  array.each do |item|
    if (item != " ")
      turns += 1
    end
  end
  turns
end

def current_player(array)
  count = turn_count(array)
  if (count % 2 == 0)
    "X"
  else
    "O"
  end
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

def play(array)
  9.times do
    turn(array)
  end
end


def won?(array)
  winning_move = nil
  WIN_COMBINATIONS.each do | combo |
    first_position = combo[0]
    second_position = combo[1]
    third_position = combo[2]

    first_mark = array[first_position]
    second_mark = array[second_position]
    third_mark = array[third_position]
    if (first_mark == second_mark) && (first_mark == third_mark) && position_taken?(array, first_position)
      winning_move = combo
    end
  end
  winning_move
end

def full?(array)
  !array.any?{|i| i == " "}
end

def draw?(array)
  full?(array) && !won?(array)
end

def over?(array)
  draw?(array) || won?(array)
end

def winner(array)
  winning_move = won?(array)
  if (winning_move)
    array[winning_move[0]]
  else
    winning_move
  end
end
