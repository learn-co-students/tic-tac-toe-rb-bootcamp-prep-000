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

def move(board, index, current)
  board[index] = x
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
    turns = 0
    board.each do |tile|
      if tile == "X" || tile == "O"
        turns += 1
      end
    end
    turns
  end
  
  def current_player(board)
    if turn_count(board) % 2 == 0 
       "X"
    else
       "O"
    end
  end  
  
  def won?(board)
    winner = false
    WIN_COMBINATIONS.each do |wincombination|
      if board[wincombination[0]] == "X" && board[wincombination[1]] == "X" && board[wincombination[2]] == "X"
        winner = wincombination
      elsif board[wincombination[0]] == "O" && board[wincombination[1]] == "O" && board[wincombination[2]] == "O"
        winner = wincombination
      end
    end
    winner
  end
  
def full?(board)
  board.all? do |slot|
      slot == "X" || slot == "O"
    end
  end

def draw?(board)
    draw = false
    full = full?(board)
    won = won?(board)
    if full == true && won == false
      draw = true
    end
  end
  
def over?(board)
    over = false
    draw = draw?(board)
    full = full?(board)
    won = won?(board)
    if full == true || draw == true || won != false
      over = true
    end
  end
  
def winner(board)
    if won?(board) == false
      nil
    elsif board[won?(board)[0]] == "X"
      "X"
    elsif board[won?(board)[1]] == "O"
      "O"
    end
  end
  
def play(board)
    if !over?(board)
      turn(board)
    end
    if won?(board) != false
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board) == true
      puts "Cat's Game!"
    end
  end
