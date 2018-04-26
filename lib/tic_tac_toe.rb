



def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
 (!position_taken?(board,index) && index.between?(0,8))? true : false
end

def move(board, index, char)
  board[index] = char
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board, index, current_player(board))
    display_board(board)
    puts ""
    puts ""
    puts ""
  else
    puts " INVALID MOVE "
    turn(board)
  end
  display_board(board)
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end



def input_to_index(input)
  input.to_i - 1
end 

def turn_count(board)
    count = 0
      board.each do |position|
      if position == "X" || position == "O"
          count += 1 
      end
    end
    count 
  end 
  
def current_player(board)
    if turn_count(board) % 2 == 0
      "X"
    else  
      "O"
    end
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2],  # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right  column
  [0,4,8],  # Backslash diagonal
  [2,4,6]   # Forwardslash diagonal
  ]
  win_index_1 = WIN_COMBINATIONS[0]
  win_index_2 = WIN_COMBINATIONS[1]
  win_index_3 = WIN_COMBINATIONS[2]
  win_index_4 = WIN_COMBINATIONS[3]
  win_index_5 = WIN_COMBINATIONS[4]
  win_index_6 = WIN_COMBINATIONS[5]
  win_index_7 = WIN_COMBINATIONS[6]
  win_index_8 = WIN_COMBINATIONS[7]
  
  
  
  
  
  def play(board) 
    until over?(board) do
      turn(board)
    end
      if won?(board)
        #binding.pry
        puts "Congratulations #{winner(board)}!"
      else
        puts "Cat's Game!"
      end
  end  
  
  def won?(board)
    WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && position_taken?(board, combo[1])
    end
  end
  
  def winner(board)
    if won?(board)
        board[won?(board)[0]]
    end
  end
  def full?(board)
    board.all?{|cell| cell == "X" || cell == "O"}
  end
  
  def draw?(board)
     !won?(board) && full?(board)
  end
  
  def over?(board)
    won?(board) || full?(board) || draw?(board)
  end  
  

