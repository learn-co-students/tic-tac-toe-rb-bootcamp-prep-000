# Helper Methods

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

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end



# Define your play method below

def turn_count(board)
  counter = 0
  board.each do |marker|
    if marker == "X" || marker == "O"
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  counter = turn_count(board)
  if counter%2 == 0
    return "X"
  else
    return "O"
  end
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], #TOP row
  [3,4,5], #Middle row
  [6,7,8], #Bottom row
  [0,3,6], #Left column
  [1,4,7], #Middle column
  [2,5,8], #Right column
  [0,4,8], #Topleft diagonal
  [2,4,6], #Topright diagonal
]

def won?(board)
  WIN_COMBINATIONS.detect do |combination|
    board[combination[0]] == 'X' && board[combination[1]] == 'X' && board[combination[2]] == 'X' ||
    board[combination[0]] == 'O' && board[combination[1]] == 'O' && board[combination[2]] == 'O'
  end
end

def full?(board)
  board.all? do |empty|
    empty != " "
  end
end

def draw?(board)
    if !won?(board) && full?(board)
      return true
    end
end

def over?(board)
    if full?(board) || won?(board) || draw?(board)
      return true
    end
end

def winner(board)
  if won?(board)
      if WIN_COMBINATIONS.detect {|combination| board[combination[0]] == 'X' && board[combination[1]] == 'X' && board[combination[2]] == 'X'}
        return 'X'
      else
        return 'O'
      end
  else
  return nil
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if turn_count(board)%2 == 0
      marker = "X"
  else
      marker = 'O'
  end
  until valid_move?(board, index) do
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
    move(board, index, marker)
    display_board(board)
end

def play(board)
  while !over?(board)
    turn(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "Cats Game!"
    end
  end
end
