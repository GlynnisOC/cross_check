require 'CSV'
<<<<<<< Updated upstream
require './lib/game'
require './lib/season'
require './lib/league'
require './lib/team'

=======
require_relative './game'
require_relative './season'
require_relative './league'
require_relative './team'
# require_relative './helper_class'
>>>>>>> Stashed changes

class StatTracker
  include Game
  include Season
  include Team
  include League

  def initialize(game_stats, team_stats, game_teams_stats)
    @game_stats = game_stats
    @team_stats = team_stats
    @game_teams_stats = game_teams_stats
  end

  def self.from_csv(input)
    game_stats = CSV.read(input[:games],
      {headers: true, header_converters: :symbol, converters: :numeric}.merge(Hash.new))
    game_teams_stats = CSV.read(input[:game_teams],
      {headers: true, header_converters: :symbol, converters: :numeric}.merge(Hash.new))
    team_stats = CSV.read(input[:teams],
      {headers:true, header_converters: :symbol, converters: :numeric}.merge(Hash.new))

      StatTracker.new(game_stats, team_stats, game_teams_stats)
  end
<<<<<<< Updated upstream
 
=======
>>>>>>> Stashed changes
end
