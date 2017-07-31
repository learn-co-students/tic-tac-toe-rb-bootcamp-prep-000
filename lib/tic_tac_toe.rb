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
  count = 0
  while count < WIN_COMBINATIONS.length
    win_index_1 = WIN_COMBINATIONS[count][0];
    win_index_2 = WIN_COMBINATIONS[count][1];
    win_index_3 = WIN_COMBINATIONS[count][2];

    position_1 = board[win_index_1];
    position_2 = board[win_index_2];
    position_3 = board[win_index_3];

    if (position_1 == 'X' && position_2 == 'X' && position_3 == 'X') || (position_1 == 'O' && position_2 == 'O' && position_3 == 'O')
      return WIN_COMBINATIONS[count]
    else
      false
    end
    count += 1
  end
end

def full?(board)
  count = turn_count(board)
  if count == 9
    return true
  else
    return false
  end
end

def draw?(board)
  if full?(board) && !won?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  winner = won?(board)
  if winner.is_a?(Array)
    return board[winner[0]]
  else
    return winner
  end
end

def turn_count(board)
  count = 0
  board.each do |pos|
    if ((pos == "X") || (pos == "O"))
      count+=1
    end
  end
  return count
end


def current_player(board)
  count = turn_count(board)
  player = (count % 2 == 0)? 'X' : 'O'
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
    count = turn_count(board)

    if count % 2 == 0
      move(board, index, 'X')
    else
      move(board, index, 'O')
    end

    display_board(board)
  else
    puts "That's not a valid move"
    turn(board)
  end
end

# Define your play method below
def play(board)

  until over?(board)
    turn(board)
  end

  if won?(board)
    champ = winner(board)
    puts "Congratulations #{champ}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end
