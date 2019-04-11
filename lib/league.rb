module League

  def count_of_teams
    @team_stats.count
  end

  def best_offense
   team_with_best_or_worst_offense(:max_by, @game_teams_stats)
  end

  def worst_offense
   team_with_best_or_worst_offense(:min_by, @game_teams_stats)
  end

  def best_defense
    team_with_best_or_worst_defense(:min_by, @game_stats)
  end

  def worst_defense
    team_with_best_or_worst_defense(:max_by, @game_stats)
  end

  def highest_scoring_visitor
    team_highest_score_home_or_away(:max_by, @game_stats, :away_team_id)
  end

  def highest_scoring_home_team
    team_highest_score_home_or_away(:max_by, @game_stats, :home_team_id)
  end

  def lowest_scoring_visitor
    result = {}
    @game_stats.each do |game|
      away_id = game[:away_team_id]
      result[away_id] = {games_played: 0, goals: 0} unless result[away_id]
      result[away_id][:games_played]+=1
      result[away_id][:goals]+= game[:away_goals]
    end
    team_id = result.min_by do |id, stats|
      (stats[:goals]/stats[:games_played].to_f).round(2)
    end.first
   find_team_name(team_id)
  end

  def lowest_scoring_home_team
    result = {}
    @game_stats.each do |game|
      home_id = game[:home_team_id]
      result[home_id] = {games_played: 0, goals: 0} unless result[home_id]
      result[home_id][:games_played]+=1
      result[home_id][:goals]+= game[:home_goals]
    end
    team_id = result.min_by do |id, stats|
      (stats[:goals]/stats[:games_played].to_f).round(2)
    end.first
   find_team_name(team_id)
  end

  def winningest_team
    result = {}
    @game_teams_stats.each do |game|
      team_id = game[:team_id]
      result[team_id] = {wins: 0, total_games: 0} unless result[team_id]
      result[team_id][:total_games]+=1
      result[team_id][:wins]+=1 if game[:won].include?("TRUE")
    end
    team_id = result.max_by do |id, stats|
      (stats[:wins]/stats[:total_games].to_f).round(2)
    end.first
   find_team_name(team_id)
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
   find_team_name(team_id)
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

    array_of_team_ids.map do |team_id|
      found_team = @team_stats.select { |team| team[:team_id] == team_id }
      found_team[:teamname]
    end

  end
end
