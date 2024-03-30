
class Game
    attr_accessor :name, :pot, :player_action, :player_turn
    @player_turn = 0
    @player_action = ''
    @pot = 0

    def initialize(name,pot,player_action,player_turn)
        @name = name
        @pot = pot
        @player_action = player_action
        @player_turn = player_turn
    end
end

class Player < Game
    attr_accessor :name
    def initialize(name)
        @name = name
    end
end

class Deck < Game
    attr_accessor :name, :remaining_cards
    $ranks = ['A','2','3','4','5','6','7','8','9','10','J','Q','K']
    def initialize(name,remaining_cards)
        @name = name
        @remaining_cards = remaining_cards
    end
    def build_cards()
        $ranks.each do |rank|
            @remaining_cards.append(Card.new("#{rank}:S",rank,'S'))
            @remaining_cards.append(Card.new("#{rank}:H",rank,'H'))
            @remaining_cards.append(Card.new("#{rank}:D",rank,'D'))
            @remaining_cards.append(Card.new("#{rank}:C",rank,'C'))
        end
    end
    def shuffle_deck()
        @remaining_cards = @remaining_cards.shuffle
    end
end

class Card < Deck
    attr_accessor :name, :rank, :suit
    def initialize(name,rank,suit)
        @suit = suit
        @rank = rank
        @name = name
    end
end

class Hand < Player
    attr_accessor :name
    def initialize(name)
        @name = name
    end
end

#Initialize Objects
player = Player.new("Player")
deck = Deck.new("Standard_Deck",[])
game = Game.new('Game',0,0,0)
#Generate Card Objects
deck.build_cards
#Shuffle Array of Card Objects
deck.shuffle_deck
puts deck.remaining_cards
