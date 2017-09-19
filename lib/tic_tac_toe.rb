def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(user_input)
  user_input.to_i - 1
end

# code your move and move method here!
def move(board, index,current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

# code your #valid_move? method here
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index,current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
    counter = 0
board.each do |spot|
    if spot != " "
        counter += 1
    end
end
return counter
end

def current_player(board)
    if turn_count(board) == 0
        return "X"
    elsif turn_count(board).even?
        return "X"
    elsif turn_count(board).odd?
        return "O"

    end

end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,4,8],  # Top-left diagonals
  [2,4,6],  # Top-right diagonals
  [0,3,6],  # left vertical
  [1,4,7],  # Middle vertical
  [2,5,8]  # Right vertical
]

def won?(board)
    falsy = false
    WIN_COMBINATIONS.each do |win|
        posw_1 = win[0];
        posw_2 = win[1];
        posw_3 = win[2];

        posb_1 = board[posw_1];
        posb_2 = board[posw_2];
        posb_3 = board[posw_3];

        if posb_1 == "X" && posb_2 == "X" && posb_3 == "X" || posb_1 == "O" && posb_2 == "O" && posb_3 == "O"
            wins = [posw_1,posw_2,posw_3]
            falsy = true
            return wins
        else
            falsy = false
    end
end
return falsy
end


def full?(board)
    board.all? do |pos|
        pos != " "
    end
end
# elsif won?(board) == false && full?(board) == false
#     return false
def draw?(board)
    won = won?(board)
    full = full?(board)
    if won == false && full
        return true
    elsif won == false && full == false
        return false
    end
end

def over?(board)
    if won?(board) || draw?(board)
        return true
    elsif full?(board) == false
        return false
    end
end

def winner(board)
    if won?(board) != false
        wins = []
        wins << won?(board)[0]
        wins << won?(board)[1]
        wins << won?(board)[2]
        win_X = ""
        win_O = ""
        if board[wins[0]] == "X"
            win_X = "X"
        elsif board[wins[0]] = "O"
            win_O = "O"
        end
        if win_X != ""
            return win_X
        elsif  win_O != ""
            return win_O
        end
    else
        return nil
    end
end

def play(board)
    until over?(board)
        turn(board)
    end
    if won?(board) != false
        puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
        puts "Cat's Game!"
    end
end
