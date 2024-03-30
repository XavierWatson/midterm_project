
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

    def pick_cards(selection,player_object)
        selection = selection.sort
        selection.reverse_each do |index|
            player_object.display.delete_at(index)
            #Reset for appending later
            #player_object.display = []
        end
        #player_object.draw_cards(player_object.hand.cards)
        #player_object.visualise(player_object.hand.cards,player_object)
    end
end