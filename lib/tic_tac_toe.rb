
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6],  # Left column
  [1,4,7],  # Middle column
  [2,5,8],  # Right row
  [0,4,8],  # First diagonal
  [2,4,6]  # Second diagonal
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(index)
  index = index.to_i
  index = index - 1
end

def move(array, index, player)

  array[index] = player
end

def position_taken?(board,index)
  if board[index] == "X" || board[index] == "O"
    true
  else
    if board[index] == "" || board[index] == " " || board[index] == nil
      false
    end
  end
end

def valid_move?(board,index)
  if position_taken?(board,index)
    false
  else
    if index.between?(0, 8)
      true
    end
  end
end

def turn(board)
  player = "X"
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board,index)
    move(board, index, player)
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |turn_number|
    if turn_number == "X" || turn_number =="O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  position = Array.new(3)
  if board.all?{|i| i == "" || i == " "}
    false
  else WIN_COMBINATIONS.each do |win_combination|
      i=0
      while i <3
        position[i] = board[win_combination[i]]
        i +=1
      end

      if position.all?{|value| value == "X"}
        return win_combination # return the win_combination indexes that won.
      else
        if position.all?{|value| value == "O"}
          return win_combination
        end
      end
    end
  end
  false
end

def full?(board)
  if board.all?{|i| i == "X" || i == "O"}
    true
  else
    false
  end
end

def draw?(board)
  if full?(board)
    if won?(board)
      false
    else
      true
    end
  end
end

def over?(board)
  if draw?(board) || full?(board) || won?(board) != false
    true
  else
    false
  end
end

def winner(board)
  if won?(board) == false
    nil
  else
    if board[won?(board)[0]] == "X"
      "X"
    else
      "O"
    end
  end

end

def play(board)
  while !over?(board)
    puts "Please enter 1-9"
    input = gets
    index = input_to_index(input)
    move(board, index, current_player(board))
    display_board(board)
  end
  if won?(board) != false
    puts "Congratulations #{winner(board)}!"
  else
    if draw?(board)
      puts "Cats Game!"
    end
  end
end
