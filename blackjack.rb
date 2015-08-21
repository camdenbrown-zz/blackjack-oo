class Game
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new(self.player.name)
    @dealer = Dealer.new('DomoDealer')
    @deck = Deck.new
  end

  def play
    welcome_message
  end

  def welcome_message
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Welcome to Camden's Blackjack table!"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "Welcome, #{self.player.name} and goodluck!"
    puts " "

  end

end

class Deck
  attr_accessor :cards

  def initialize
    @cards = ['Hearts', 'Spades', 'Diamonds', 'Clovers'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'K', 'Q', 'A'].each do |value|
        @cards << Card.new(suit, value)
      end
    end
    cards.shuffle_deck!
  end

  def shuffle_deck!
    cards.shuffle!
  end

  def deal_cards

  end

end

class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

end

class Player
  attr_accessor :name

  def initialize(name)
    @name = set_player_name(name)
  end

  def set_player_name(name)
    puts "What is your name?"
    puts " "
    @name = gets.chomp
    puts " "
  end

end

class Dealer
  attr_reader :name

  def initialize
    @name = name
  end

end

Game.new.play
