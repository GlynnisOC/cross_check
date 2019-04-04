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
      id = game[:team_id]
      result[id] = {games_played: 0, goals: 0} unless result[id]
      result[id][:games_played]+=1
      result[id][:goals] += game[:goals]
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
      id = game[:team_id]
      result[id] = {games_played: 0, goals: 0} unless result[id]
      result[id][:games_played]+=1
      result[id][:goals] += game[:goals]
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
end
# require 'pry';binding.pry
