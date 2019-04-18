WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,4,8],  [2,4,6], [0,3,6], [1,4,7], [2,5,8]]


# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " " || board[index] == "")
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, i)
  if i.between?(0,8) && (board[i] == "" || board[i] == " ")
    TRUE
  else
    FALSE
  end
end

def move(board,i,token)
  board[i]=token
end

def input_to_index(i)
  i = i.to_i
  i = i - 1
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space != "" && space != " "
      count += 1
    end
  end
  return count
end

def current_player(board)
  count = turn_count(board)
  count%2 == 0? "X" : "O"
end

def won?(board)
  win = FALSE
  x_pos = []
  o_pos = []
  
  for i in 0..8 do
    if board[i] == "X"
      x_pos << i
    elsif board[i] == "O"
      o_pos << i
    end
  end
  
  WIN_COMBINATIONS.each do |combo|
    if (x_pos.include?(combo[0]) && x_pos.include?(combo[1]) && x_pos.include?(combo[2]))
      win = TRUE
      return combo
    elsif (o_pos.include?(combo[0]) && o_pos.include?(combo[1]) && o_pos.include?(combo[2]))
      win = TRUE
      return combo
    end
  end
  return win
end

def full?(board)
  board.none? { |i| (i == " " || i == "") }
end

def draw?(board)
  if(full?(board) && won?(board).class != Array)
    return TRUE
  else
    return FALSE
  end
end

def over?(board)
  return (draw?(board) || won?(board).class == Array)
end

def winner(board)
  if won?(board).class == Array
    return board[won?(board)[0]]
  else
    return nil
  end
end

def turn(board)
  #if over?(board)
  #  if draw?(board)
  #    puts "Cat's Game!"
  #    return
  #  else
  #    puts "Congratulations #{winner(board)}!"
  #    return
  #  end
  #else
    token = current_player(board)
    puts "Please enter 1-9:"
    input = input_to_index(gets.chomp.strip)
    if valid_move?(board, input)
      move(board, input, token)
      display_board(board)
      return board
    else
      turn(board)
    end
  #end
end

def play(board)
  while !over?(board) do
    turn(board)
  end
  
  #if over?(board)
      if draw?(board)
        puts "Cat's Game!"
        return
      else
        puts "Congratulations #{winner(board)}!"
        return
      end
  #end
end