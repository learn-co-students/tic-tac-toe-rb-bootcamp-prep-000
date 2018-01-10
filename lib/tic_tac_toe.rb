WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [2,4,6],
  [0,3,6],
  [1,4,7],
  [2,5,8]
  ]
  
  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end
  
  def input_to_index(num)
    num.to_i - 1
  end
  
  def move(board,index,player)
    board[index] = player
  end
  
  def position_taken?(board,index)
    !(board[index] == " " || board[index].nil?)
  end
  
  def valid_move?(board,index)
    !position_taken?(board,index) && index.between?(0,8)
  end
  
  def turn(board)
    puts "Please choose a position (1-9)."
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(board,index) == true
      move(board,index,current_player(board))
    else valid_move?(board,index) == false
      puts "Sorry, that was an invalid move."
      turn(board)
    end
  end
  
  def turn_count(board)
    count = 0
    board.each do |player| 
      if player == "X" || player == "O" 
        count +=1
      end
    end
    count
  end
  
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end
  
  def won?(board)
    WIN_COMBINATIONS.find do |win_combo|
      board[win_combo[0]] == board[win_combo[1]] &&
      board[win_combo[0]] == board[win_combo[2]] &&
      position_taken?(board,win_combo[1])
    end
  end
  
  def full?(board)
    board.none? {|i| i == " " || i.nil?}
  end
  
  def draw?(board)
    won?(board) == nil && full?(board) == true
  end
  
  def over?(board)
    won?(board) != nil || draw?(board) == true
  end
  
  def winner(board)
    if won?(board) != nil
      board[won?(board)[0]]
    end
  end
  
def play(board)
  until over?(board) == true
    turn(board)
  end
  if draw?(board) == true
       puts "Cat's Game!"
  else won?(board)
     puts "Congratulations #{winner(board)}!"
   end
end