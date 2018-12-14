#tictactoe game 


def turn_count(board)
  counter = 0 
  board.each do |piece|
    if piece == 'X' || piece == 'O'
      counter += 1 
    end
  end
  counter
end

def current_player(board)
  (turn_count(board) % 2).even? ? 'X' : 'O'
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!

def input_to_index(input)
  input.to_i - 1 
end

def move(board, index, piece)
  board[index] = piece
end

# code your #valid_move? method here
def valid_move?(board, index)
  index.between?(0, 8) && !position_taken(board, index) ? true : false 
end
    
  

def position_taken(board, index)
  board[index] == " " || board[index] == "" || board[index] == nil ? false : true 
end

def turn(board)
  puts "Please enter 1-9:"
  position = gets.strip.chomp
  index = input_to_index(position)
  if valid_move?(board, index)
    piece = current_player(board)
    move(board, index, piece)
    display_board(board)
  else
    turn(board)
  end
  true
end


# Helper Method
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
  [2,4,6],
  [0,4,8]
]

def won?(board)
  for win_combination in WIN_COMBINATIONS do 
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    if (board[win_index_1] == 'X' &&
         board[win_index_2] == 'X' &&
         board[win_index_3] == 'X') || 
         (board[win_index_1] == 'O' &&
          board[win_index_2] == 'O' &&
          board[win_index_3] == 'O')
      return win_combination
    end
  end
  false
end

def full?(board)
  board.all? { |piece| piece == "X" || piece == "O" }
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

def over?(board)
  full?(board) || won?(board) || draw?(board) ? true : false
end

def winner(board)
  won = won?(board)
  won ? board[won[0]] : nil
end


def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
