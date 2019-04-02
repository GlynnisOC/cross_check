require 'CSV'

class StatTracker

  attr_reader :game_stats, :game_teams_stats, :team_stats

  def self.from_csv(input)
    game_stats = CSV.read(input[:games], {headers: true, header_converters: :symbol, converters: :numeric}.merge(Hash.new))
    game_teams_stats = CSV.read(input[:game_teams], {headers: true, header_converters: :symbol, converters: :numeric}.merge(Hash.new))
    teams_stats = CSV.read(input[:teams], {headers:true, header_converters: :symbol, converters: :numeric}.merge(Hash.new))
  end
end
