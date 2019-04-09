module Game

  def highest_total_score
    goal_getter(:max_by, @game_stats, :+)
  end

  def lowest_total_score
    goal_getter(:min_by, @game_stats, :+)
  end

  def biggest_blowout
    goal_getter(:max_by, @game_stats, :-)
  end

  def percentage_home_wins
   game_percentage_wins("home")
  end

  def percentage_visitor_wins
    game_percentage_wins("away")
  end

  def count_of_games_by_season
    total_games_by_season = {}
    @game_stats.each do |game|
      season_id = game[:season].to_s
      total_games_by_season[season_id] = 0 if !total_games_by_season[season_id]
        total_games_by_season[season_id] += 1
    end
    total_games_by_season
  end

  def average_goals_per_game
    total_games = 0
    total_goals = 0
    @game_stats.each do |game|
      total_games += 1
      total_goals += game[:away_goals] + game[:home_goals]
    end
    (total_goals / total_games.to_f).round(2)
  end

  def average_goals_by_season
    total_goals_per_season = {}
    @game_stats.each do |game|
      season_id = game[:season].to_s
      total_goals_per_season[season_id] = 0 if !total_goals_per_season[season_id]
        total_goals_per_season[season_id] += game[:away_goals] + game[:home_goals]
    end
    total_goals_per_season.each_with_index do |(season, goals), index|

      total_goals_per_season[season] = (goals.to_f / count_of_games_by_season.values[index]).round(2)
    end
    total_goals_per_season
  end
end
