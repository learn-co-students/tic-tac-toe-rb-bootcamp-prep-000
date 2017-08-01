
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
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  index = input.to_i-1
end

def move(array, index, value)
  array[index]=value
end

def valid_move?(board, index)
  if(index.between?(0, 8))
    !position_taken?(board,index)
  else
    false
  end
end

def position_taken?(board,index)

  if((board[index]==" ") || (board[index]=="") || (board[index]==nil))
    false
  else
    true
  end
end

def turn(board)

  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  if valid_move?(board, index)
    move(board,index,current_player(board))
    display_board(board)
  else
      turn(board)
  end

end

def turn_count(board)
  counter = 0
  board.each do |element|
    if element =="X" || element == "O"
      counter +=1
    end
  end
  counter
end

def current_player(board)
  turn_count(board)%2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 =="X" && position_2 =="X" && position_3 == "X"
      return win_combination
    end

    if position_1 =="O" && position_2 =="O" && position_3 == "O"
      return win_combination
    end

  end
  false
end

def full?(board)
  board.each do |element|
    if element ==" " || element==nil
      return false
    end
  end
  true
end

def draw?(board)

  if won?(board)==false && full?(board)==true
    return true
    # draw case
  else
  return false
  # won case & in-progress case
  end
end

def over?(board)
  if !won?(board)==false || draw?(board)==true
    return true
  # draw case & won case
  else
  return false
  end


end

def winner(board)
  if !won?(board)==false
      return board[won?(board)[0]]
  end
  return nil
end

def play(board)

    until over?(board) do
    turn(board)
    end

    if !!won?(board) == true
      puts("Congratulations #{winner(board)}!")
    else
      puts("Cats Game!")
    end

end
