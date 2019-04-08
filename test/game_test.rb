require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/stat_tracker'
require 'pry'

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

  def test_it_returns_percentage_home_wins
    assert_equal 66.67, @game.percentage_home_wins
  end

  def test_it_returns_percentage_visitor_wins
    assert_equal 33.33, @game.percentage_visitor_wins
  end

  def test_count_of_games_by_season
    expected = {
      20122013=>14,
      20132014=>4,
      20142015=>6,
      20162017=>5,
      20152016=>1
    }

    assert_equal expected, @game.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 5.4, @game.average_goals_per_game
  end

  def test_average_goals_per_game_per_season
    expected = {
      20122013=>4.929,
      20132014=>7.25,
      20142015=>4.833,
      20162017=>6.0,
      20152016=>5.0}
    assert_equal expected, @game.average_goals_by_season
  end
end
