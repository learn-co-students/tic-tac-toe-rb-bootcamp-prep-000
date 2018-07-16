def display_board(gameBoard)
    puts " #{gameBoard[0]} | #{gameBoard[1]} | #{gameBoard[2]} "
    puts "-----------"
    puts " #{gameBoard[3]} | #{gameBoard[4]} | #{gameBoard[5]} "
    puts "-----------"
    puts " #{gameBoard[6]} | #{gameBoard[7]} | #{gameBoard[8]} "
end

def input_to_index()
    puts "Where would you like to go?"
    puts "Please enter a number from 1 through 9"
    index = gets.strip.chomp.to_i - 1 
    if index < 0  or index > 8
        puts "You must enter a number from 1 through 9!"
        input_to_index()
    end
    return index
end

def update_array_with(gameBoard, symbol)
    num = input_to_index()
    gameBoard[num] = symbol
end

def start_game()
    puts "Welcome to Tic-Tac-Toe!"
    gameBoard = [" "," "," "," "," "," "," "," "," "]
    display_board(gameBoard)
    $empty = 9
    $symbols = ["x", "O"]
    $order = 0 
    $symbol = $symbols[$order]    
    $game_playing = true

    while $game_playing
        play_game(gameBoard, $symbol)
        puts "\n"
        puts "\n" 
    end 
end

def play_game(gameBoard, symbol)
    index = input_to_index()
    if gameBoard[index] == ' '
        gameBoard[index] = symbol 
        $order = ($order + 1) % 2
        display_board(gameBoard)
        $empty -= 1
        check_game_playing(gameBoard, symbol)
        $symbol = $symbols[$order]
    else
        puts "The slot is already taken!"
        play_game(gameBoard, symbol)
    end 
end 

def check_game_playing(gameBoard, symbol)
    if (gameBoard[0] == gameBoard[1] and gameBoard[1] == gameBoard[2] and gameBoard[2] == symbol) or 
        (gameBoard[3] == gameBoard[4] and gameBoard[4] == gameBoard[5] and gameBoard[5] == symbol) or 
        (gameBoard[6] == gameBoard[7] and gameBoard[7] == gameBoard[8] and gameBoard[8] == symbol) or 
        (gameBoard[0] == gameBoard[4] and gameBoard[4] == gameBoard[8] and gameBoard[8] == symbol) or 
        (gameBoard[2] == gameBoard[4] and gameBoard[4] == gameBoard[6] and gameBoard[6] == symbol)
        $game_playing = false 
        puts "Game is Over, #{$symbol} wins!"
    elsif  $empty == 0 
        puts "It's a tie!"
        $game_playing = false
    end  
end




start_game()
