class Player
    attr_accessor :name, :life_points
    
    def initialize(name, life=10)
        @name = name
        @life_points = life
    end
    
    def show_state
        puts "#{@name} a #{@life_points} points de vie"
    end
    
    def gets_damage(damage)
        @life_points -= damage
        
        if @life_points <= 0
            puts "le joueur #{@name} a été tué !"
        end
    end
    
    def attacks(user_attacked)
        puts ''
        puts "le joueur #{@name} attaque le joueur #{user_attacked.name}"
        damage = compute_damage()
        puts "il lui inflige #{damage} points de dommages"
        user_attacked.gets_damage(damage)
    end
    
    def compute_damage
        return rand(1..6)
    end
    
end

class HumanPlayer < Player
    attr_accessor :weapon_level

    def initialize(name)

        @weapon_level = 1
        @life_points = 100
        @name = name
    end

    def show_state
        puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
    end

    def compute_damage
        return rand(1..6) * @weapon_level
    end

    def search_weapon
        weapon = rand(1..6)
        puts "Tu as trouvé une arme de niveau #{weapon}"
        if weapon > @weapon_level
            @weapon_level = weapon
            puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
        else
            puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
        end
    end

    def search_health_pack
        health = rand(1..6)
        if health == 1
            puts  "Tu n'as rien trouvé... "
        elsif health >= 2 && health <=5
            puts "Bravo, tu as trouvé un pack de +50 points de vie !"
            @life_points += 50
        else
            puts "Waow, tu as trouvé un pack de +80 points de vie !"
            @life_points += 80
        end

        if @life_points > 100
            @life_points = 100
        end
    end
    
end