WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
                    [0, 3, 6], [1, 4, 7], [2, 5, 8],
                    [0, 4, 8], [2, 4, 6]]

def play(board)
  until over?(board)
    turn(board)
  end 
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
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

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    return false
  elsif board[index] == "X" || board[index] == "O"
    return true
  end
end

def valid_move?(board, index)
  if index.between?(0, 8) and !position_taken?(board, index)
    return true 
  else
    return false
  end
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

def turn_count(board)
  counter = 0
  board.each do |square|
    if square == 'X' || square == 'O'
      counter += 1 
    end
  end
  counter
end

def current_player(board)
  counter = turn_count(board)
  player = counter % 2 == 0 ? 'X' : 'O'
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end



def won?(board)
  WIN_COMBINATIONS.each do |nums|
    if nums.all?{|index| board[index] == 'X'} or nums.all?{|index| board[index] == 'O'}
      return nums
    end
  end
  return false
end

def full?(board)
  if (0..8).to_a.all?{|index| position_taken?(board, index)}
    return true
  end
  return false
end

def draw?(board)
  full?(board) && !won?(board) ? true : false
end

def over?(board)
  won?(board) or draw?(board) or full?(board)
end

def winner(board)
  winner = won?(board)
  if winner.is_a?(Array)
    return board[winner[0]] == 'X' ? 'X' : 'O'
  end
  return nil
end
