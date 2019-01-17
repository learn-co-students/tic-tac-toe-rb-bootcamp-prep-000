require 'pry'
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
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
def get_board_combo(board, combo)
  combo.map{|x| board[x]}
end
def won?(board) 
  wins = WIN_COMBINATIONS.detect do |win_combo|
    board_combo = get_board_combo(board, win_combo)
    if board_combo == ['X','X','X']
      board_combo
    elsif board_combo == ['O','O','O']
      board_combo
    end
  end
end

def full?(board)
  if board.detect {|x| x == " "}
    FALSE
  else
    TRUE
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return TRUE
  else
    return FALSE
  end
end

def over?(board)
  if draw?(board) || won?(board)
    return TRUE
  end
end

def winner(board)
  if index = won?(board)
    board[index[0]]
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  #user_input.strip
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end
def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1 - 9"
  input = gets.strip
  index = input_to_index(input)
  
  if valid_move?(board, index)
    player = current_player(board)
    move(board, index, player)
    display_board(board)
  else
    puts('invalid')
    turn(board)
  end
end

def turn_count(board)
  turns = 0 
  board.each do | square |
    if square != " "
      turns += 1
    end
  end
  return turns
end

def current_player(board)
  turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def play(board)
  
  #is it over yet?
  puts "Enter 1-9"
  while turn_count(board) < 9 
    if over?(board)
      if player = winner(board)
        puts "Congratulations #{player}!"
        break #I want to break this keyboard so bad!
        
      elsif draw?(board)
        puts "Cat's Game!" #WTF is a cat's game?
        break #I'm taking a break */
      end
        
    end
    turn(board)
  end #loop end
end