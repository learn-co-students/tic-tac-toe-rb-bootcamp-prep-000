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
  input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  board[index] != " " && board[index] != "" && board[index] != nil
end

def valid_move?(board, index)
  if (index.between?(0,9) && !position_taken?(board, index))
    true
  else
    false
  end
end

def turn(board)
  entry = -1
  loop do
    puts "Please enter 1-9:"
    entry = input_to_index(gets.strip)
    if valid_move?(board, entry)
      break
    end
  end
  move(board, entry, current_player(board))
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |letter|
    if letter != " "
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if ((position_1 == "X" && position_2 == "X" && position_3 == "X") ||
        (position_1 == "O" && position_2 == "O" && position_3 == "O"))
      return win_combination
    end
  end
  false
end

def full?(board)
  board.all? {|val| !(val.nil? || val == " ")}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  result = won?(board)
  if (result.class == Array)
    board[result[0]]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
