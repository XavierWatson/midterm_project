require 'hand'
RSpec.describe Hand do
    describe ".gen_hand" do
        it "Generated a Hand Object" do
            data = Hand.new([],data)
            expect(data.cards).to eq([])
        end
    end
    describe ".draw_cards" do
        it "add card objects to the hand object such that there are 5 cards" do
            data = Hand.new([],data)
            data.draw_cards(data.cards)
            expect(data.cards.length).to eq(5)
        end
    end
    
end