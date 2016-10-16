require_relative '../lib/tic_tac_toe.rb'

describe './lib/tic_tac_toe.rb' do
  describe '#play' do
    it 'asks for players input on a turn of the game' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)
      allow(self).to receive(:over?).and_return(false, true)

      expect(self).to receive(:gets).at_least(:once).and_return("1")

      play(board)
    end

    it 'congratulates the winner X' do
      board = ["X", "X", "X", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)

      expect($stdout).to receive(:puts).with("Congratulations X!")

      play(board)
    end

    it 'congratulates the winner O' do
      board = [" ", " ", " ", " ", " ", " ", "O", "O", "O"]
      allow($stdout).to receive(:puts)

      expect($stdout).to receive(:puts).with("Congratulations O!")

      play(board)

    end
    it 'stops playing in a draw' do
      board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
      allow($stdout).to receive(:puts)

      expect(self).to_not receive(:turn)

      play(board)
    end

    it 'prints "Cats Game!" on a draw' do
      board = ["X", "O", "X", "O", "X", "X", "O", "X", "O"]
      allow($stdout).to receive(:puts)

      expect($stdout).to receive(:puts).with("Cats Game!")

      play(board)
    end

    it 'plays through an entire game' do
      board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
      allow($stdout).to receive(:puts)

      expect(self).to receive(:gets).and_return("1")
      expect(self).to receive(:gets).and_return("2")
      expect(self).to receive(:gets).and_return("3")
      expect(self).to receive(:gets).and_return("4")
      expect(self).to receive(:gets).and_return("5")
      expect(self).to receive(:gets).and_return("6")
      expect(self).to receive(:gets).and_return("7")

      expect($stdout).to receive(:puts).with("Congratulations X!")

      play(board)
    end
  end
end
