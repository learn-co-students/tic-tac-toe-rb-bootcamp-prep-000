

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # 1st Diagonal
  [2,4,6]  # 2nd Diagonal
]

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    x_count = 0
    o_count = 0
    combination.each do |index|
      if position_taken?(board, index)
        if board[index] == 'X'
          x_count += 1
          if x_count == 3
            return combination
          end
        end
        if board[index] == 'O'
          o_count += 1
          if o_count == 3
            return combination
          end
        end
      end
    end
  end
  false
end

def full?(board)
  if board.all? {|i| i == "X" || i == "O"}
    true
  else
    false
  end
end

def draw?(board)
  if full?(board) && !(won?(board))
    true
  elsif
    false
  end
end

def over?(board)
  if full?(board) || draw?(board) || won?(board)
    true
  else
    false
  end
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    nil
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
  index = input.to_i - 1
  return index
end

def valid_move?(board, index)
  if !position_taken?(board, index)
    if index.between?(0,8)
      true
    end
  end
end

def position_taken?(board, index)
  board[index] != " "
end

def move(board, index, player)
    board[index] = player
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board,index)
    move(board,index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Define your play method below
def play(board)
  while !over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
end

def turn_count(board)
  count = 0
  board.each do |position|
    if (position != " ")
      count += 1
    end
  end
  return count
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end
