WIN_COMBINATIONS = [
  [0,1,2],  #top row
  [3,4,5],  #mid row
  [6,7,8],  #bot row
  [0,3,6],  #left col
  [1,4,7],  #mid col
  [2,5,8],  #right col
  [0,4,8],  #left dig
  [2,4,6]   #right dig
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board,pos,char)
  board[pos] = char
end

def position_taken?(board, pos)
  if board[pos] == 'O' || board[pos] == 'X'
    return true
  end
  false
end

def valid_move?(board, index)
  ((0..8).include?(index)) && (not position_taken?(board, index))
end

def turn(board)
  puts "Please enter position:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    player = current_player(board)
    move(board,index,player)
    display_board(board)
  else
    puts "Invalid number entered"
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |slot|
    if (slot == "X") || (slot == "O")
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_number = turn_count(board)
  return turn_number % 2 == 0 ? 'X' : 'O'
end

def won?(board)
  WIN_COMBINATIONS.each do |combo|
    if position_taken?(board,combo[0]) && board[combo[0]]==board[combo[1]] && board[combo[1]]==board[combo[2]]
      return combo
    end
  end
  return false
end

def full?(board)
  (0..8).all? { |e| position_taken?(board,e) }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board) || full?(board)
end

def winner(board)
  if won?(board)
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
