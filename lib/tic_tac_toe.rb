
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
]

def get_new_board
    return [" ", " ", " ", " ", " ", " ", " ", " ", " "]
end

def full?(board)
    if board.include?(" ")
        return false
    else
        return true
    end
end

def won?(board)
    WIN_COMBINATIONS.each do |c|
        if board[c[0]] == " "
            next
        elsif board[c[0]] == board[c[1]] && board[c[0]] == board[c[2]]
            return c
        end
    end
    #no winning c was found
    return false
end

def draw?(board)
    if won?(board)
        return false
    end
    if full?(board)
        return true
    end
    return false
end

def over?(board)
    if full?(board) || draw?(board) || won?(board)
        return true
    else
        return false
    end
end

def winner(board)
    winner = won?(board) ? board[won?(board)[0]] : nil
    return winner
end

def display_board(str)
    puts " #{str[0]} | #{str[1]} | #{str[2]} "
    puts "-----------"
    puts " #{str[3]} | #{str[4]} | #{str[5]} "
    puts "-----------"
    puts " #{str[6]} | #{str[7]} | #{str[8]} "
end

def input_to_index(i)
    return i.to_i - 1
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(b, idx)
    answ = position_taken?(b, idx)
    if answ == nil || answ == true || idx < 0 || idx > 8
        return false
    else
        return true
    end
end

def move(b, idx, p)
    if valid_move?(b, idx)
        b[idx] = p
    else
        puts "Invalid move"
        return false
    end
    return b
end

def turn_count(b)
    return (9 - b.count(" "))
end

def turn(b)
    while true
        puts "Please enter your move as a position [1-9]"
        pos = input_to_index(gets.to_i)
        if move(b, pos, current_player(b)) == false
            puts "Invalid move :("
            next
        else
            display_board(b)
            break
        end
    end
end

def current_player(b)
    p = turn_count(b)%2 == 0 ? 'X' : 'O'
    return p
end

def play(b=get_new_board)
    while !over?(b)
        turn(b)
    end
    if draw?(b)
        puts "Cats Game!"
    else
        puts "Congratulations #{winner(b)}!"
    end
=begin
    puts "Play again? [Y/N]"
    res = gets
    #does ruby take res == ('x' || 'y' || 'z') ?
    if res == 'Y' || res == 'Yes' || res == 'yes' || res == 'y'
        play(get_new_board)
    end
=end
end
