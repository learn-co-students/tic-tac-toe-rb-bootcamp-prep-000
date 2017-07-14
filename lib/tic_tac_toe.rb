
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

def move(board, user_input, player)
  board[user_input] = player
end

def valid_move?(board,index)
  !position_taken?(board, index) && (0..8).include?(index) ? true : false
end


def position_taken?(board, index)
  board[index] == " " || board[index] == "" || board[index] == nil ? false : true
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  player = current_player(board)

  if valid_move?(board, index)
    move(board, index, player)
    display_board(board)
  else
    turn(board)
  end

end

def turn_count(board)
  board.count {|el| el != " "}
end

def current_player(board)

  if turn_count(board).even?
    "X"
  else
    "O"
  end

end



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

  WIN_COMBINATIONS.each do |combo|
      if board[combo[0]] == board[combo[1]] && board[combo[1]] == board[combo[2]] && position_taken?(board, combo[0])
        return combo
      end
  end
  false
end

def full?(board)
  board.none? {|el| el == " "}
end

def draw?(board)
  (full?(board) && !won?(board)) ? true : false
end

def over?(board)
  won?(board) || draw?(board) ? true : false
end

def winner(board)
  if won?(board)
    if board.count("X") > board.count("O")
      "X"
    else
      "O"
    end
  end
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
