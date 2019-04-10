module Util

  private
  def locations
    game_path = './data/game.csv'
    team_path = './data/team_info.csv'
    game_teams_path = './data/game_teams_stats.csv'

    {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
  end

  def goal_getter(min_or_max_by, game_stats, operator)
   game =  game_stats.send(min_or_max_by) do |inner_game|
     inner_game[:home_goals].send(operator, inner_game[:away_goals] )
    end
    game[:home_goals] + game[:away_goals]
  end

  def game_percentage_wins(home_or_away)
    counter = 0
    @game_stats.each {|game| counter += 1 if game[:outcome].include?(home_or_away) }
    (counter.to_f / @game_stats.count).round(2)
  end

  def find_team_name(team_id)
    @team_stats.each{|team| return team[:teamname] if team[:team_id] == team_id }
  end

  def find_team_id(result, min_or_max_by)
    result.send(min_or_max_by) do |team_id, stats|
      (stats[:goals]/stats[:games_played].to_f).round(2)
    end.first
  end

  def team_with_best_or_worst_offense(min_or_max_by, game_teams_stats)
    result = {}
    game_teams_stats.each do |game|
      team_id = game[:team_id]
      result[team_id] = {games_played: 0, goals: 0} unless result[team_id]
      result[team_id][:games_played] += 1
      result[team_id][:goals] += game[:goals]
    end
    team_id = find_team_id(result, min_or_max_by)
    find_team_name(team_id)
  end

  def team_with_best_or_worst_defense(min_or_max_by, game_stats)
    result = {}
    game_stats.each do |game|
      away_id = game[:away_team_id]
      home_id = game[:home_team_id]
      result[away_id] = {games_played: 0, goals: 0} unless result[away_id]
      result[home_id] = {games_played: 0, goals: 0} unless result[home_id]
      result[away_id][:games_played]+=1
      result[home_id][:games_played]+=1
      result[away_id][:goals]+= game[:home_goals]
      result[home_id][:goals]+= game[:away_goals]
    end
    team_id = find_team_id(result, min_or_max_by)
    find_team_name(team_id)
  end

  def team_highest_score_home_or_away(min_or_max_by, game_stats, home_or_away)
    result = {}
    team_goals = (home_or_away == :away_team_id) ? :away_goals : :home_goals
    game_stats.each do |game|
      team_id = game[home_or_away]
      result[team_id] = {games_played: 0, goals: 0} unless result[team_id]
      result[team_id][:games_played]+=1
      result[team_id][:goals]+= game[team_goals]
    end
    team_id = find_team_id(result, min_or_max_by)
    find_team_name(team_id)
  end

  def best_or_worst_season(team_id, max_by_or_min_by)
    team_id = team_id.to_i
    summary = @game_stats.reduce({}) do |total, game|
      total[game[:season]] = {games_played: 0, games_won: 0} unless total[game[:season]]
      if game[:away_team_id] == team_id
        total[game[:season]][:games_played] += 1
        total[game[:season]][:games_won] += 1 if game[:outcome].include?("away")
      end
      if game[:home_team_id] == team_id
        total[game[:season]][:games_played] += 1
        total[game[:season]][:games_won] += 1 if game[:outcome].include?("home")
      end
      total
    end
    summary.send(max_by_or_min_by) do |season, stats|
      (stats[:games_won].to_f / stats[:games_played]) * 100
    end.first.to_s
  end

  def season_results(reg_or_postseason, result_season)
    if !result_season[reg_or_postseason]
      result_season[reg_or_postseason] ={
                                         win_percentage:0,
                                         total_goals_scored:0,
                                         total_goals_against:0,
                                         average_goals_scored:0,
                                         average_goals_against:0
    }
    end
  end

  def accumulate_goals_in_regular_season!(tally_season, result_season, game, home_or_away)
    team_goals = ("home" == home_or_away) ? :home_goals  : :away_goals
    opponent_goals = ("home" != home_or_away) ? :home_goals  : :away_goals
    tally_season[:regular] += 1
    reg_s =  result_season[:regular_season]
    reg_s[:total_goals_scored] += game[team_goals]
    result_season[:regular_season][:total_goals_against] += game[opponent_goals]
    result_season[:regular_season][:win_percentage] += 1 if game[:outcome].include?(home_or_away)
  end

  def accumulate_goals_in_postseason!(tally_season, result_season, game, home_or_away)
    team_goals = ("home" == home_or_away) ? :home_goals  : :away_goals
    opponent_goals = ("home" != home_or_away) ? :home_goals  : :away_goals
    tally_season[:post] += 1
    post_s =  result_season[:postseason]
    post_s[:total_goals_scored] += game[team_goals]
    result_season[:postseason][:total_goals_against] += game[opponent_goals]
    result_season[:postseason][:win_percentage] += 1 if game[:outcome].include?(home_or_away)
  end



end
