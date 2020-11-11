require 'pry'
WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
    (input.to_i) - 1
end

def move(board, index, token) #takes in argument of board,index, and token
    
    board[index] = token
    
end

def position_taken?(board, index)
    #binding.pry what is board?, what is index?
    #what do you expect to see when you put board[index]
board[index] == 'X' || board[index] == 'O'
end

def valid_move?(board, index)
    #look at WIN COUNT see what possible index's 
    #what method can find if a number is within a set of numbers
    #want to make sure the position is NOT taken so 
    #it's the oppisite of position_taken method
    (0..8).include?(index) && !position_taken?(board, index)
end

def turn_count(board)
   total_count = board.count("X") + board.count("O")
   #board.count { |token| token == 'X' || token == 'O' }
end

def current_player(board)
    #binding.pry check what turn_count(board) returns 
    #how to get a truthy value from a count (even or odd)
    turn_count(board).even? ? "X" : "O"
    #look at spec what is it expecting the output to be?
    #it's expecting it to be "X"
    
end

def turn(board)
    puts 'Please enter 1-9:'
    input = gets.strip
    index = input_to_index(input) #set index
    if valid_move?(board, index)
        move(board, index, current_player(board)) 
        #what method can tell us the current player
        display_board(board)
    else
        turn(board) #repeat process
    end
end

def won?(board)
    winning_combo = nil #nil will return falsey if not true
    WIN_COMBINATIONS.each do |combo|
        #combo = [0,1,2]
        #combo[0] = position 1 in the combo which is position 0 on the board
        #so instead of using board[index]
        #use board[combo[0]] same as board[index 1] and see if it's an X or O or " "
        #next combo it checks is [3,4,5] so combo[0] would be positiong 3 on the board
        if board[combo[0]] == "X" && board[combo[1]] == "X" && board[combo[2]] == "X" 
            winning_combo = combo
        elsif board[combo[0]] == "O" && board[combo[1]] == "O" && board[combo[2]] == "O"
            winning_combo = combo
        end
        
    end
    winning_combo
    # WIN_COMBINATIONS.find do |combo|
    #     #binding.pry
    #     #what is a board 
    #     #what is a combo
    #     #how do we find a boards index? board[index]
    #     #instead board[combo[0]]
        
    #     board[combo[0]] == board[combo[1]] && 
    #     board[combo[1]] == board[combo[2]] &&
    #     position_taken?(board, combo[0]) 
    #     #what method can we use that will return true if 
    #     #the position is taken
    #     #need this because "","","" would also equal a win without it
    #end
    
end

def full?(board)
    board.all? { |token| token == 'X' || token == 'O' }
    # !board.any?{|x| x == "" || x == " "}
end

def draw?(board)
    full?(board) && !won?(board)
end

def over?(board)
    draw?(board) || won?(board)
end

def winner(board)
    if won?(board)
        #if board[winning_index] = X show X otherwise show 0
        board[won?(board)[0]] == "X" ? "X" : "O"
        # combo for won? is [0,1,2] put is ther an "X"
      else
        nil
      end
    # if winning_combo = won?(board)
    #     board[winning_combo.first] 
        #X or O of first spot on board of winning combo
    #end
end

def play(board)
    until over?(board)
        turn(board)
        #until the game is over take a turn
    end
    if won?(board)
        puts "Congratulations #{winner(board)}!"
        #what return the winning token
    elsif draw?(board)
        puts "Cat's Game!"
    end
end
