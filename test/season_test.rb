require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/season'
require './lib/stat_tracker'
require 'pry'

class SeasonTest < MiniTest::Test
  attr_reader :season

  def setup
    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats.csv'



    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @season = StatTracker.from_csv(locations).season unless season

  end

  def test_season_exists
    assert_instance_of Season, @season
  end

  def test_biggest_bust
    assert_equal "Lightning", @season.biggest_bust(20132014)
    assert_equal "Jets", @season.biggest_bust(20142015)
  end

  def test_biggest_surprise
    assert_equal "Kings", @season.biggest_surprise(20132014)
    assert_equal "Blackhawks", @season.biggest_surprise(20142015)
  end

  def test_winningest_coach
      assert_equal "Alain Vigneault", season.winningest_coach(20142015)
  end
  #
  def test_worst_coach
    assert_equal "Peter Laviolette", @season.worst_coach(20132014)
    assert_equal "Craig MacTavish", @season.worst_coach(20142015)
  end

  def test_most_accurate_team
    assert_equal "Flames", @season.most_accurate_team(20142015)
    assert_equal "Ducks", @season.most_accurate_team(20132014)
  end

  def test_least_accurate_team
    assert_equal "Sabres", @season.least_accurate_team(20132014)
    assert_equal "Coyotes", @season.least_accurate_team(20142015)
  end

  def test_power_play_goal_percentage
    assert_equal 0.22, @season.power_play_goal_percentage(20132014)
    assert_equal 0.21, @season.power_play_goal_percentage(20142015)
  end

end
