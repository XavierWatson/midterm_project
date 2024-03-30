
class Player < Hand
    attr_accessor :name,:hand, :display
    def initialize(name)
        @name = name
        @hand = gen_hand(@name)
        @display = []
    end

    def visualise(cards,player_object)
        cards.each do |card|
            card_name = card
            player_object.display.append(card_name)
        end
    end
end