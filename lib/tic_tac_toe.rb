WIN_COMBINATIONS=[
    [0,1,2], #Top row
    [3,4,5], #Middle
    [6,7,8], #Bottom
    [0,4,8], #diagonal Top left
    [0,3,6], #horizontal row 1
    [1,4,7], #horizontal row 2
    [2,5,8], #horizontal row 3
    [2,4,6]  #diagonal top right
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

def move(board, index, token)
        board[index]=token
end

def position_taken?(board, index)
    !(board[index].nil? || board[index]==' ')
end

def valid_move?(board,position)
    !position_taken?(board,position)  && position.between?(0,8)
end

def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    token= current_player(board)
    if valid_move?(board, index)
      move(board, index, token)
      display_board(board)
    else
      turn(board)
    end
end

def turn_count(board)
    turns=0
    board.each do |boards|
        if boards=='X' || boards =='O'
            turns+= 1
        end
    end
    return turns
end

def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"

end

def won?(board)
    WIN_COMBINATIONS.detect do |win_combination|
    combo_1 = win_combination[0]
    combo_2 = win_combination[1]
    combo_3 = win_combination[2]

    position_1 = board[combo_1] # load the value of the board at combo_1
    position_2 = board[combo_2] # load the value of the board at combo_2
    position_3 = board[combo_3] # load the value of the board at combo_3

    if position_1=="X" && position_2 =="X" && position_3== "X"
        return win_combination
    elsif position_1=="O" && position_2 =="O" && position_3== "O"
        return win_combination
    else
        false
    end
end

end

def full?(board)
    board.all? {|occupied| !(occupied.nil? || occupied == " ")}
end

def draw?(board)
      !won?(board) && full?(board)
end

def over?(board)
    full?(board) || won?(board) || draw?(board)
end

def winner(board)
    if won?(board)
        winning_player=won?(board).first
        return board[winning_player]
    end
end

def play(board)
    until over?(board)
        turn(board)
    end

    if won?(board)
        puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
        puts "Cats Game!"
    end
end
