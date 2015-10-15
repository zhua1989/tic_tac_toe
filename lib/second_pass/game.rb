require 'pry'

require_relative './board.rb'

class Game
  def initialize
    @board = Board.new
  end

  def game_play
    puts "Do you want to be X or O?"
    @choice = gets.chomp

    5.times do
      board_display
      player_choice
      computer_choice
      winner = @board.game_winner?
      if winner
        board_display
        puts "The winner is #{winner}"
        puts "Do you want to play again? (Y/N?)"
        ans = gets.chomp
        if ans == 'Y'
          new_session = Game.new
          new_session.game_play
        end
      end
    end
    board_display
    puts "The game was a draw"

  end

  ##Method to display board by calling instance variable and puttsing it
  def board_display
    puts @board
  end

  def player_choice
    puts @choice
    ##Looping each time for next choice 
    loop do
      puts "Please enter the row number (1,2, or 3): "
      row = gets.chomp.to_i
      puts "Please enter the col number (1,2, or 3): "
      col = gets.chomp.to_i
      if @board[row,col]
        puts "Cell is full already"
      else
        if @choice == "X"
          @board[row,col] = "X"
          pry 
        else
          @board[row,col] = "O"
        end
        break
      end
    end

  rescue ArgumentError
    puts "Values should be 1, 2 or 3"
    player_choice
  end

  #Logic for computer choices
  #checks a cell to see if it's nil
  #randomly assigns that cell with a value based on what the human chose as a choice
  def computer_choice
    free_slots = @board.each_line.to_a.flatten.map.with_index {|e, ix| e.nil? ? ix : nil }.compact
    return "No Free Slots" if free_slots.empty?
    rand_pos = rand(free_slots.size)
    free_slot = free_slots[rand_pos]
    col = free_slot % 3 + 1
    lin = free_slot / 3 + 1
    case
      when @choice == "X"
        @board[lin, col] = "O"
      when @choice == "O"
        @board[lin, col] = "X"
    end 
  
  end
end

Game.new.game_play