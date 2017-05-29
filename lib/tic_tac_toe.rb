#require 'display_board.rb'
def display_board(board)
    print " #{board[0]} | #{board[1]} | #{board[2]} \n"
    print  "-----------\n"
    print " #{board[3]} | #{board[4]} | #{board[5]} \n"
    print "-----------\n"
    print " #{board[6]} | #{board[7]} | #{board[8]} \n"
end



#require 'game_status.rb'
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2] ]

def board_empty?(board)
  board.all? { | position | position.strip.empty? }
end

def inprogress?(board)
  board.any? { | position | position.strip.empty? }
end

def won?(board)
  for i in 0..WIN_COMBINATIONS.length-1 do
    combo =  WIN_COMBINATIONS[i]
    one = combo[0]
    two = combo[1]
    three = combo[2]
    if (board[one]=="X"||board[one]=="O") &&  board[one]==board[two] && board[two] == board[three]
      return [one,two,three]
    end
  end
  return false
end

def full?(board)
   !inprogress? board
end

def draw?(board)
   if won?(board)
     return false
   elsif full? board
     return true
   end
   #if !won?(board) && full?(board)
     #puts "Cats Game!"
     #return true
   #elsif (won? board)
     #return false
   #end
end

def over?(board)

	if won?(board)
		puts "Congratulations #{winner board}!"
    return true
		exit
	elsif draw?(board)
	  puts "Cats Game!"
		return true
  else  !(inprogress? board)
	end
end

def winner(board)
  if won? board
    board[(won? board)[0]]
  else
    nil
  end
end



# require 'greeting.rb'
def greeting(name)
  puts "Hi! I'm HAL, what's your name?\nHello #{name}. It's nice to meet you."

end

#require 'play.rb'
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player )
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
    move(board, index, current_player(board))
    display_board(board)
  else
    turn board
  end
end

# Define your play method below
def play(board)
	while (!over? board) && (!won? board) do
    	  turn board
        draw? board
  end
end

#require 'position_taken.rb'
def position_taken?(board,index)
  #if board[index].strip.empty? || !board[index].nil?
  if board[index].nil? || board[index].strip.empty?
    return false
  else return true
end
end


#require 'valid_move.rb'
def valid_move?(board, index)
  if !position_taken?(board, index) && index.between?(0,8)
    true
  else
    false
  end
end


def position_taken?(board,index)
  #if board[index].strip.empty? || !board[index].nil?
  if board[index].nil? || board[index].strip.empty?
    false
  else true
  end
end

# require 'current_player.rb'
def turn_count(board)
  count = 9
  board.each do |position|
    if position.strip.empty?
       count -= 1
     end
  end
  count
end

def current_player(board)
  if turn_count(board).even?
    return "X"
  else
    return "O"
  end
end

 # play ([" ", " ", " ", " ", " ", " ", " ", " ", " "])
