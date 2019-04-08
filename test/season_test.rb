require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/season'
require './lib/csv_util'
require './lib/stat_tracker'

class SeasonTest < Minitest::Test
  include Util
  attr_reader :season

  def setup
    @season = StatTracker.from_csv(locations).season unless season
  end

  def test_it_returns_name_of_team_with_most_hits
    assert_equal "Kings", @season.most_hits(20132014)
    assert_equal "Islanders", @season.most_hits(20142015)
  end

  def test_it_returns_name_of_team_with_least_hits
    assert_equal "Devils", @season.fewest_hits(20132014)
    assert_equal "Wild", @season.fewest_hits(20142015)
  end
end
