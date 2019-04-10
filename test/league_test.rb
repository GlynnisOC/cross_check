require './test/test_helper'

class LeagueTest < Minitest::Test
  include Util

  def setup
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_returns_total_number_of_teams
    assert_equal 33, @stat_tracker.count_of_teams
  end

  def test_it_returns_team_name_with_best_offense
    assert_equal "Golden Knights", @stat_tracker.best_offense
  end

  def test_it_returns_team_name_with_worst_offense
    assert_equal "Sabres", @stat_tracker.worst_offense
  end

  def test_it_returns_team_name_with_best_defense
    assert_equal "Kings", @stat_tracker.best_defense
  end

  def test_it_returns_team_name_with_worst_defense
    assert_equal "Coyotes", @stat_tracker.worst_defense
  end

  def test_it_returns_team_name_with_highest_scoring_visitor
    assert_equal "Capitals", @stat_tracker.highest_scoring_visitor
  end

  def test_it_returns_team_name_with_highest_scoring_home_team
    assert_equal "Golden Knights", @stat_tracker.highest_scoring_home_team
  end

  def test_it_returns_team_name_with_lowest_scoring_visitor
    assert_equal "Sabres", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_returns_team_name_with_lowest_scoring_home_team
    assert_equal "Sabres", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_returns_team_name_with_highest_win_percentage
    assert_equal "Golden Knights", @stat_tracker.winningest_team
  end

  def test_it_returns_team_name_with_best_fans
    assert_equal "Coyotes", @stat_tracker.best_fans
  end

  def test_it_returns_array_all_teams_with_better_away_records
    assert_equal [], @stat_tracker.worst_fans
  end
end
