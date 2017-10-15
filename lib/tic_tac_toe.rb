
WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player)
  board[index] = player
end

def position_taken?(board, index)
  case board[index]
  when " ", "", nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  if index < 0 || index > 8
    false
  else
    case board[index]
    when " ", "", nil
      true
    else
      false
    end
  end
end

def turn(board)
  index = nil
  loop do
    puts "What's your choice, partner? (1-9):"
    index = input_to_index(gets.strip)
    if valid_move?(board, index) then
      break
    end
  end

  move(board, index, current_player(board))
end

def turn_count(board)
  turns = 0
  board.each do |cell|
    case cell
    when "X", "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  if turn_count(board) % 2 == 0 then
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    if combination.all? { |e| board[e] == "X" } || combination.all? { |e| board[e] == "O" }
      return true
    end
  end
  false
end

def full?(board)
  board.each do |e|
    case e
    when " ", "", nil
      return false
    end
  end
  true
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  winner = nil
  WIN_COMBINATIONS.each do |combination|
    if combination.all? { |e| board[e] == "X" }
      return "X"
    elsif combination.all? { |e| board[e] == "O" }
      return "O"
    end
  end
  return nil
end

def play(board)
  until over?(board) do
    turn(board)
  end

  if draw?(board) then
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
