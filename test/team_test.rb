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

  def test_it_returns_team_info
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "short_name" => "Nashville",
      "team_name" => "Predators",
      "abbreviation" => "NSH",
      "link" => "/api/v1/teams/18"
    }
    assert_equal expected, team.team_info(18)
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
    expected = {"Devils"=>0.5,       
                "Flyers"=>0.5,
                "Kings"=>0.61,
                "Lightning"=>0.7,
                "Bruins"=>0.5,
                "Rangers"=>0.4,
                "Penguins"=>0.31,
                "Red Wings"=>0.29,
                "Sharks"=>0.6,
                "Canucks"=>0.5,
                "Blackhawks"=>0.42,
                "Senators"=>0.7,
                "Canadiens"=>0.6,
                "Wild"=>0.44,
                "Capitals"=>0.7,
                "Blues"=>0.47,
                "Ducks"=>0.48,
                "Coyotes"=>0.67,
                "Islanders"=>0.4,
                "Flames"=>0.44,
                "Avalanche"=>0.63,
                "Stars"=>0.52,
                "Panthers"=>0.5,
                "Maple Leafs"=>0.4,
                "Blue Jackets"=>0.6,
                "Jets"=>0.55,
                "Golden Knights"=>0.33,
                "Hurricanes"=>0.3,
                "Sabres"=>0.7,
                "Oilers"=>0.78}
    assert_equal expected, team.head_to_head(18)
  end

end
