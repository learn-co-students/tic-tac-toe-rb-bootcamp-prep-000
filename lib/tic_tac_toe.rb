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

def move(board, index, char)
    board[index] = char
    board
end

def position_taken?(board, index)
    board[index] != ' '
end

def position_taken?(board, index)
    board[index] != ' '
end

def valid_move?(board, index)
    !position_taken?(board, index) && index >= 0
end

def turn_count(board)
    i = 0

    board.each do |cell|
        if cell != " " && cell != ""
            i += 1
        end
    end

    return i
end

def current_player(board)

    if turn_count(board) % 2 == 0
        return 'X'
    else return 'O'

    end
end

def board_empty?(board)
    board.all? do |cell|
      cell.nil? || cell == ' '
    end
  end
  
def full?(board)
    board.none? do |cell|
      cell.nil? || cell == ' '
    end
end
  
def winning_combination(board)
    WIN_COMBINATIONS.find do |win_combination|
      win?(board, win_combination)
    end
end
  
def draw?(board)
    won?(board)
    full?(board) && winning_combination(board).nil?
end
  
def win?(board, win_combination)
    return false if board[win_combination[0]] == " "
  
    board[win_combination[0]] == board[win_combination[1]] && 
    board[win_combination[1]] == board[win_combination[2]]
end
  
def won?(board)
    return false if board_empty?(board)
  
    winning_combination(board)
end
  
def over?(board)
    won?(board) || draw?(board)
end
  
def winner(board)
    board[winning_combination(board)[0]] if won?(board) 
end

def turn(board)
    char = current_player(board)
    valid_move = false

    while !valid_move
        puts "Please enter 1-9:"
        input = gets.strip
        index = input_to_index(input)
    
        valid_move = valid_move?(board, index)
    end
    
    move(board, index, char)

    display_board(board)
end

def play(board)
    until over?(board)
        turn(board)
    end

    puts "Cat's Game!" if draw?(board)

    puts "Congratulations #{winner(board)}!" if winning_combination(board)

end