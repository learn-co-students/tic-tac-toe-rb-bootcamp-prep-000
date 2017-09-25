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



def turn_count(board)
  i = 0
  count = 0
  while i<=9
    if board[i]==="X"||board[i]==="O"
      count += 1
    end
  i+=1
  end
  return count
end

def current_player(board)
  if turn_count(board) % 2 === 0
    return "X"
  else
    return "O"
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets
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
  loop do
    if over?(board)
      if won?(board)
        winner = winner(board)
        puts "Congratulations #{winner}!"
      else
        puts "Cat's Game!"
      end
      break
    else
      turn(board)
    end
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    return true
  else
    return false
  end
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
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.each do |comb|
    #puts comb.display
    win_comb = comb
    if(board[comb[0]]===board[comb[1]]&&board[comb[0]]===board[comb[2]])&&(board[comb[0]] != " ")
      return win_comb
    end
  end
  return false
end

def full?(board)
  i = 0
  full = true
  while i < 10
    if board[i] === " "
      full = false
    end
    i += 1
  end
  return full
end

def draw?(board)
  if (full?(board) && !won?(board))
    return true
  else
    #board is not full
    return false
  end
end



def winner(board)
  if won?(board) === false
    return nil
  else
    return board[won?(board)[0]]
  end
end
