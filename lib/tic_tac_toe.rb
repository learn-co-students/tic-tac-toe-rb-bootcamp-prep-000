WIN_COMBINATIONS = [
  [0, 1, 2], #row 1
  [3, 4, 5], #row 2
  [6, 7, 8], #row 3
  [0, 3, 6], #column 1
  [1, 4, 7], #column 2
  [2, 5, 8], #column 3
  [0, 4, 8], #diagonal top left to bottom right
  [2, 4, 6] #diagonal top right to bottom left
]

board = ["X", "O", " ", " ", " ", " ", " ", " ", " "]

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

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  return (index >= 0 && index <= 8 && board[index] != "X" && board[index] != "O")
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if turn_count(board) % 2 == 0
    character = "X"
  else
    character = "O"
  end
  if !valid_move?(board, index)
    turn(board)
  end
  move(board, index, character)
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |index|
    if index != " "
      count += 1
    end
  end
  count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  if !(board.include?("X") || board.include?("O"))
    return false
  end
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    if (position_taken?(board, win_index_1) && (board[win_index_1] == board[win_index_2]) && (board[win_index_1] == board[win_index_3]))
      puts "#{board[win_index_1]}, #{board[win_index_2]}, #{board[win_index_3]}"
      return win_combination
    end
  end
  false
end

def full?(board)
  !(board.include?(" "))
end

def draw?(board)
  return (!won?(board) && full?(board))
end

def over?(board)
  return (won?(board) || draw?(board) || full?(board))
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
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
