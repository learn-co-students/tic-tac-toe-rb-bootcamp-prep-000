# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts '-----------'
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, position, token)
  board[position] = token
end

def input_to_index(input)
  input.to_i - 1
end

def valid_move?(board, position)
  position.between?(0,8) && !position_taken?(board, position)
end

def turn(board)
  puts "Please enter a move."
  position = input_to_index(gets.strip)
  
  if !valid_move?(board, position)
    puts "The move you entered is not valid."
    turn(board)
  end
  
  board[position] = current_player(board)
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

# Define your WIN_COMBINATIONS constant
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

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    next if !position_taken?(board, combo[0]) || !position_taken?(board, combo[1]) || !position_taken?(board, combo[2])
    if board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]]
      return combo
    end
  end
  false
end

def full?(board)
  board.all? {|pos| pos != nil && pos != " "}
end

def draw?(board)
  if !full?(board)
    return false
  end
  !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  winner = won?(board)
  winner ? board[winner[0]]: nil
end

def play(board)
  while !over?(board)
    turn(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
      return
    end
    if draw?(board)
      puts "Cat\'s Game!"
      return
    end
  end
  winner = winner(board)
  puts winner ? "Congratulations #{winner}!" : "Cat\'s Game!"
end







