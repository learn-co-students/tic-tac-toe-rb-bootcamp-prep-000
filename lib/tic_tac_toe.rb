require_relative '../lib/tic_tac_toe.rb'
WIN_COMBINATIONS=[
[0,1,2],
[0,3,6],
[0,4,8],
[1,4,7],
[2,5,8],
[2,4,6],
[3,4,5],
[6,7,8]
]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(board, index, current_player)
    board[index] = current_player
  end

  def position_taken?(board, location)
    board[location] != " " && board[location] != ""
  end

  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end

  def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index,current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end
  def turn_count(board)
    board.count {|x| x=="X" || x=="O"}
  end

  def current_player(board)
   turn_count(board) % 2 == 0? "X" : "O"
  end
  def won?(board)
    WIN_COMBINATIONS.detect do|win_combo|
      index1=win_combo[0]
      index2=win_combo[1]
      index3=win_combo[2]
      win1=board[index1]
      win2=board[index2]
      win3=board[index3]
    if win1=="X" && win2=="X" && win3=="X"
      return win_combo
    elsif win1=="O" && win2=="O" && win3=="O"
      return win_combo
    else
      false
   end
   end
  end
  def full?(board)
    board.all? do |value|
      if value=="X" || value=="O"
        true
      else
        false
      end
    end
  end
  def draw?(board)
    if !won?(board) && full?(board)
      return true

    end
  end
  def over?(board)
    if won?(board) || full?(board) || draw?(board)
      return true
    else
      false
    end
  end

  def winner(board)
    if win_combo=won?(board)
    return board[win_combo[0]]
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
 else
    puts "Cat's Game!"
  end
end
end
