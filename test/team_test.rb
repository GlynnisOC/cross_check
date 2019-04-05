require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/team'
require './lib/csv_util'

class TeamTest < Minitest::Test
  include Util
  attr_reader :team

  def setup
    @team = StatTracker.from_csv(locations).team unless team
  end

  def test_it_exist
    assert_instance_of Team, team
  end

  def test_it_returns_best_season
    assert_equal 20142015, team.best_season(2)
  end

  def test_it_returns_worst_season
    assert_equal 20132014, team.worst_season(2)
  end

  def test_it_returns_average_win_percentage
    assert_equal 48.96, team.average_win_percentage(2)
  end

  def test_it_returns_most_goals_scored
    assert_equal 8, team.most_goals_scored(2)
  end

  def test_it_returns_the_fewest_goals_scored
    assert_equal 2, team.fewest_goals_scored(2)
  end

  def test_it_returns_favorite_opponent
    assert_equal "Golden Knights", team.favorite_opponent(2)
  end

  def test_it_returns_rival
    assert_equal "Penguins", team.rival(2)
  end

  def test_it_returns_biggest_team_blowout
    assert_equal 7, team.biggest_team_blowout(18)
  end

  def test_it_returns_worst_loss
    assert_equal 6, team.worst_loss(18)
  end

  def test_it_returns_head_to_head_stats
    expected = {}
    assert_equal expected, team.head_to_head(18)
  end
end
