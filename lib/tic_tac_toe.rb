def position_taken?(board, index)
    !(board[index].nil? || board[index] == " ")
end

# --------------------- Game state ---------------------
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

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    cells = []
    win_combination.each do |cell|
      cells << board[cell]
    end
    x_win = cells.all? { |index| index == "X" }
    o_win = cells.all? { |index| index == "O" }
    if x_win || o_win
      return win_combination
    end
  end
  return false
end

def full?(board)
    board.all? {|cell| cell == "X" || cell == "O" }
end

def draw?(board)
    full?(board) && !won?(board)
end

def over?(board)
    draw?(board) || won?(board)
end

def winner(board)
    win_combination = won?(board)
    win_combination != false ? board[win_combination[0]] : nil
end

def turn_count(board)
    turn = 0
    board.each do |index|
        if index != " " && index != ""
            turn += 1
        end
    end
    turn
end

def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
end

# --------------------- Set up ---------------------

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

def move(board, index, current_player)
    if !(current_player != "X" && current_player != "O") 
        board[index] = current_player 
    else
        ArgumentError
    end
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
    current_player = current_player(board)
    if valid_move?(board, index)
        move(board, index, current_player)
        display_board(board)
    else
        turn(board)
    end
end

# --------------------- Define your play method below ---------------------
def play(board)
    while over?(board) == false
        turn(board)
    end
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    else
        puts "Cat's Game!"
    end
end