
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


def input_to_index(user_input)
  index = user_input.to_i - 1
end


def move(board, index, value)
  board[index] = value
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def valid_move?(board, index)
  if (if (board[index] == " ") || 
         (board[index] == "") ||
         (board[index] == nil)
        false
      else
        true
      end)
  elsif index.between?(0, 8)
    true
  else
    false
  end
end


def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index) === true
    value = current_player(board)
    move(board, index, value)
    display_board(board)
  else
    until valid_move?(board, index) === true
      user_input = gets.strip
      index = input_to_index(user_input)
      break
    end
    display_board(board)
  end
end


def turn_count(board)
  count = 0
  board.each do |position|
    if (position === "X") || (position === "O")
      count += 1
    end
  end
  count
end


def current_player(board)
  if turn_count(board) % 2 === 0
    "X"
  else
    "O"
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
  
    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]
    
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
      (position_1 == "O" && position_2 == "O" && position_3 == "O")
      return win_combination
    end
  end
  false
end


def full?(board)
  if board.any?{|i| i == " "}
    false
  else    
    true
  end
end


def draw?(board)
  if full?(board) == true && won?(board) == false
    true
  else
    false
  end
end


def over?(board)
  if draw?(board) == true ||
     full?(board) == true ||
     won?(board) != false
    true
  else
    false
  end
end


def winner(board)
  if won?(board) != false
    if board[won?(board)[0]] == "X"
      "X"
    else
      "O"
    end
  end
end


def play(board)
  count = 0
  until count == 9 || over?(board) == true
    turn(board)
    count += 1
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  elsif draw?(board) == true
    puts "Cat's Game!"
  end
end