board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def play(board)
  
  while !over?(board)
    turn(board)
  end
  if(won?(board))
    puts "Congratulations #{winner(board)}!"
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
  count = 0
  board.each do |a|
    if(a == "X" || a == "O")
      count +=1
    end
  end
  return count
end

def current_player(board)
  if(turn_count(board)%2==0)
    return "X"
  else
    return "O"
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

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

winner = ""
def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    if(win_combo.all? {|index| (position_taken?(board,index))})
      if(win_combo.all? {|ele| board[ele] == "X"})
        winner = "X"
        return "Congratulations X!"
      elsif(win_combo.all? {|ele| board[ele] == "O"})
        winner = "O"
        return "Congratulations O!"
      end
    end
  end
  return false
end

def full?(board)
  board.none? {|ele| ele == " "}
end

def draw?(board)
  if(full?(board))
    puts "Cat's Game!"
    return !won?(board)
  else
    return false
  end
end

def over?(board)
  if(draw?(board) || won?(board) || full?(board))
    return true
  else
    return false
  end
end

def winner(board)
  WIN_COMBINATIONS.each do |win_combo|
    if(win_combo.all? {|index| (position_taken?(board,index))})
      if(win_combo.all? {|ele| board[ele] == "X"})
        return "X"
      elsif(win_combo.all? {|ele| board[ele] == "O"})
        return "O"
      end
    end
  end
  return nil
end

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

def move(board, position, player)
  board[position] = player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

