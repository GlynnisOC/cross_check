class Game
  attr_reader :total_goals

  def initialize(game_stats, game_teams_stats, team_stats)
    @game_stats= game_stats
    @game_teams_stats = game_teams_stats
    @team_stats = team_stats
    @total_goals = 0
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

  def percentage_home_wins
    counter = 0
    @game_stats.each do |game|
      counter += 1 if game[:outcome].include?("home")
    end
    ((counter.to_f / @game_stats.count) * 100).round(2)
  end

  def percentage_visitor_wins
    counter = 0
    @game_stats.each do |game|
      counter += 1 if game[:outcome].include?("away")
    end
    ((counter.to_f / @game_stats.count) * 100).round(2)
  end

  def count_of_games_by_season
    total_games_by_season = {}
    @game_stats.each do |game|
      total_games_by_season[game[:season]] = 0 if !total_games_by_season[game[:season]]
        total_games_by_season[game[:season]] += 1
    end
    total_games_by_season
  end

  def average_goals_per_game
    total_games = 0
    @total_goals = 0

    @game_stats.each do |game|
      total_games += 1
      @total_goals += game[:away_goals] + game[:home_goals]
    end
    @total_goals
    (@total_goals / total_games.to_f).round(3)
  end

  def average_goals_by_season

    total_goals_per_season = {}
    @game_stats.each do |game|
      total_goals_per_season[game[:season]] = 0 if !total_goals_per_season[game[:season]]
        total_goals_per_season[game[:season]] += game[:away_goals] + game[:home_goals]
    end
    total_goals_per_season.each_with_index do |(season, goals), index|

      total_goals_per_season[season] = (goals.to_f / count_of_games_by_season.values[index]).round(3)
    end

    total_goals_per_season

  end
# goal per season hash {20122013=>69, 20132014=>29, 20142015=>29,
  # 20162017=>30, 20152016=>5}
end

#Create method for # of games in a season
#would have to be able to pass in specific season

#Create method for # of goals in a season
#would have to be able to pass in specific season
