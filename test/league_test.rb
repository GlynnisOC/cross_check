require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/league'
require './lib/stat_tracker'

class LeagueTest < Minitest::Test

  def setup
    game_path = './data/dummy_files/game_dummy.csv'
    team_path = './data/dummy_files/team_dummy.csv'
    game_teams_path = './data/dummy_files/game_teams_dummy.csv'



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
end
