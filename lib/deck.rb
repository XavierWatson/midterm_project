class Card
    attr_accessor :name, :rank, :suit
    def initialize(name,rank,suit)
        @suit = suit
        @rank = rank
        @name = name
    end
end
class Deck
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