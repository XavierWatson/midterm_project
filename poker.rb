class Game
    attr_accessor :name
    def initialize(name)
        @name = name
    end
end

class Player
    attr_accessor :name
    def initialize(name)
        @name = name
    end
end

class Deck
    attr_accessor :name
    def initialize(name)
        @name = name
    end
end

class Card
    attr_accessor :name
    def initialize(name)
        @name = name
    end
end

class Hand
    attr_accessor :name
    def initialize(name)
        @name = name
    end
end

player = Player.new("Player")
puts player