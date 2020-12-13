#!/usr/bin/env ruby
require 'pry'
require_relative '../lib/tic_tac_toe.rb'
class TicTacToe
  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # Bottom row
    [0,3,6],  # Left column
    [1,4,7],  # Middle column
    [2,5,8],  # Right column
    [0,4,8],  # Backward slash \
    [2,4,6],  # Forward slash /
  ]
  def initialize
    @board = Array.new(9, " ")
  end

  def display_board
    board_values = @board.map.with_index do |item, index| 
      last_row_field = index == @board.length - 1 ? " #{item} " : " #{item} \n-----------\n"
      ((index + 1) % 3) == 0 ? last_row_field : " #{item} |"
    end
    puts board_values.join
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(board_index, player_token = "X")
    @board[board_index] = player_token
  end

  def position_taken?(index)
    @board[index] == "X" || @board[index] == "O"
  end

  def valid_move?(input)
    !position_taken?(input) && input.between?(0, 8)  
  end

  def turn_count
    @board.select{|input| input == "X" || input == "O"}.length
  end

  def current_player
    turn_count.odd? ? "O" : "X"
  end

  def turn
    puts "Enter position between 1 - 9"
    board_index = input_to_index(gets)
    if valid_move?(board_index)
      move(board_index, current_player)
      puts display_board
    else
      turn
    end    
  end

  def won?
    WIN_COMBINATIONS.each_with_index do |winning_pattern, index|
      first_value = @board[winning_pattern[0]]
      second_value =  @board[winning_pattern[1]]
      if  first_value != " " && first_value == second_value
        return winning_pattern if second_value == @board[winning_pattern[2]]
      end
    end
    false
  end

  def full?
    turn_count == @board.length # WHY WON't THIS RUN as well?: @board.select {|val| val == "X" || val == "O"}.length == @board.length ?
  end

  def draw?
    full? && !won?
  end

  def over?
    draw? || won?
  end

  def winner
    current_player == "X" ? "O" : "X" if won? #returns previous player
  end

  def play
    turn until over?
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!" 
    end
  end
end