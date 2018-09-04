#define WIN_COMBINATIONS

WIN_COMBINATIONS = [ 
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]]
  
#def display board

def display_board(board)
  
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

#def input_to_index

def input_to_index(user_input)
  
  user_index = user_input.to_i
  user_index - 1
end

#def move

def move(board, user_index, player_char)
  board[user_index] = player_char
end

#def position_taken?

def position_taken?(board, index)
  
  !(board[index].nil? || board[index] == " ")
end

#def valid_move?

def valid_move?(board, index_num)
  
  if !(position_taken?(board, index_num)) && (index_num.between?(0, 8))
    TRUE
  else
    FALSE
  end
end

#def turn 

def turn(board)
  puts "Please enter 1-9:"
  
  input = gets
  index = input_to_index(input)
  
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)

  else turn(board)
  end
end

#def turn_count

def turn_count(board)
  counter = 0 
  board.each do |index|
    if index == "X" || index == "O"
      counter += 1
    end
  end
  return counter
end

#def current_player

def current_player(board)
  
  (turn_count(board) % 2).even? ? 'X' : 'O'
end  

#def won?

def won?(board)
  
  WIN_COMBINATIONS.detect do |win_combination|
    
    board[win_combination[0]] == board[win_combination[1]] && board[win_combination[1]] == board[win_combination[2]] && position_taken?(board, win_combination[0])
  end
end

#def full?
  
def full?(board)
  board.none? {|i| i.nil? || i == " "}
end

#def draw?
  
def draw?(board)
  !won?(board) && full?(board)
end

#def over?
  
def over?(board)
  won?(board) || draw?(board)
end

#def winner

def winner(board)
  if win_combo = won?(board)
    return board[win_combo.first]
  end
end

# def play

def play(board)
  while(!over?(board))
    turn(board)
  end
  
  if won?(board)
    puts "Congratulations #{winner(board)}!"
    
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

