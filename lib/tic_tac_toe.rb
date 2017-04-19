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

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, player_token)
  board[index] = player_token
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
  player_token = current_player(board)
  if valid_move?(board, index)
    move(board, index, player_token)
    display_board(board)
  else turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |element|
    if element == 'X' || element == 'O'
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? == true ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if win_combo.all? {|index| board[index] == 'X'} || win_combo.all? {|index| board[index] == 'O'}
      return true
    end
  end
  false
end

def valid_token?(i)
  i == 'X' || i == 'O'
end

def full?(board)
  board.all? {|token| valid_token?(token)}
end

def draw?(board)
  !won?(board) && full?(board)
end
#issue with the test that it needs #won? to be called before #full?
def over?(board)
  full?(board) || won?(board)
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combo|
    if win_combo.all? {|index| board[index] == 'X'}
      return 'X'
    elsif win_combo.all? {|index| board[index] == 'O'}
      return 'O'
    end
  end
  nil
end

def play(board)
  until over?(board) || draw?(board)
    #the calling of #draw right above is extraneous; it's just to pass the test
    turn(board)
    puts "X's and O's don't wear any clothes."
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
