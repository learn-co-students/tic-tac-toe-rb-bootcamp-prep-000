WIN_COMBINATIONS= [ 
    [0,1,2], #top row
    [3,4,5], #mid row
    [6,7,8], #low row
    [0,3,6], #L colum
    [1,4,7], #mid colum
    [2,5,8], # R colum
    [2,4,6], #dig one
    [0,4,8] #dig tow
  ]

  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts '-----------'
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts '-----------'
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
    

end


def input_to_index(user_input)
    #board_index=
    user_input.to_i-1
    
  end


  def move(board, board_index, character)

    board[board_index]=character
    
  end


  def position_taken?(board, index)
    if !(board[index].nil? || board[index] == " ")
    true
    else 
        false
    end

  end

  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end


  def turn(board)
    puts "Please enter 1-9:"
    user_input=gets.strip
    index=input_to_index(user_input)
    valid_move?(board,index)
    if valid_move?(board, index)
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end

   

def turn_count(board)
    counter=0
    board.each do |element|
        if element=="X" || element== "O"
            counter+=1
        end
    end
    counter
end

def current_player(board)
    (turn_count(board)%2).even? ? "X" : "O"
end 

def won?(board)
    WIN_COMBINATIONS. each do |combination|
  
      if board[combination[0]]=="X" && board[combination[1]]=="X" && board[combination[2]]=="X" || board[combination[0]]=="O" && board[combination[1]]=="O" && board[combination[2]]=="O"
        return combination 
      end 
    end
    return false 
  end 

  def full?(board)
    board.all? do |positions|
      positions !=" "
    end
  end
  
    
def draw?(board)

    if full?(board) && !won?(board)
      true 
    else 
      false
    end
end


def over?(board)
     won?(board) || draw?(board) || full?(board)
   
    end


    def winner(board)
        if won?(board)== false 
          nil
        else WIN_COMBINATIONS. each do |combination|
      
          if board[combination[0]]=="X" && board[combination[1]]=="X" && board[combination[2]]=="X" 
            return "X"
            
          elsif board[combination[0]]=="O" && board[combination[1]]=="O" && board[combination[2]]=="O"
            return "O"
          end
        end
      end
        
      end

      def play(board)

        while !over?(board)
           
            turn(board)
            
        end

        if won?(board)
            puts "Congratulations #{winner(board)}!"
        else draw?(board)
            puts "Cat's Game!"
        end
          
      end