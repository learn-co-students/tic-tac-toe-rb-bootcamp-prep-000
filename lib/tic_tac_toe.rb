WIN_COMBINATIONS = [
    [0, 1, 2], #top horizontal row
    [3, 4, 5], #middle horizontal row
    [6, 7, 8], #bottom horizontal row
    [0, 3, 6], #left vertical column
    [1, 4, 7], #middle vertical column
    [2, 5, 8], #right vertical column
    [0, 4, 8], #diagonal top-left to bottom-right
    [2, 4, 6]  #diagonal top-right to bottom-left
]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
    input.to_i - 1
end

def move(board, position, character)
    board[position] = character
end

def position_taken? board, index
    if(board[index] == " " || board[index] == nil || board[index] == "")
        false
    else
        true
    end
end

def valid_move? board, index
    if(!position_taken?(board, index) && index.between?(0, 8))
        true
    else
        false
    end
end

def turn_count board
    number_of_turns = 0
    board.each do |board| 
        if board != " "
            number_of_turns += 1
        end
    end
    return number_of_turns
end

def current_player board
    if turn_count(board) % 2 == 0
        "X"
    else 
        "O"
    end
end

def turn board
    counter = 0

    until counter == 1
    
        puts "Please enter 1-9:"
        input = gets.strip
        index = input_to_index(input)
        if valid_move? board, index
            move board, index, current_player(board)
            counter += 1
        else    
        end
    end
    display_board board
end

def won? board
    WIN_COMBINATIONS.find do |wincombo|
        position_taken?(board, wincombo[0]) &&
        board[wincombo[0]] == board[wincombo[1]] &&
        board[wincombo[1]] == board[wincombo[2]] 
    end
end

def full? board
    board.none?{|board| board == " "}
end

def draw? board
    full?(board) && !won?(board)    
end

def over? board
    full?(board) || won?(board) || draw?(board)
end

def winner board
    wincombo = won?(board)
    if(wincombo == nil)
        return nil
    elsif(board[wincombo[0]] == "X")
        return "X"
    else
        return "O"
    end
end

def play board
    until over?(board)
        turn(board)
    end

    if(won?(board))
        if(winner(board) == "X")
            puts "Congratulations X!"
        else
            puts "Congratulations O!"
        end
    else
        puts "Cat's Game!"
    end
end