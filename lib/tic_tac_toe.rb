
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],  # Bottom row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Diagonal 1
  [2,4,6], # Diagonal 2
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
  board[index] = token
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  #if over?(board) #added - need this to avoid infinite loop problem on first play test -- BUT see below at play -- I put this in the wrong place
  #  return #added
  #else # added
    puts "Please enter 1-9:"
    z =  gets.chomp.to_i #changed input to z and took out anything after .  eg .to_i. -- chomp not help
    index = input_to_index(z)
    if valid_move?(board, index)
      token = current_player(board)
      move(board, index, token)
      #return
    else
      turn(board)
    end
  display_board(board)
  #end # added
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end

def check_winners(board)
  WIN_COMBINATIONS.each do |winning_array|
    new_array = [ ] #placement is very important.  Did not work where this was outside the WIN_COMBINATIONS each do
    winning_array.each do |index|
      new_array << board[index]
    end
    if new_array == ["X", "X", "X"] || new_array == ["O", "O", "O"]
      return winning_array # note the return is telling the whole method to stop! Distinguish this from break!
    end
  end
  return false # this is what got a return of false on a draw
end

def won?(board)
  board_empty = board.all? do |space|
    space == " "
  end
  if board_empty == true
    return false #return false
  else
    check_winners(board)
  end
end

def full?(board)
  board_full = board.all? do |space|
    space != " "
  end
  if board_full == true
    true
  else
    false
  end
end

def draw?(board)
  any_winner = won?(board)
  board_full = full?(board)
  if any_winner != false && board_full == true #Don't feel great about this, but it's how I tested for false if game won -- because won? will either produce false or an array -- it won't produce true
      false
  elsif board_full == false
    false
  else
    true
  end
end


def over?(board)
  if draw?(board) || won?(board) # Note this is a good example of how you can run a function for "true".  This says, if running these produces true, then the return here is true
    true
  else
    false
  end
end

def winner(board)
  if won?(board) != false
    winny = won?(board)
    board[winny[0]]
  end
end

def check_and_ending(board)
  if draw?(board)
    puts "Cats Game!"
    return
  elsif won?(board)
      puts "Congratulations #{winner(board)}!"
      return
  end
end

def play(board)
  if over?(board) == false # this is what solved it.  The problem I was having was one the very first test.
    loop do                # the testing there indicated it needed an "over" first.  I put that in turn(board)
      turn(board)          # That would make almost all the other tests pass, but it had to go here.
      if over?(board)
        break
      end
    end
  end
  if draw?(board)
    puts "Cats Game!"
    return
  else
    puts "Congratulations #{winner(board)}!"
    return
  end
end
