
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],
[0,4,8],[2,4,6]]
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def valid_move?(board , index)
	if board[index] == "X"  || board[index] == "O"
		return false			
	elsif index >= 0 && index <= 8
		return true
	elsif  index < 0 || index > 8
		return false
	else
			



	#elsif board[index] == " " || board[index] == "X"
			#return nil

		return false

		
	end
end

# re-define your #position_taken? method here, so that you can use it in the #valid_move? method above.
def position_taken?(board, index)
 if board[index] == " "
return false
elsif board[index] == ""
	return false
elsif board[index] == nil
	return false
else
	return true
end
	 end
	 def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end



def won?(board)

WIN_COMBINATIONS.each do |win_combination|

	win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    
    
 	 
  position_1 = board[win_index_1] 
  position_2 = board[win_index_2]
  position_3 = board[win_index_3] # load the value of the board at win_index_3
  
  
  

  			if 		position_1 == "X" && 
  					position_2 == "X" &&
  				    position_3 == "X" 
  				    
		  		 	
    	return win_combination
    	
    elsif           position_1 == "O" && 
  					position_2 == "O" &&
  				    position_3 == "O" 
    	  	  return win_combination 
    	  	  
    	  	else false
		end
	end
		
	
		if position_taken?(board, 0)
			return false
		

		end
end

def full?(board)
	if position_taken?(board, 8)
	return true
else return false
	#else  return draw?(board)
		
	end
end


def draw?(board)
	
 if !won?(board) && full?(board)
 	return true
 elsif !won?(board) || !full?(board)
 	return false
 else return nil
 	
 end

end

def over?(board)
	if won?(board) 
	return true
elsif draw?(board)
	return true
elsif full?(board)
	return true
else return false
		
		
	end
end

def winner(board)
  position = []
  position = won?(board)
  if !won?(board)
  	return nil
elsif board[position[2]] == "X"
      return "X" 
     
  else return "O"
  
      	end
      	
	end


def input_to_index(user_input)
	actual_input = user_input.to_i - 1
end

def move(board, actual_input, typedin)
 
 	board[actual_input] = typedin

 end


	 def turn(board)
 			#puts "Please enter 1-9:"
 			
 			#move(board, actual_input, typedin)
			user_input = gets.chomp
 		 actual_input = input_to_index(user_input)
 		 

 		
	if !valid_move?(board,actual_input)
		 return  user_input = gets.chomp
		 puts "Please enter 1-9:"
		  #move(board, actual_input)
		#display_board(board)
		elsif valid_move?(board,actual_input) && current_player(board) == "X"
			return board[actual_input] = "X"
		else board[actual_input] = "O"
		 #turn(board)
		
		end
	end


def turn_count(board)
	turns = 0
	
board.each do |occupied|
	
				if occupied == "X" || occupied == "O"
					 turns += 1
			
				end
			end
    return turns
end


def current_player(board)
turns = turn_count(board) 

if turns % 2 == 0
	return "X"
else
	return "O"
end
end
 

 def play(board)

while draw?(board) == true && full?(board)
 	return   puts "Cat's Game!"
	 end
until over?(board) == true 
		
turn(board)

	end

if won?(board)  && (winner(board) == "X"|| winner(board) == "O")
	return puts "Congratulations #{winner(board)}!"

end
end
