require 'pry'

# Create the deck of cards to deal
suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'K', 'Q', 'A' ]
deck = suits.product(cards)
deck.shuffle!
player_cards = []
dealer_cards = []

def calculate_total(cards)
  arr = cards.map{|e| e[1]}

  total = 0
  arr.each do |value|
    if value == 'A'
      total += 11
    elsif value.to_i == 0 # Jack, Queen, or King
      total += 10
    else
      total += value.to_i
    end

    arr.select{|e| e =='A'}.count.times do
      total -= 10 if total > 21
    end
  end

    total
end

puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "Welcome to Camden's Blackjack table!"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "What is your name?"
puts " "
name = gets.chomp
puts ' '
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "Welcome, #{name} and goodluck!"
puts " "

2.times do
  player_cards << deck.pop
  dealer_cards << deck.pop
end
player_total = calculate_total(player_cards)
dealer_total = calculate_total(dealer_cards)

if player_total == 21
  puts "#{name}, got Blackjack!!! You WIN!"
  puts "Looks like #{name} has #{player_cards[0]} and #{player_cards[1]}... that's #{player_total}"
  exit
elsif dealer_total == 21
  puts "The dealer, got Blackjack!!! You lose."
  puts "Looks like the dealer has #{dealer_cards[0]} and #{dealer_cards[1]}... that's #{dealer_total}"
  exit
elsif
  puts "Looks like #{name} has #{player_cards[0]} and #{player_cards[1]}... that's #{player_total}"
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  puts "Looks like the dealer has #{dealer_cards[0]} and #{dealer_cards[1]}... that's #{dealer_total}"
  puts ' '
end

while player_total < 21
  puts "So #{name}, what would you like to do?... ( hit or stay )"
  player_choice = gets.chomp

  if player_choice == "hit"
    new_card = deck.pop
    puts "Dealing card to player: #{new_card}"
    player_cards << new_card
    player_total = calculate_total(player_cards)
    puts "Your new total is: #{player_total}"
    if player_total > 21
      puts " "
      puts "Ouch...#{name} busted"
    elsif player_total == 21
      puts " "
      puts "#{name} got Blackjack!"
    end

  elsif player_choice == "stay"

    while dealer_total < 17
      new_card = deck.pop
      dealer_cards << new_card
      dealer_total = calculate_total(dealer_cards)
      if dealer_total > 21
        puts " "
        puts "Ouch...#{name} busted"
      elsif dealer_total == 21
        puts " "
        puts "#{name} got Blackjack!"
      end
    end

    puts " "
    puts "Player's cards:"
    player_cards.each do |card|
      puts "#{card}"
    end
    puts " "
    puts "Dealer's cards:"
    dealer_cards.each do |card|
      puts "#{card}"
    end

    puts " "
    if player_total > dealer_total
      puts "#{name} wins!"
      exit
    elsif player_total < dealer_total
      puts "Dealer wins!"
      exit
    else
      puts "Looks like we have a tie, folks!"
      exit
    end

    elsif player_choice != "hit" || player_choice != "stay"
      puts "I'm sorry you chose #{player_choice}...that's not a valid option."
    end
  end
