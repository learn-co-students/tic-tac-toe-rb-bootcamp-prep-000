def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input) input.to_i-1 end

def move(board, index, player) board[index] = player end

def position_taken?(board, index) !(board[index].nil? || board[index] == " ") end

def valid_move?(board, n) (0..8).include?(n) && board[n] == " " end

WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

def won?(board)
  WIN_COMBINATIONS.each do |x|
    return x if x.all? { |y| board[y] == "X" }
    return x if x.all? { |y| board[y] == "O" }
  end
  false
end

def full?(board) board.count(" ") == 0 end

def draw?(board) !(won?(board)) && full?(board) end

def over?(board) won?(board) || full?(board) || draw?(board) end

def winner(board) won?(board) == false ? nil : board[won?(board)[0]] end

def turn_count(board) 9-board.count(" ") end

def current_player(board) turn_count(board) % 2 == 0 ? "X" : "O" end

def turn(board)

  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)

  until valid_move?(board,index)
    puts "That's not a valid number, please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end

  move(board,index,current_player(board))
  display_board(board)

end

def play(board)

  turn(board) until over?(board)
  puts won?(board) == false ? "Cats Game!" : "Congratulations #{winner(board)}!"

end
