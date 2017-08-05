
WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],
                    [0,3,6],[1,4,7],[2,5,8],
                  [0,4,8],[2,4,6]]

  def valid_move?(board,index)
    ((0...9).include? index) && !position_taken?(board,index )
  end


  def position_taken?(board,index)
    cell = board[index]
    !(cell.nil? ||  cell.empty? || cell == " ")
  end

  def won? board

    if (0..8).all? do |i|
      !position_taken?(board,i)
    end
    return false
  else

    id= 0

     while id < 8 do
       i,j,k = WIN_COMBINATIONS[id]

       if board[i] == "X" && board[j] == "X" && board[k]== "X" ||
        board[i] == "O" && board[j] == "O" && board[k]== "O"
        return   [i,j,k]
      end
      id+=1
    end
      return false
    end
  end


  def full? board
    turn_count(board) == 9
  end

  def draw? board
    full?( board) && !won?( board)
  end

  def over? board
    draw?(board ) || won?(board)
  end

  def winner board
    index = won? board
    if index
      board[index[0]]
    end
  end

  def display_board(board)
    b = []
    (0...board.size-2).step(3) { |i|  b << board[i..i+2].map {|letter| " #{letter} "}.join("|")}
    sep = "-" * b[0].size
    puts b.join("\n" + sep + "\n")
  end

  def input_to_index(id)
    id.to_i - 1
  end

  def move(board,index,player)
    board[index] = player
  end


  def turn(board)
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
    until valid_move?(board,index)
      index = input_to_index(gets.strip)
    end
    player = current_player(board)
    move(board,index,player)
    display_board(board)
  end


  def turn_count(board)
    count = 0
    board.each.with_index { |cell,i| count+=1 if position_taken?(board,i)}
   count
  end

  def current_player(board)
    turn_count(board) % 2 == 0 ? "X" : "O"
  end




  def winner board
    index = won? board
    if index
      board[index[0]]
    end
  end



  def play(board)

    while !over? board
     turn board

   end
   if won? board
     puts "Congratulations #{winner(board)}!"
   else
     puts "Cats Game!"
   end

  end
