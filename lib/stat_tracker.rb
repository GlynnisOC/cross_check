require 'CSV'
require './lib/game'
require './lib/season'
require './lib/league'
require './lib/team'


class StatTracker
  attr_reader  :game, :season, :league, :team

  def initialize(game, season, league, team)
    @game = game
    @season = season
    @league = league
    @team = team
  end

  def self.from_csv(input)
    @game_stats = CSV.read(input[:games],
      {headers: true, header_converters: :symbol, converters: :numeric}.merge(Hash.new))
    @game_teams_stats = CSV.read(input[:game_teams],
      {headers: true, header_converters: :symbol, converters: :numeric}.merge(Hash.new))
    @teams_stats = CSV.read(input[:teams],
      {headers:true, header_converters: :symbol, converters: :numeric}.merge(Hash.new))

      @game = Game.new(@game_stats, @game_teams_stats, @teams_stats)
      @season = Season.new(@game_stats, @game_teams_stats, @teams_stats)
      @league = League.new(@game_stats, @game_teams_stats, @teams_stats)
      @team = Team.new(@game_stats, @game_teams_stats, @teams_stats)
      StatTracker.new(@game, @season, @league, @team)
  end
 
end
