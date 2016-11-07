WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def turn_count(board)
  counter = 0
  board.each do |x|
    if x == "X" || x == "O"
      counter +=1
    end
  end
  counter
end

def current_player(board)
  player = turn_count(board) % 2
  if player == 1
    "O"
  else
    "X"
  end
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

def move(board, index, current_play)
  board[index] = current_play
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


#EVALUATIONS

def won?(board)
  won = false
  combo_counter = -1
  WIN_COMBINATIONS.each do |combo|
      arr = []
      combo_counter += 1
      combo.each { |x| arr.push(board[x])}
      if arr.all? {|m| m == "O" }
        return WIN_COMBINATIONS[combo_counter]
      elsif arr.all? {|m| m == "X" }
        return WIN_COMBINATIONS[combo_counter]
      else
        won = false
      end
  end
  return won
end

def full? (board)
   board.none? {|x| x == " "}
end

def draw? (board)
  
  won? (board)
  if full?(board) && !(won?(board))
    true
  else
    false
  end
end

def over? (board)
  if !(draw?(board)) && !(won?(board))
    false
  else
    true
  end
end

def winner (board)
  if won? (board)
    arr = won?(board)
    winning_player = board[arr[0]]
  else
    nil
  end
end

def play (board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
