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

# Define your play method below
def play(board)
  while !(over?(board)) do
    turn(board)
  end
  if won?(board) then
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board) then
    puts "Cat's Game!"
  end
end




def turn_count(board)
  turn = 0
  board.each do |space|
    if space.strip == "X" || space.strip =="O"
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  return turn_count(board).even? ? "X" : "O"
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [[0,1,2],
                    [3,4,5],
                    [6,7,8],
                    [0,3,6],
                    [1,4,7],
                    [2,5,8],
                    [0,4,8],
                    [2,4,6]]


def get_locations(board, player = "X")
  locations = []
  location = 0
  while(location < 9) do
    if board[location].strip == player.strip
      locations << location
    end
    location += 1
  end
  return locations
end

def won?(board)
  x_locations = get_locations(board)
  y_locations = get_locations(board, "O")
  locations = [x_locations,y_locations]
  WIN_COMBINATIONS.each do |combination|
    locations.each do |location|
      win = location.detect{|a| a == combination[0]} != nil && location.detect{|a| a == combination[1]} != nil && location.detect{|a| a == combination[2]} != nil
      # puts(combination[0])
      # puts(location.detect{|a| a == combination[0]})
      if win then
        return combination
      end
    end
  end
  return FALSE
end


def full?(board)
  return board.detect{|a| a == " " || a == "" || a == nil} == nil
end

def draw?(board)
  return !(won?(board)) && (full?(board))
end

def over?(board)
  return draw?(board) || won?(board) || full?(board)
end

def winner(board)
  winLocation = won?(board)
  return winLocation ? ((get_locations(board).detect{|a| a == winLocation[0]} != nil && get_locations(board).detect{|a| a == winLocation[1]} != nil && get_locations(board).detect{|a| a == winLocation[2]} != nil) ? "X" : "O")  : nil
end
