
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
  WIN_COMBINATIONS.each do |i|
    if (position_taken?(board,i[0]))
      if (board[i[0]] == board[i[1]] && board[i[0]] == board[i[2]])
        return i
      end
    end
  end
  false
end

def full?(board)
  !board.include?(" ")
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  if won?(board) || draw?(board)
     return true
   else
     return false
   end
end

def winner(board)
  if line = won?(board)
    return board[line[0]]
  else return nil
  end
end

def turn_count(board)
  cnt = 0
  board.each{ |position|  position != " " ? cnt += 1 : "" }
  return cnt
end

def current_player(board)
  cnt = turn_count(board)
  cnt.even? ? "X" : "O"
end

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
  i = 1
  while (i <= 9) do
    if (!over?(board))   #This is completely uneeded, except to pass the tests. :-(
      turn(board)
    end
    if (won?(board))
      puts "Congratulations #{winner(board)}!"
      return
    elsif (draw?(board))
      puts "Cat's Game!"
      return
    end
    i += 1
  end
end
