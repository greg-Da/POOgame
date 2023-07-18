require_relative 'player'

$foes_name = ['Brook', 'Tony', 'José', 'Josiane', 'Michel', 'Greg', 'Anthony', 'Léa', 'Marion', 'Pauline', 'Jacquie', 'Paul', 'Antoine', 'Alexis', 'Laurent', 'Samy', 'Jordan', 'Kelly']

class Game
    attr_accessor :human_player, :players_left, :ennemies_in_sight
    
    def initialize(name)
        
        @human_player = HumanPlayer.new(name)
        @players_left = rand(10..15)
        
        @enemies_in_sight = []
    end
    
    def kill_player(player)
        @enemies_in_sight.delete(player)
        @players_left -= 1
    end
    
    def is_still_ongoing?
        if @human_player.life_points > 0 && @players_left > 0
            return true
        else 
            return false
        end
    end
    
    def new_players_in_sight
        if @players_left == @enemies_in_sight.length
            puts "Tous les joueurs sont déjà en vue"
        else
            dice = rand(1..6)
            if dice == 1
                puts "Pas de nouveaux ennemies en vue"
            elsif dice >= 2 && dice <= 4 || dice >= 5 && @players_left == 1
                foe = Player.new($foes_name[rand(0..17)])
                @enemies_in_sight << foe
                puts "1 nouvel ennemie en vue"
                
            elsif dice >= 5 && @players_left > 1
                foe1 = Player.new($foes_name[rand(0..17)])
                foe2 = Player.new($foes_name[rand(0..17)])
                @enemies_in_sight << foe1
                @enemies_in_sight << foe2
                puts "2 nouveaux ennemies en vue"
            end
        end
    end
    
    def show_players
        puts ''
        @human_player.show_state
        puts "il reste #{@players_left} ennemies"
    end
    
    def menu
        puts ''
        
        puts "Quelle action veux-tu effectuer ?" 
        puts "a - chercher une meilleure arme"
        puts "s - chercher à se soigner"
        puts "attaquer un joueur en vue :"
        @enemies_in_sight.each do |foe|
            print "#{@enemies_in_sight.index(foe)} - " 
            print "#{foe.show_state}"
        end
        
        puts ''
        print '>'
        action = gets.chomp 
        menu_choice(action)
    end
    
    def menu_choice(action)
        if action == 'a'
            @human_player.search_weapon
        elsif action == 's'
            @human_player.search_health_pack
        else
            if @enemies_in_sight[action.to_i] != nil
                @human_player.attacks(@enemies_in_sight[action.to_i])
                if @enemies_in_sight[action.to_i].life_points <= 0
                    kill_player(@enemies_in_sight[action.to_i])
                end
            else
                puts "Pas une option, tu viens de perdre un tour"
            end
        end
        
        ennemies_attack()
    end
    
    def ennemies_attack
        @enemies_in_sight.each do |foe|
            foe.attacks(@human_player)
        end
    end
    
    def end
        if @human_player.life_points <=0
            puts "tu as perdu"
        else
            puts "tu as gagné"
        end
    end
end