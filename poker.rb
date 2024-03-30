
class Game
    attr_accessor :name, :pot, :player_turn, :game_state, :players, :hands, :player_register
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
        @player_register = @players
    end

    def fold_player(player)
        player = @players[@player_turn+1]
        $game.pass_turn()
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

    def raise_pot(amount)
        @pot += amount
    end

    def score_winner()
        winning_rating = 0
        scoreboard = []
        @players.each do |player|
            scoreboard.append(player.grade_hand(player.hand.cards))
        end
        winning_rating = scoreboard.max
        if scoreboard.count(winning_rating) > 1
            @players.each do |player|
                if player.hand.cards[0].rank == 'S'
                    print("#{player.name} Wins the Pot of: $#{pot}")
                    player.money += pot
                    round_end()

                elsif player.hand.cards[0].rank == 'H'
                    print("#{player.name} Wins the Pot of: $#{pot}")
                    player.money += pot
                    round_end()

                elsif player.hand.cards[0].rank == 'D'
                    print("#{player.name} Wins the Pot of: $#{pot}")
                    player.money += pot
                    round_end()
                end
            end
        end
    end

    def round_end()
        @player_register.each do |registered_player|
            if @players.count(registered_player) == 0
                @players.append(registered_player)
            end
        end
        $deck = Deck.new("Standard_Deck",[])
    end
    
    def pass_turn()
        @player_turn += 1
        $game.current_player()
        if @player_turn == @player_register.length-1
            score_winner()
        end
        if @player_turn < @player_register.length
        $game.current_player.draw_cards($game.current_player.hand.cards)
        $game.current_player.visualise($game.current_player.hand.cards,$game.current_player)
        print("Pot:#{$game.pot}\n")
        print ("#{$game.current_player.name}'s Hand:#{$game.current_player.display}\n")
        print("Value: #{$scores[$game.current_player.hand.grade_hand($game.current_player.hand.cards)]}\n")
        $game.current_player.round_action($game.current_player)
        end
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
        return @rating
    end

end

class Player < Hand
    attr_accessor :name,:hand, :display, :queue, :money
    def initialize(name,queue)
        @name = name
        @hand = gen_hand(@name)
        @display = []
        @queue = queue
        @money = 25000
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
            player_object.hand.cards.delete_at(Integer(index))
            player_object.display = []
        end
        player_object.draw_cards(player_object.hand.cards)
        player_object.visualise(player_object.hand.cards,player_object)
    end
    def round_action(player) #User Options for Betting and Discarding
        discards = 3
        discarded = []
        bet = 0
        print("Discard a card(s)? 'y/n'")
        input = gets.chomp
        while (input != ('y')) and (input != ('n'))
            print("Please Choose 'y/n'\n Discard a Card(s)?")
            input = gets.chomp
        end
        if input == 'y'
            while discards != 0
                until (input == '') or (discards == 0)
                print("Pick a Card to Discard [0-4]. (#{discards} Remaining. Enter Empty to Complete)")
                input = gets.chomp
                    if discarded.count(input) == 0
                        discarded.append(input)
                    elsif
                        print('invalid input, try again')
                        discards += 1
                    end
                discards -= 1
                end
            end
            if discarded.length > 0
                player.pick_cards(discarded,player)
            end
        print ("#{$game.current_player.name}'s Hand:#{$game.current_player.display}\n")
        print("Value: #{$scores[$game.current_player.hand.grade_hand($game.current_player.hand.cards)]}\n")
        end
        print("Raise or Fold? 'r/f'")
        input = gets.chomp
        while (input != 'f') and (input != 'r')
            print('Invalid input, try again f/r')
        end
        if input == 'f'
            $game.fold_player(player)
            $game.pass_turn()
        elsif input == 'r'
            print('Input Bet Amount:\n$')
            input = gets.chomp
            while Integer(input) == false
                print('[Invalid Input: Must Be Integer] Input Bet Amount:\n$')
                input = gets.chomp
            end 

            while Integer(input) > player.money
                print('[Not Enough Money Bet]Input Bet Amount:\n$')
                while Integer(input) == false
                    print('[Invalid Input: Must Be Integer] Input Bet Amount:\n$')
                    input = gets.chomp
                end 
            end
            bet = Integer(input)
            $game.raise_pot(bet)
            $game.pass_turn()
        end
    end
end
$deck = Deck.new("Standard_Deck",[])
$game = Game.new('Game')

#Init Deck Global
    #Generate Card Objects
    $deck.build_cards
    #Shuffle Array of Card Objects
    $deck.shuffle_deck

#Player Turn Setup
    $game.current_player.draw_cards($game.current_player.hand.cards)
    $game.current_player.visualise($game.current_player.hand.cards,$game.current_player)
    print("Pot:#{$game.pot}\n")
    print ("#{$game.current_player.name}'s Hand:#{$game.current_player.display}\n")
    print("Value: #{$scores[$game.current_player.hand.grade_hand($game.current_player.hand.cards)]}\n")
    $game.current_player.round_action($game.current_player)