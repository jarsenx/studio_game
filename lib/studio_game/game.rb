require 'csv'
require_relative 'player'
require_relative 'game_turn'
require_relative 'treasure_trove'

module StudioGame
  class Game
    
    attr_reader :title
    
    def initialize(title)
      @title = title
      @players = []
    end
  
    def load_players(from_file)
      CSV.foreach(from_file) do |row|
        player = Player.new(row[0], Integer(row[1]))
        add_player(player)
      end
    end
  
    def save_high_scores(to_file="high_scores.txt")
      File.open(to_file, "w") do |file|
        file.puts("#{@title} High Scores:")
        @players.sort.each do |player|
          file.puts high_score_entry(player)
        end
      end
    end
    
    def add_player(player)
      @players << player
    end
    
    def play(rounds)
      puts "There are #{@players.size} players in #{@title}:"
      
      @players.each { |player| puts player }
  
      treasures = TreasureTrove::TREASURES
      puts "\nThere are #{treasures.size} treasures to be found:"
      treasures.each do |treasure|
        puts "A #{treasure.name} is worth #{treasure.points} points."
      end
          
      1.upto(rounds) do |round|
        if block_given?
          break if yield
        end
        puts "\nRound #{round}:"
        @players.each do |player|
          GameTurn.take_turn(player)
        end
      end
    end
  
    def print_name_and_health(player)
        puts "\t#{player.name} (#{player.health})"    
    end
    
    def print_stats
      strong_players, wimpy_players = @players.partition { |player| player.strong? }
      
      puts "\n#{@title} Statistics:"
      
      puts "\n#{strong_players.size} strong players:"
      strong_players.each do |player|
        print_name_and_health(player)
      end
      
      puts "\n#{wimpy_players.size} wimpy players:"
      wimpy_players.each do |player|
        print_name_and_health(player)
      end
      
      sorted_players = @players.sort
      puts "\n#{@title} High Scores:"
      sorted_players.each do |player|
        puts high_score_entry(player)
      end
      
      puts "\nPlayer Point Totals:"
      sorted_players.each do |player|
        puts "\n#{player.name}'s point totals:"
        player.each_found_treasure do |treasure|
          puts "#{treasure.points} total #{treasure.name} points"
        end
        puts "#{player.points} grand total points"
      end
      
      puts "\nTotal Treasure Points Scored During the Game: #{total_points}"
      puts "\n" 
    end
    
    def total_points
      @players.reduce(0) { |sum, player| sum + player.points }
    end
    
    def high_score_entry(player)
      "#{player.name.ljust(20, '.')} #{player.score}"
    end
  
  end
  
  if __FILE__ == $0
    player4 = Player.new("alvin", 150)
    player5 = Player.new("simon")
    player6 = Player.new("theodore", 125)
    
    game = Game.new("Chipmunks")
    game.add_player(player4)
    game.add_player(player5)
    game.add_player(player6)
    game.play
  end
end