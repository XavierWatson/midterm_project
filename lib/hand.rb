
class Hand < Deck
    attr_accessor :cards, :id
    $deck = [1,2,3,4,5,6,7,8,9]
    def initialize(cards,id)
        @cards = cards
        @id = id
    end

    def gen_hand(id)
        id = Hand.new([],id)
    end

    def draw_cards(cards)
        while cards.length < 5
            cards.append($deck[rand(1..$deck.length)])
        end
    end
end