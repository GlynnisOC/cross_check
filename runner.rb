require './lib/stat_tracker'

game_path = './data/dummy_files/game_dummy.csv'
team_path = './data/dummy_files/team_dummy.csv'
game_teams_path = './data/dummy_files/game_teams_dummy.csv'



locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)
 
