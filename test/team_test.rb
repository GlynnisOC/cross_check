require './test/test_helper'

class TeamTest < Minitest::Test
    @@stat_tracker = StatTracker.from_csv(Util.locations)

  def test_it_returns_team_info
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "short_name" => "Nashville",
      "team_name" => "Predators",
      "abbreviation" => "NSH",
      "link" => "/api/v1/teams/18"
    }
    assert_equal expected, @@stat_tracker.team_info("18")
  end

  def test_it_returns_best_season
    assert_equal "20142015", @@stat_tracker.best_season(2)
  end

  def test_it_returns_worst_season
    assert_equal "20132014", @@stat_tracker.worst_season(2)
  end

  def test_it_returns_average_win_percentage
    assert_equal 0.49, @@stat_tracker.average_win_percentage(2)
  end

  def test_it_returns_most_goals_scored
    assert_equal 8, @@stat_tracker.most_goals_scored(2)
  end

  def test_it_returns_the_fewest_goals_scored
    assert_equal 0, @@stat_tracker.fewest_goals_scored(2)
  end

  def test_it_returns_favorite_opponent
    assert_equal "Golden Knights", @@stat_tracker.favorite_opponent(2)
  end

  def test_it_returns_rival
    assert_equal "Blackhawks", @@stat_tracker.rival(2)
  end

  def test_it_returns_biggest_team_blowout
    assert_equal 7, @@stat_tracker.biggest_team_blowout(18)
  end

  def test_it_returns_worst_loss
    assert_equal 6, @@stat_tracker.worst_loss(18)
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
    assert_equal expected, @@stat_tracker.head_to_head(18)
  end

  def test_it_can_return_seasonal_summary
    expected = {
      "20162017" => {
        postseason: {
          :win_percentage=>0.64,
          :total_goals_scored=>60,
          :total_goals_against=>48,
          :average_goals_scored=>2.73,
          :average_goals_against=>2.18},
          :regular_season => {
            :win_percentage=>0.5,
            :total_goals_scored=>240,
            :total_goals_against=>224,
            :average_goals_scored=>2.93,
            :average_goals_against=>2.73
          }
        },
        "20172018" => {
          postseason: {
            :win_percentage=>0.54,
            :total_goals_scored=>41,
            :total_goals_against=>42,
            :average_goals_scored=>3.15,
            :average_goals_against=>3.23
          },
          :regular_season=>
          {:win_percentage=>0.65,
            :total_goals_scored=>267,
            :total_goals_against=>211,
            :average_goals_scored=>3.26,
            :average_goals_against=>2.57
          }
        },
        "20132014" => {
          postseason: {
            :win_percentage=>0.0,
            :total_goals_scored=>0,
            :total_goals_against=>0,
            :average_goals_scored=>0.0,
            :average_goals_against=>0.0
          },
          :regular_season=>
          {
            :win_percentage=>0.46,
            :total_goals_scored=>216,
            :total_goals_against=>242,
            :average_goals_scored=>2.63,
            :average_goals_against=>2.95
          }
        },
        "20122013" => {
          postseason: {
            :win_percentage=>0.0,
            :total_goals_scored=>0,
            :total_goals_against=>0,
            :average_goals_scored=>0.0,
            :average_goals_against=>0.0
          },
          :regular_season=>
          {
            :win_percentage=>0.33,
            :total_goals_scored=>111,
            :total_goals_against=>139,
            :average_goals_scored=>2.31,
            :average_goals_against=>2.9
          }
        },
        "20142015" => {
          postseason: {
            :win_percentage=>0.33,
            :total_goals_scored=>21,
            :total_goals_against=>19,
            :average_goals_scored=>3.5,
            :average_goals_against=>3.17
          },
          :regular_season=>
          {
            :win_percentage=>0.57,
            :total_goals_scored=>232,
            :total_goals_against=>208,
            :average_goals_scored=>2.83,
            :average_goals_against=>2.54
          }
        },
        "20152016" => {
          postseason: {
            :win_percentage=>0.5,
            :total_goals_scored=>31,
            :total_goals_against=>43,
            :average_goals_scored=>2.21,
            :average_goals_against=>3.07
          },
          :regular_season=>
          {
            :win_percentage=>0.5,
            :total_goals_scored=>228,
            :total_goals_against=>215,
            :average_goals_scored=>2.78,
            :average_goals_against=>2.62
          }
        }
      }
    assert_equal expected, @@stat_tracker.seasonal_summary(18)
  end
end
