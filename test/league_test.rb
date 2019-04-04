require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/league'
require './lib/stat_tracker'

class LeagueTest < Minitest::Test

  def setup
    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats.csv'



    locations = {
      games: game_path,
      teams: team_path,

      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @league = @stat_tracker.league
  end

  def test_it_exists
    assert_instance_of League, @league
  end

  def test_it_returns_total_number_of_teams
    assert_equal 33, @league.count_of_teams
  end

  def test_it_returns_team_name_with_best_offense
    assert_equal "Golden Knights", @league.best_offense
  end

  def test_it_returns_team_name_with_worst_offense
    assert_equal "Sabres", @league.worst_offense
  end
end

# best_defense	Name of the team with the lowest average number of goals allowed per game across all seasons.	String
# worst_defense	Name of the team with the highest average number of goals allowed per game across all seasons.	String
# highest_scoring_visitor	Name of the team with the highest average score per game across all seasons when they are away.	String
# highest_scoring_home_team	Name of the team with the highest average score per game across all seasons when they are home.	String
# lowest_scoring_visitor	Name of the team with the lowest average score per game across all seasons when they are a visitor.	String
# lowest_scoring_home_team	Name of the team with the lowest average score per game across all seasons when they are at home.	String
# winningest_team	Name of the team with the highest win percentage across all seasons.	String
# best_fans	Name of the team with biggest difference between home and away win percentages.	String
# worst_fans	List of names of all teams with better away records than home records.	Array
