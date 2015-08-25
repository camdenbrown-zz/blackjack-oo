class BlackJack
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new("Camden")
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def play
    welcome_message
    set_player_name
    deal_cards
    show_flop
    player_turn
    dealer_turn
    who_won?(player, dealer)
    show_final_score
  end

  def welcome_message
    puts "Welcome to Camden's Blackjack table!"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  end

  def set_player_name
    puts "What's your name?"
    player.name = gets.chomp
    puts " "
    puts "#{player.name} has joined the table"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Let the dealing begin..."
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  end

  def deal_cards
    2.times do
      player.add_card(deck.deal_one_card)
      dealer.add_card(deck.deal_one_card)
    end
  end

  def show_flop
    player.show_flop
    dealer.show_flop
  end

  def hit_blackjack_or_bust?(player_or_dealer)
    if player_or_dealer.total == 21
      if player_or_dealer.is_a?(Dealer)
        puts "Sorry, Dealer got a BlackJack...You Lose"
      else
        puts "#{player.name} got BlackJack!"
      end
      show_final_score
      # play_again?
    elsif player_or_dealer.is_busted?
      if player_or_dealer.is_a?(Dealer)
        puts "Dealer BUSTED! You win!"
      else
        puts "You BUSTED! You lose!"
      end
      show_final_score
      # play_again?
    end
  end

  def player_turn
    puts " "
    puts "It's #{player.name}'s turn."
    hit_blackjack_or_bust?(player)

    while !player.is_busted?
      puts " "
      puts "Would you like to hit or stay?"
      answer = gets.chomp

      if !['hit', 'stay'].include?(answer)
        puts "Please pick hit or stay"
        next
      end

      if answer == 'stay'
        break
      end

      new_card = deck.deal_one_card
      puts " "
      puts "#{player.name} has been dealt #{new_card}"
      player.add_card(new_card)
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "#{player.name}'s new total: #{player.total}"
      hit_blackjack_or_bust?(player)
    end
    puts " "
    puts "Player chose to stay. Total: #{player.total}"
  end

  def dealer_turn
    while !dealer.is_busted?
      while dealer.total <= 17
        new_card = deck.deal_one_card
        dealer.add_card(new_card)
        puts " "
        puts "Dealer chose to hit."
        hit_blackjack_or_bust?(dealer)
      end

      if dealer.total > 17 && !dealer.is_busted?
        puts " "
        puts "Dealer chose to stay."
        break
      end
    end
  end

  def who_won?(player, dealer)
    if player.total > dealer.total
      puts "#{player.name} has WON!"
    elsif player.total == dealer.total
      puts "Looks like there's a tie!"
    else
      puts "Sorry #{player.name}, but you Lost..."
    end
    # play_again?
  end

  def show_final_score
    puts " "
    puts "~~~~~~~~FINAL SCORE~~~~~~~~~~~~"
    puts "#{player.name}: #{player.total}"
    puts "Dealer: #{dealer.total}"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts " "
    exit
  end

  # def play_again?
  #
  # end

end

class Card
  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def card_output
    "The #{value} of #{suit}"
  end

  def to_s
    card_output
  end

end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    ['Hearts', 'Spades', 'Diamonds', 'Clubs'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'King', 'Queen', 'Ace'].each do |value|
        @cards << Card.new(suit, value)
      end
    end
    shuffle_deck!
  end

  def shuffle_deck!
    cards.shuffle!
  end

  def deal_one_card
    cards.pop
  end

end

module Hand

  def total
    values = cards.map{ |card| card.value}

    total = 0

    values.each do |value|
      if value == "Ace"
        total += 11
      else
        total += (value.to_i == 0 ? 10 : value.to_i)
      end
    end

    values.select { |value| value == "Ace"}.count.times do
      break if total <= 21
      total -= 10
    end

    total
  end

  def show_hand
    puts " "
    puts "~~~#{name}'s Hand~~~"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts "=> Total: #{total}"
    puts " "
  end

  def add_card(new_card)
    cards << new_card
  end

  def is_busted?
    total > 21
  end

end

class Player
  include Hand
  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def show_flop
    show_hand
  end

end

class Dealer
  include Hand
  attr_accessor :name, :cards

  def initialize
    @name = "Dealer"
    @cards = []
  end

  def show_flop
    puts "~~~Dealer's Hand~~~"
    puts "Card 1: ~~ Hidden ~~"
    puts "Card 2: #{cards[1]}"
  end

end

BlackJack.new.play
