WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i-1
end

def move(board,index,player)
  board[index]=player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board,index)
  !position_taken?(board,index) if index.between?(0,8)
end

def turn(board)
  loop do
    puts "Please enter 1-9:"
    index=input_to_index(gets.strip)
    if valid_move?(board,index)
      move(board,index,current_player(board))
      display_board(board)
      break
    end
  end
end

def turn_count(board)
  board.count { |content| content=="X" || content=="O" }
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    return combination if combination.all? {|i| board[i]=="X"}
    return combination if combination.all? {|i| board[i]=="O"}
  end
  false
end

def full?(board)
  board.none? {|c| c==" "}
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  won=won?(board)
  return board[won[0]] if won
end

def play(board)
  turn(board) until over?(board)
  puts won?(board) ? "Congratulations #{winner(board)}!" : "Cat's Game!"
end
