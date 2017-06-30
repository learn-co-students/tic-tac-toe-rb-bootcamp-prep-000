#
require "pry"

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

def display_board(brd)
  puts " #{brd[0]} | #{brd[1]} | #{brd[2]} "
  puts "-----------"
  puts " #{brd[3]} | #{brd[4]} | #{brd[5]} "
  puts "-----------"
  puts " #{brd[6]} | #{brd[7]} | #{brd[8]} "
end

def input_to_index(x)
  x = x.to_i - 1
end

def m(board,index,character)
  board[index] = character
end

def valid_move?(board, index)
  if (index < 0 || index > 8)
    return false
  elsif (position_taken?(board,index))
    return false
  else
    return true
  end
end

def position_taken?(board,index)
  if (board[index] == " " || board[index] == "" || board[index] == nil)
    return false
  else
    return true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  inp = gets.strip
  index = input_to_index(inp)
  if (valid_move?(board,index))
    m(board,index,current_player(board))
    display_board(board)
    return true
  else
    binding.pry
    turn(board)
  end
end

def turn_count(board)
  empty = board.select {|entry| entry.include? " "}
  return (9 - empty.length)
end

def current_player(board)
  x = turn_count(board)
  if (x.odd?)
    return "O"
  else
    return "X"
  end
end
#board = [" ","X"," "," "," "," "," "," "," ",]

def won?(board)
  x_plays = []
  o_plays = []
  counter = 0
  board.each do |play|
    if (play.include? "X")
      x_plays << counter
    elsif (play.include? "O")
      o_plays << counter
    end
    counter = counter + 1
  end

  WIN_COMBINATIONS.each do |win|
    if  (x_plays.detect {|play| play == win[0]}) && (x_plays.detect {|play| play == win[1]}) && (x_plays.detect {|play| play == win[2]})
      return win
    elsif  (o_plays.detect {|play| play == win[0]}) && (o_plays.detect {|play| play == win[1]}) && (o_plays.detect {|play| play == win[2]})
      return win
    end
  end
#  puts "x_plays #{x_plays}"
#  puts "o_plays #{o_plays}"
  return false
end

def full?(board)
  if (board.detect{|i| i.include?(" ")})
    return false
  else
    return true
  end
end

def draw?(board)
  if (full?(board) && (!won?(board)))
    return true
  else
    return false
  end
end

def over?(board)
  if (draw?(board))
    return true
  elsif (won?(board))
    return true
  else
    return false
  end
end

def winner(board)
  i = won?(board)
  if (i)
    return board[i[0]]
  end
end

def play(board)
  while (!over?(board))
    turn(board)
  end
  if (draw?(board))
    puts "Cats Game!"
    return
  elsif (won?(board))
      puts "Congratulations Player ${board[won?(board)}"
      return
  else
    turn(board)
  end
end
