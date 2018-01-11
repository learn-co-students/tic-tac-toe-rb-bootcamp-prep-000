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
  int = input.to_i - 1
end

def move(board, position, player)
  board[position] = player
end

def position_taken?(board, position)
  board[position] == "X" || board[position] == "O"
end

def valid_move?(board, position)
  if position < 9 && position > -1
    return !position_taken?(board, position)
  end
  false
end

def turn(board)
  while true
      puts "Your move: "
      position = input_to_index(gets.strip)
      if valid_move?(board, position)
        move(board, position, current_player(board))
        return
      end
  end
end

def turn_count(board)
  count = 0
  for position in 0..8
    if position_taken?(board, position)
      count += 1
    end
  end
  count
end

def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  end
  "O"
end

def won?(board)
  winner(board) != nil
end

def full?(board)
  turn_count(board) == 9
end

def draw?(board)
  if won?(board)
    return false
  end
  full?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |combination|
    position1 = board[combination[0]]
    position2 = board[combination[1]]
    position3 = board[combination[2]]
    if position1 == position2
      if position2 == position3 && position1 != " "
        return position1
      end
    end
  end
  return nil
end

def play(board)
  while !over?(board)
    turn(board)
  end
  win_player = winner(board)
  if win_player == nil
    puts "Cat\'s Game!"
  else
    puts "Congratulations #{win_player}!"
  end
end
