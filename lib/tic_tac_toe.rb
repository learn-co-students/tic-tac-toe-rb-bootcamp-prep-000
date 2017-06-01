WIN_COMBINATIONS = [
  [0,1,2],[3,4,5],[6,7,8], #horizonatal wins
  [0,3,6],[1,4,7],[2,5,8], #verticle wins
  [0,4,8],[2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def turn(board)
  index = 0
  loop do
    puts "Please enter 1-9:"
    your_move = gets.strip
    index = input_to_index(your_move)
    break if valid_move?(board,index)
  end
  #valid_move?(board,index) == false ? turn(board) :
  move(board,index,current_player(board))
  display_board(board)
end

def input_to_index(your_move)
  your_move = your_move.to_i - 1
  your_move
end

def move(board,index,player)
  board[index]=player
end

def position_taken?(board,index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def play(board)
  #puts over?(board)
  while (!over?(board))
  # loop do
    turn(board)
    #  over?(board)
    # break if over?(board)
  end
  puts won?(board) ?  "Congratulations #{winner(board)}!" : "Cats Game!" # draw?(board) ?  "Cats Game!" :  ""
end

def won?(board)
      WIN_COMBINATIONS.chunk { |n| n.all?{|x| board[x] == "X"} || n.all?{|x| board[x] == "O"}}.detect{|win,ary|  win}
end

def draw?(board)
  (full?(board) && !won?(board))# .is_a(Array))
end

def over?(board)
  (draw?(board) || won?(board))
end

def winner(board)
  won?(board) ? board[won?(board)[1][0][1]] : nil
end

def full?(board)
  board.all?{|b| b != " "}
end

def turn_count(board)
  board.count{|turn| turn != " "}
end

def current_player(board)
  turn_count(board) %2 == 0 ? "X" : "O"
end
