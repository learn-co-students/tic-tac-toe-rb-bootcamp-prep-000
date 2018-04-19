
puts "Welcome to Tic Tac Toe!"

def display_board (board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index (user_input)
    (user_input.to_i - 1)
end


def move (board, index, character)
    board[index] = character
end

def valid_move? (board, index)
    if ((position_taken?(board, index)) == false) && (index >= 0 && index <= 8)
        return true
        elsif (position_taken?(board, index)) == true
        return false
        elsif index > 8 || index < 0
        return false
    end
end

def position_taken? (board, index)
    if board[index] == " " || board[index] == "" || board[index] == nil
        return false
        elsif board[index] == "X" || board[index] == "O"
        return true
    end
end

def turn(board)
    puts "Please enter 1-9:"
    input_user = gets.strip
    index = input_to_index(input_user)
    if current_player(board) == "X"
        character = "X"
    elsif current_player(board) == "O"
        character = "O"
    end
    if valid_move?(board, index)
        move(board, index, character)
    else
        puts "Please enter 1-9:"
        input_user = gets.strip
        index = input_to_index(input_user)
        if current_player(board) == "X"
            character = "X"
            elsif current_player(board) == "O"
            character = "O"
        end
    end
    display_board(board)
end

def turn_count(board)
    count = 0
    board.each do |index|
        count += 1 if index == "X" || index == "O"
        #binding.pry
    end
    count
end

def current_player (board)
    turn_number = turn_count(board)
    if turn_number.odd? == false
        return "X"
    else
        return "O"
    end
end

def play(board)
    until over?(board)
        turn(board)
    end
    if winner(board) == "X"
        puts "Congratulations X!"
    elsif winner(board) == "O"
        puts "Congratulations O!"
    elsif draw?(board)
        puts "Cat's Game!"
    end
end

def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
[0,1,2],
[3,4,5],
[6,7,8],
[0,3,6],
[1,4,7],
[0,4,8],
[2,4,6],
[2,5,8]
]

def won? (board)
    WIN_COMBINATIONS.each do |combination|
        win_index_1 = combination[0]
        win_index_2 = combination[1]
        win_index_3 = combination[2]

        position_1 = board[win_index_1]
        position_2 = board[win_index_2]
        position_3 = board[win_index_3]

        if position_1 == "X" && position_2 == "X" && position_3 == "X"
            return combination
            elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
            return combination
            else
            false
        end
    end
    false
end

def full? (board)
    board.all? {|element| element == "O" || element == "X"}
end

def draw? (board)
    if !won?(board) && full?(board)
        return true
        else
        false
    end
end

def over?(board)
    if won?(board) || draw?(board) || full?(board)
        true
    else
        false
    end
end

def winner (board)
    if won?(board)
        #binding.pry
        letter = won?(board)
        if board[letter[0]] == "X"
            return "X"
            elsif board[letter[0]] == "O"
            return "O"
            else
            return "nil"
            #binding.pry
        end
    end
end
