require 'player'
RSpec.describe Player do
    describe "visualise" do
        it "Convert name attribute of an object to a readable array" do
            player = Player.new('Bob')
            cards = [1,2,3,4,5,6]
            player.visualise(cards,player)
            expect(player.display).to eq([1,2,3,4,5,6])
        end
    end
end