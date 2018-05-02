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

def move(board, index, current_player)
  
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
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

def play(board)
  until over?(board) do
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations player #{winner(board)}!!"
  end
  
  if draw?(board)
    puts "Game ends in a draw!!"
  end
end

def turn_count(board)
  board.count { |slot| slot == 'X' || slot == 'O'}
end

def current_player(board)
  (turn_count(board) % 2 == 0) ? 'X' : 'O'
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8],
    [0,3,6], [1,4,7], [2,5,8],
    [0,4,8], [2,4,6]
  ]
  
def won?(board)
    WIN_COMBINATIONS.find do |win_combination|
      ['X','O'].any? { |player| win_combination.all? { |slot| board[slot] == player}}
    end
end

def full?(board)
  board.all? {|slot| slot == 'X' || slot == 'O'}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : NIL
end
