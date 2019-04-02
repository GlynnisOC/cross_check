require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/stat_tracker'

class GameTest < Minitest::Test

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
    @game = @stat_tracker.game
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_highest_total_score
    assert_equal 9, @game.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 3, @game.lowest_total_score
  end

  def test_it_returns_biggest_blowout
    assert_equal 5, @game.biggest_blowout
  end
end
