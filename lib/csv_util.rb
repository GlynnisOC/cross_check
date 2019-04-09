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
  end

end
