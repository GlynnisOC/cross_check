class League

  def initialize(game_stats, game_teams_stats, team_stats)
    @game_stats= game_stats
    @game_teams_stats = game_teams_stats
    @team_stats = team_stats
  end

  def count_of_teams
    @team_stats.count
  end

  def best_offense
    result = {}
    @game_teams_stats.each do |game|
      team_id = game[:team_id]
      result[team_id] = {games_played: 0, goals: 0} unless result[team_id]
      result[team_id][:games_played]+=1
      result[team_id][:goals] += game[:goals]
    end
    team_id = result.max_by do |team_id, stats|
      (stats[:goals]/stats[:games_played].to_f).round(2)
    end.first
    @team_stats.find do |team|
      team[:team_id] == team_id
    end[:teamname]
  end

  def worst_offense
    result = {}
    @game_teams_stats.each do |game|
      team_id = game[:team_id]
      result[team_id] = {games_played: 0, goals: 0} unless result[team_id]
      result[team_id][:games_played]+=1
      result[team_id][:goals] += game[:goals]
    end
    team_id = result.min_by do |team_id, stats|
      (stats[:goals]/stats[:games_played].to_f).round(2)
    end.first
    @team_stats.find do |team|
      team[:team_id] == team_id
    end[:teamname]
  end

  def best_defense
    result = {}
    @game_stats.each do |game|
      away_id = game[:away_team_id]
      home_id = game[:home_team_id]
      result[away_id] = {games_played: 0, goals: 0} unless result[away_id]
      result[home_id] = {games_played: 0, goals: 0} unless result[home_id]
      result[away_id][:games_played]+=1
      result[home_id][:games_played]+=1
      result[away_id][:goals]+= game[:home_goals]
      result[home_id][:goals]+= game[:away_goals]
    end
    team_id = result.min_by do |team_id, stats|
      (stats[:goals]/stats[:games_played].to_f).round(2)
    end.first
    @team_stats.find do |team|
      team[:team_id] == team_id
    end[:teamname]
  end

  def worst_defense
    result = {}
    @game_stats.each do |game|
      away_id = game[:away_team_id]
      home_id = game[:home_team_id]
      result[away_id] = {games_played: 0, goals: 0} unless result[away_id]
      result[home_id] = {games_played: 0, goals: 0} unless result[home_id]
      result[away_id][:games_played]+=1
      result[home_id][:games_played]+=1
      result[away_id][:goals]+= game[:home_goals]
      result[home_id][:goals]+= game[:away_goals]
    end
    team_id = result.max_by do |team_id, stats|
      (stats[:goals]/stats[:games_played].to_f).round(2)
    end.first
    @team_stats.find do |team|
      team[:team_id] == team_id
    end[:teamname]
  end

  def highest_scoring_visitor
    result = {}
    @game_stats.each do |game|
      away_id = game[:away_team_id]
      result[away_id] = {games_played: 0, goals: 0} unless result[away_id]
      result[away_id][:games_played]+=1
      result[away_id][:goals]+= game[:away_goals]
    end
    team_id = result.max_by do |team_id, stats|
      (stats[:goals]/stats[:games_played].to_f).round(2)
    end.first
    @team_stats.find do |team|
      team[:team_id] == team_id
    end[:teamname]
  end

  def highest_scoring_home_team
    result = {}
    @game_stats.each do |game|
      home_id = game[:home_team_id]
      result[home_id] = {games_played: 0, goals: 0} unless result[home_id]
      result[home_id][:games_played]+=1
      result[home_id][:goals]+= game[:home_goals]
    end
    team_id = result.max_by do |team_id, stats|
      (stats[:goals]/stats[:games_played].to_f).round(2)
    end.first
    @team_stats.find do |team|
      team[:team_id] == team_id
    end[:teamname]
  end

  def lowest_scoring_visitor
    result = {}
    @game_stats.each do |game|
      away_id = game[:away_team_id]
      result[away_id] = {games_played: 0, goals: 0} unless result[away_id]
      result[away_id][:games_played]+=1
      result[away_id][:goals]+= game[:away_goals]
    end
    team_id = result.min_by do |team_id, stats|
      (stats[:goals]/stats[:games_played].to_f).round(2)
    end.first
    @team_stats.find do |team|
      team[:team_id] == team_id
    end[:teamname]
  end

  def lowest_scoring_home_team
    result = {}
    @game_stats.each do |game|
      home_id = game[:home_team_id]
      result[home_id] = {games_played: 0, goals: 0} unless result[home_id]
      result[home_id][:games_played]+=1
      result[home_id][:goals]+= game[:home_goals]
    end
    team_id = result.min_by do |team_id, stats|
      (stats[:goals]/stats[:games_played].to_f).round(2)
    end.first
    @team_stats.find do |team|
      team[:team_id] == team_id
    end[:teamname]
  end

  def winningest_team
    result = {}
    @game_teams_stats.each do |game|
      team_id = game[:team_id]
      result[team_id] = {wins: 0, total_games: 0} unless result[team_id]
      result[team_id][:total_games]+=1
      result[team_id][:wins]+=1 if game[:won].include?("TRUE")
    end
    team_id = result.max_by do |team_id, stats|
      (stats[:wins]/stats[:total_games].to_f).round(2)
    end.first
    @team_stats.find do |team|
      team[:team_id] == team_id
    end[:teamname]
  end

  def best_fans
    result = {}
    @game_teams_stats.each do |game|
      team_id = game[:team_id]
      result[team_id] = {home: 0, home_wins: 0, away: 0, away_wins: 0} unless result[team_id]
      result[team_id][game[:hoa].to_sym] += 1
      result[team_id][:home_wins] += 1 if game[:hoa].include? "home" and game[:won].include? "TRUE"
      result[team_id][:away_wins] += 1 if game[:hoa].include? "away" and game[:won].include? "TRUE"
    end
    team_id = result.max_by do |team, stats|
      stats[:home_wins]/stats[:home].to_f - stats[:away_wins]/stats[:away].to_f
    end.first
    @team_stats.find do |team|
      team[:team_id] == team_id
    end[:teamname]
  end

  def worst_fans
    result = {}
    @game_teams_stats.each do |game|
      team_id = game[:team_id]
      result[team_id] = {home: 0, home_wins: 0, away: 0, away_wins: 0} unless result[team_id]
      result[team_id][game[:hoa].to_sym] += 1
      result[team_id][:home_wins] += 1 if game[:hoa].include? "home" and game[:won].include? "TRUE"
      result[team_id][:away_wins] += 1 if game[:hoa].include? "away" and game[:won].include? "TRUE"
    end
    array_of_team_ids = result.find_all do |team, stats|
      stats[:away_wins] > stats[:home_wins]
    end
    array_of_team_ids.find_all do |team_id|
      team[:team_id] == team_id
    end
  end
end
