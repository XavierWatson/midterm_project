require 'player'
RSpec.describe Player do
    describe ".visualise" do
        it "Convert name attribute of an object to a readable array" do
            player = Player.new('Bob')
            cards = [1,2,3,4,5,6]
            player.visualise(cards,player)
            expect(player.display).to eq([1,2,3,4,5,6])
        end
    end
    describe ".pick_cards" do
        it "Removes Cards from an Array" do
            player = Player.new('Bob')
            player.display = [1,2,3,4,5]
            selection = [0,1,4]
            player.pick_cards(selection, player)
            expect(player.display.length).to eq(2)
        end
   end
end