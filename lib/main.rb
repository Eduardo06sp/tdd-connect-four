# frozen_string_literal: true

require_relative 'connect_four'
require_relative 'player'

puts 'Please enter a name for player one, or press enter to use the default:'
input = gets.chomp
p1_name = input == '' ? 'Player 1' : input

puts 'Please enter a name for player one, or press enter to use the default:'
input = gets.chomp
p2_name = input == '' ? 'Player 2' : input

until %w[black white].include?(input)
  puts "#{p1_name}, please choose the color of your gamepiece: black or white"
  input = gets.chomp
end

p1_token = "#{input}_token"

if p1_token == 'white_token'
  p1_token = '★'
  p2_token = '☆'
else
  p1_token = '☆'
  p2_token = '★'
end

player_one = Player.new(p1_name, p1_token)
player_two = Player.new(p2_name, p2_token)

new_game = ConnectFour.new(player_one, player_two)
new_game.play_rounds
