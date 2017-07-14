# Helper Methods
# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],
                    [0,3,6],[1,4,7],[2,5,8],
                    [0,4,8],[2,4,6]]

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

def move(board, index, current_char)
  board[index] = current_char
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
num_turns = 0
 board.each do |space|
   if space == "X" || space == "O"
     num_turns += 1
   end
 end
 num_turns
end

def current_player(board)
  if turn_count(board) % 2 == 0
    "X"
  else
    "O"
  end
end


def won?(board)
 win = false
 char_array = ["X","O"]

  WIN_COMBINATIONS.each do |win_index|
    char_array.each do |char|
      win = win_index.all? do |position|
        board[position] == char
      end

        if win
        return win_index
      end
    end
  end

 win
end

def full?(board)

  board_full = board.all? do |cell|
    cell == "X" || cell == "O"
  end

end

def draw? (board)

  if full?(board) && !won?(board)
    true
  end

end

def over? (board)
  if draw?(board) || won?(board) || turn_count(board) >= 9
    true
  end
end


def winner(board)

  if won?(board)
    board[won?(board)[0]]
  end

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

# Define your play method below
def play(board)

  until over?(board) do
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end

end
