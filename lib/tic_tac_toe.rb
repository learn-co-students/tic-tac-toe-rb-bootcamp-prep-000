WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
return input.to_i - 1
end

def move(board, input, char)
  board[input] = char
  return board
end

def position_taken?(board, index)
  if board[index] == " " || board[index] == "" || board[index] == nil
    false
  else
    true
  end
end

def valid_move?(board, index)
  #index -= 1
  if index.between?(0,8) && !position_taken?(board, index)
    true
  else
    false
  end
end

def turn(board)
  while true
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
    break if valid_move?(board,index)
  end
  player = current_player(board)
  move(board,index,player)
  display_board(board)
end

def turn_count(board)
  turns = board.select {|x| x == "X" || x == "O"}
  turns.size
end

def current_player(board)
  return "X" if turn_count(board)%2 == 0
  "O"
end

def won?(board)
  ["X","O"].each do |x|
    WIN_COMBINATIONS.each do |combo|
      if board[combo[0]] == x
        if board[combo[1]] == x
          if board[combo[2]] == x
            return combo
          end
        end
      end
    end
  end
  nil
end

def full?(board)
  board.all? {|a| a == "X" || a == "O"}
end

def draw?(board) #changed this to inefficient code to pass rspec, strange requirement "calling won?(board)" that does not pass if "!won?(board)" is expressed
  if won?(board)
    return false
  elsif full?(board)
    return true
  end
false
end

def over?(board)
  if draw?(board) || won?(board)
    true
  end
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if winner(board)
    puts "Congratulations " + winner(board) + "!"
  else
    puts "Cats Game!"
  end
end