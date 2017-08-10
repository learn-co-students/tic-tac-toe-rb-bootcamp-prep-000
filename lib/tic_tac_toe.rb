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
  line = "-----------"
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
  puts row1
  puts line
  puts row2
  puts line
  puts row3
end

def input_to_index(user_input)
  return (user_input.to_i) - 1
end

def valid_move?(board, space)
  if (space < 0 || space > 8)
    return false
  elsif ((position_taken?(board,space)))
    return false
  else
    return true
  end
end

def position_taken?(board, space)
  if (board[space] == "" || board[space] == " " || board[space] == nil)
    return false
  else
    return true
  end
end

def move(board, space, mark)
    board[space] = mark
end

def turn_count(board)
  count = 0
  board.each do |space|
    if (space == "X" || space == "O")
      count += 1
    end
  end
  return count
end


def current_player(board)
  return (turn_count(board) % 2 == 0) ? "X" : "O"
end

def turn(board)
  puts "Please enter 1-9:"
  choice = gets.strip
  choice = input_to_index(choice)
  if(valid_move?(board, choice))
    move(board, choice, current_player(board))
    display_board(board)
  else
    puts "Invalid move!"
    turn(board)
  end
end

def won?(board)
    x = WIN_COMBINATIONS.select do |combo|
    (board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && (board[combo[2]] == "X" || board[combo[2]] == "O"))
    end
    return x[0]
end

def full?(board)
  return board.all?{|i| i == "X" || i == "O"}
end

def draw?(board)
  return (full?(board) && !won?(board)) ? true : false
end

def over?(board)
  return (draw?(board) || won?(board)) ? true : false
end

def winner(board)
  if(over?(board) && won?(board))
    return board[won?(board)[0]]
  end
end

def play(board)
  while (!over?(board))
    turn(board)
  end
  if (won?(board))
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
