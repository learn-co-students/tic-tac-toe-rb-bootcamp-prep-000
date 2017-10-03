# define winning winning combinations
WIN_COMBINATIONS = [
   [0,1,2],
   [3,4,5],
   [6,7,8],
   [0,3,6],
   [1,4,7],
   [2,5,8],
   [0,4,8],
   [6,4,2]
]

def play(board)

end

def display_board(board)
   puts
   puts " #{board[0]} | #{board[1]} | #{board[2]} "
   puts "-----------"
   puts " #{board[3]} | #{board[4]} | #{board[5]} "
   puts "-----------"
   puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def position_taken?(board, position)
    # if turn_count(board) % 2 == 0
    #     return "X"
    # else
    #     return "O"
    # end
    if valid_move(board, position)
        true
    else
        false
    end
end

def valid_move?(board, position)
    # position.between?(0,8) && !position_taken?(board, position)
    if position < 0 || board[position] == "X" || board[position] == "O" || position > 8
        false
    else
        true
    end
end

def input_to_index(input)
   input.to_i - 1
end

def move(board, position, player)
    board[position] = player
end

def turn(board)
    puts "Please enter 1-9:"
    move = gets.strip

    int = input_to_index(move)

    if valid_move?(board, int)
        move(board, int, "X")
        display_board(board)
    else
        puts "Please enter 1-9:"
        move = gets.strip
        int = input_to_index(move)
    end
end

def turn_count(board)
    counter = 0
    board.each do |current|
        if current == "X" || current == "O"
            counter += 1
        end
    end
    return counter
end

def won?(board)

end

def current_player(board)
    if turn_count(board) % 2 == 0
        return "X"
    else
        return "O"
    end
end

def full?(board)

end

def draw?(board)

end

def over?(board)

end

def winner(board)

end
