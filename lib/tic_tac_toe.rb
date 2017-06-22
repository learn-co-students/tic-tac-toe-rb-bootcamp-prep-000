
WIN_COMBINATIONS = [
    [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]
]



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

def move(board, position, player)
    board[position] = player
end

def position_taken?(board, position)
    board[position] == "X" || board[position] == "O"
end

def valid_move?(board, position)
    position.between?(0,8) && !position_taken?(board, position)
end

def turn(board)
    puts "Select a position between 1-9"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end

def turn_count(board)
    count = 0
    board.each do |char|
        if (char == "X" || char == 'O')
            count += 1
        end
    end
    count
end

def current_player(board)
    (turn_count(board) % 2 == 0)? "X" : "O"
end

def won?(board)
    x_positions = positions(board, 'X')
    o_positions = positions(board, 'O')
    x_winner = winning_combination(board, x_positions)
    o_winner = winning_combination(board, o_positions)
    (x_winner)? x_positions : (o_winner)? o_positions : nil
end

def full?(board)
    full_board?(board) && !won?(board)
end

def draw?(board)
    full?(board)
end

def over?(board)
    draw?(board) || won?(board)
end

def winner(board)
    (winning_combination(board, positions(board, "X")))? "X" :
    (winning_combination(board, positions(board, "O")))? "O" : nil
end

def play(board)
    until over?(board)
        turn(board)
    end
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    else
        puts "Cats Game!"
    end
end

# helper methods
def full_board?(board)
    board.all? do |char|
        char == "X" || char == "O"
    end
end

def winning_combination(board, positions)
    WIN_COMBINATIONS.any? do |combination|
        combination.all? do |val|
            positions.include?(val)
        end
    end
end

def positions(board, char)
    positions = []
    board.each_with_index do |val, index|
        if val == char
            positions.push(index)
        end
    end
    positions
end
