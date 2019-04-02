class Game

  def initialize(game_stats, game_teams_stats, team_stats)
    @game_stats= game_stats
    @game_teams_stats = game_teams_stats
    @team_stats = team_stats
  end

  def highest_total_score
    game = @game_stats.max_by do |game|
      game[:home_goals] + game[:away_goals]
    end
    game[:home_goals] + game[:away_goals]
  end

  def lowest_total_score
    game = @game_stats.min_by do |game|
      game[:home_goals] + game[:away_goals]
    end
    game[:home_goals] + game[:away_goals]
  end

  def biggest_blowout
    game = @game_stats.max_by do |game|
      game[:home_goals] - game[:away_goals]
    end
    game[:home_goals] - game[:away_goals]
  end
end
