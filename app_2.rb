require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts '------------------------------------------------'
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts '------------------------------------------------'

puts ''
puts 'Quel est ton nom ?'
print '>'
name = gets.chomp
player = HumanPlayer.new(name)

foe1 = Player.new("Josiane")
foe2 = Player.new("José")

foes = [foe1, foe2]


while player.life_points > 0 && (foe1.life_points > 0 || foe2.life_points > 0)
    player.show_state 

    puts "Quelle action veux-tu effectuer ?" 
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "attaquer un joueur en vue :"
    print "0 - " 
    print "#{foe1.show_state}"
    print "1 - " 
    print "#{foe2.show_state}"
   
    print '>'
    action = gets.chomp 

    case action
    when 'a'
        player.search_weapon
    when 's'
        player.search_health_pack
    when '0'
        player.attacks(foe1)
    when '1'
        player.attacks(foe2)
    else
        puts 'option non valide'
    end

    puts ''
    puts "Les autres joueurs t'attaquent !"
    foes.each do |foe|
        if foe.life_points > 0
            foe.attacks(player)
        end
    end

end

puts "La partie est finie"
if player.life_points > 0
    puts "BRAVO ! TU AS GAGNE !"
else
    puts "Loser ! Tu as perdu !"
end
