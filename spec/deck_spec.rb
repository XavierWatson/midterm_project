require 'deck'
RSpec.describe Deck do
    describe ".build_cards" do
        it "builds 14 differently ranked cards each of 4 suits" do
            deck = Deck.new("Standard_Deck",[])
            deck.build_cards
            expect(deck.remaining_cards.length).to  eq(52)
        end
    end
end