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
  winning_combination = []
  WIN_COMBINATIONS.each {|i|
    if board[i[0]] == "X" && board[i[1]] == "X" && board[i[2]] == "X"
      winning_combination.push(i[0], i[1], i[2])
    elsif board[i[0]] == "O" && board[i[1]] == "O" && board[i[2]] == "O"
      winning_combination.push(i[0], i[1], i[2])
    end
  }
  if winning_combination.empty?
    return false 
  else
    winning_combination
  end
end

def full?(board)
  if !board.include?(" ")
    true 
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board) == false
    nil
  else   
    board[won?(board)[0]]
  end
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end  

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end 

def input_to_index(input)
  index = (input.to_i) - 1
end

def move(board, index, current_player)
  board[index] = current_player
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
  board.each {|i| 
    if i == "X" || i == "O"
      count += 1
    end 
  }
  count
end

def current_player(board)
  if turn_count(board).odd?
    "O"
  else
    "X"
  end
end

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



