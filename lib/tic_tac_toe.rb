WIN_COMBINATIONS=[
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6],
]
def won?(board)
  oplayer = board.each_index.select{|i| board[i] == 'O'}
  xplayer = board.each_index.select{|i| board[i] == 'X'}
  WIN_COMBINATIONS.find{|winningMove| (winningMove- oplayer).empty?|| (winningMove-xplayer).empty?}
end
 def full?(board)
  board.find{|e| e!='X' && e !="O"}.nil?
end
 def draw?(board)
  (won?(board).nil?) && full?(board)
end
def over?(board)
  (!won?(board).nil?) || draw?(board) || full?(board)
end
def winner(board)
  winningmove = won?(board)
  !winningmove.nil? ? board[winningmove[0]] : nil
end
def turn_count(board)
  count =0
  for element in board
    if element != '' && element != " "
      count += 1
    end
  end
  count
end
 def current_player(board)
  turn_count(board)%2==1?'O':'X'
end 
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
def player_move(board,index,char="X")
  board[index]=char
end
def position_taken?(board,index)
  board[index] == "O" || board[index] =="X"
end
def valid_move?(board,index)
  !position_taken?(board,index) && index >=0 && index <= 9
end
def turn (board)
  puts "Please enter 1-9:"
  input = gets.strip()
  index = input_to_index(input)
  until valid_move?(board,index)
    puts "Please enter 1-9:"
    input = gets.strip()
    index = input_to_index(input)
  end
end
  
