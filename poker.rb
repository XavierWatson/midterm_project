
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

class Card < Game
    attr_accessor :name, :rank, :suit
    def initialize(name,rank,suit)
        @suit = suit
        @rank = rank
        @name = name
    end
end

class Deck < Card
    attr_accessor :name, :remaining_cards
    $ranks = ['A','2','3','4','5','6','7','8','9','10','J','Q','K']
    def initialize(name,remaining_cards)
        @name = name
        @remaining_cards = remaining_cards
    end
    def build_cards()
        #assemble a card object of each rank and suit
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

class Hand < Deck
    attr_accessor :cards, :id
    def initialize(cards,id)
        @cards = cards
        @id = id
    end

    def gen_hand(id)
        id = Hand.new([],id)
    end

    def draw_cards(cards)
        while cards.length < 5
            cards.append($deck.remaining_cards[0])
            $deck.remaining_cards.delete_at(0)
        end
    end
end

class Player < Hand
    attr_accessor :name,:hand, :display
    def initialize(name)
        @name = name
        @hand = gen_hand(@name)
        @display = []
    end

    def visualise(cards,player_object)
        cards.each do |card|
            card_name = card.name
            player_object.display.append(card_name)
        end
    end
end

#Initialize Objects
player = Player.new("Player")
$deck = Deck.new("Standard_Deck",[])
game = Game.new('Game',0,0,0)

#Init Deck Global
    #Generate Card Objects
    $deck.build_cards
    #Shuffle Array of Card Objects
    $deck.shuffle_deck

#Set Up Player Data
player.draw_cards(player.hand.cards)
player.visualise(player.hand.cards,player)
print ("#{player.name}'s Hand:#{player.display}")


