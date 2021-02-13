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
    index = input.to_i
    index -= 1
    index 
  end
  
  def move(board, index, token)
    board[index] = token
  end
  
  def position_taken?(board, index)
    if board[index] == " " || board[index] == nil
      return false
    else 
      return true
    end
  end
  
  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end
  
  def turn_count(board)
    counter = 0
    i = 0
    9.times do
      if position_taken?(board, i)
        counter += 1
      end
      i += 1
    end
    counter
  end
  
  def current_player(board)
    if turn_count(board).even?
      return "X"
    else 
      return "O"
    end
  end
  
  def turn(board)
    puts "Put in a number between 1 - 9"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
    else 
      puts "invalid move, please put in a valid move"
      turn(board)
    end
    display_board(board)
  end
  
  def won?(board)
    WIN_COMBINATIONS.detect do |combo|
      board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && position_taken?(board, combo[0])
    end
  end
  
  def full?(board)
    board.all? do |token|
      token == "X" || token == "O"
    end
  end
  
  def draw?(board)
    full?(board) && !won?(board)
  end 
  
  def over?(board)
    draw?(board) || won?(board)
  end
  
  def winner(board)
    if draw?(board) || !over?(board)
      return nil
    else 
      combo = won?(board)
      winning_token = board[combo[0]]
      return winning_token
    end 
  end
  
  def play(board)
  turn(board) until over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
  
  