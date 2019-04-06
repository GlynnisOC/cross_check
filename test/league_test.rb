require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/league'
require './lib/csv_util'
require './lib/stat_tracker'

class LeagueTest < Minitest::Test
  include Util
  attr_reader :league

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

  def test_it_returns_team_name_with_best_defense
    assert_equal "Kings", @league.best_defense
  end

  def test_it_returns_team_name_with_worst_defense
    assert_equal "Coyotes", @league.worst_defense
  end

  def test_it_returns_team_name_with_highest_scoring_visitor
    assert_equal "Capitals", @league.highest_scoring_visitor
  end

  def test_it_returns_team_name_with_highest_scoring_home_team
    assert_equal "Golden Knights", @league.highest_scoring_home_team
  end

  def test_it_returns_team_name_with_lowest_scoring_visitor
    assert_equal "Sabres", @league.lowest_scoring_visitor
  end

  def test_it_returns_team_name_with_lowest_scoring_home_team
    assert_equal "Sabres", @league.lowest_scoring_home_team
  end

  def test_it_returns_team_name_with_highest_win_percentage
    assert_equal "Golden Knights", @league.winningest_team
  end

  def test_it_returns_team_name_with_best_fans
    assert_equal "Coyotes", @league.best_fans
  end

  def test_it_returns_array_all_teams_with_better_away_records
    assert_equal [], @league.worst_fans
  end
end
