
class Game
    attr_accessor :name, :pot, :player_turn, :game_state, :players, :hands
    @player_turn = 0
    @player_action = ''
    @pot = 0

    def initialize(name)
        @name = name
        @pot = 0
        @player_turn = 0
        @game_state = "Active"
        @players = []
        @hands = []
        initialize_players()
    end
    def get_player(queue)

    end

    def initialize_players()
            #Initialize Objects
        input = ' '
        player_list = []
        player_objects = []
        #'''
        until input == ''
            print("Input Player Name(s): Enter Empty Input to Proceed:\n")
            input = gets.chomp
            if input != ''
                player_list.append(input)
            end
        end
        #'''
        queue_number = 0
        player_list.each do |player|
            player =  Player.new("#{player}",queue_number)
            player_objects.append(player)
            queue_number += 1
        @players = player_objects
            end
    end

    def current_player()
        return @players[@player_turn]
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
    attr_accessor :cards, :id, :rating
    $scores = ['Royal Straight Flush','Straight Flush','Four of a Kind','Full House','Flush','Straight','Three of a Kind','Two Pair','Pair','High Card']
    $scores = $scores.reverse
    def initialize(cards,id)
        @cards = cards
        @id = id
        @rating = 1
    end

    def gen_hand(id)
        id = Hand.new([],id)
    end

    def draw_cards(cards)
        if cards.length < 5
            until cards.length == 5
                cards.append($deck.remaining_cards[0])
                $deck.remaining_cards.delete_at(0)
            end
        end
    end
    def calculate_straight(cards)
        all_nums = []
        straight_flag = false
        prev_digit = 0
        cards.each do |card|
            if (card == 'A') and (['K','Q','J','10'] in cards)
                all_nums.append(Integer('14'))
            elsif card == 'A'
                all_nums.append(Integer('1'))
            elsif card == 'K'
                all_nums.append(Integer('13'))
            elsif card == 'Q'
                all_nums.append(Integer('12'))
            elsif card == 'J'
                all_nums.append(Integer('11'))
            else
                all_nums.append(Integer(card))
            end
        end
        cards = all_nums.sort
        cards.each do |card|
            prev_digit = card
            if card - prev_digit != 1
                return false
            else
                return True
            end
        end
    end
    def grade_hand(cards)
        rank_list = []
        suit_list = []
        score_setup = []
        dupes = []
        cards.each do |card|
            rank_list.append(card.rank)
            suit_list.append(card.suit)
        end
        rank_list.each do |rank|
            dupes.append(rank_list.count(rank))
            if rank_list.count(rank) > 1
                score_setup.append(rank)
            end
        end
        print(dupes)
    ########### Grading
        if (['A','K','Q','J','10'] in rank_list) and (suit_list.count(suit_list[0]) == 5) #Royal Flush
            @rating = 9
        elsif (calculate_straight(rank_list) == true) and (suit_list.count(suit_list[0]) == 5) #Straight Flush
            @rating = 8
        elsif dupes.count(4) == 4 #Four of a Kind
            @rating = 7
        elsif (dupes.count(3) == 3) and (dupes.count(2) == 2) #Full House
            @rating = 6
        elsif (suit_list.count(suit_list[0]) == 5) #Flush
            @rating = 5
        elsif calculate_straight(rank_list) #Straight
            @rating = 4
        elsif (dupes.count(3) == 3) #Three of a Kind
            @rating = 3
        elsif dupes.count(2) == 4 # Two Pair
            @rating = 2
        elsif (dupes.count(2) == 2) #One Pair
            @rating = 1
        else #High Card
            @rating = 0
        end
        print(score_setup)
        print($scores[rating])
    end

end

class Player < Hand
    attr_accessor :name,:hand, :display, :queue
    def initialize(name,queue)
        @name = name
        @hand = gen_hand(@name)
        @display = []
        @queue = queue
    end

    def visualise(cards,player_object)
        cards.each do |card|
            card_name = card.name
            player_object.display.append(card_name)
        end
    end
    def pick_cards(selection,player_object)
        selection = selection.sort
        selection.reverse_each do |index|
            player_object.hand.cards.delete_at(index)
            player_object.display = []
        end
        player_object.draw_cards(player_object.hand.cards)
        player_object.visualise(player_object.hand.cards,player_object)
    end
end


$deck = Deck.new("Standard_Deck",[])
game = Game.new('Game')

#Init Deck Global
    #Generate Card Objects
    $deck.build_cards
    #Shuffle Array of Card Objects
    $deck.shuffle_deck

#Player TUrn Setup
    game.current_player.draw_cards(game.current_player.hand.cards)
    game.current_player.visualise(game.current_player.hand.cards,game.current_player)
    print ("#{game.current_player.name}'s Hand:#{game.current_player.display}\n")
    print("#{game.current_player.hand.grade_hand(game.current_player.hand.cards)}")

