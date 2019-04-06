module Util

  def locations
    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats.csv'

    {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    #This method returns the locations hash since it is the last value
  end

  def total_games_in_season(game_stats, season)
    game_stats.find_all { |game| game[:season] == season }.count
  end

end
