module Util

  private
  def self.locations
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

  def opponent_hash(home_or_away, team_1, team_2, game, team_id, opponents)
    if game[team_1] == team_id
      opponent_id = game[team_2]
      opponents[opponent_id] = {games_played:0, games_lost:0} if !opponents[opponent_id]
      opponents[opponent_id][:games_played] += 1
      if game[:outcome].include?(home_or_away)
        opponents[opponent_id][:games_lost] +=1
      end
    end
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

  def accumulate_games_and_wins(game, result, home_or_away, team_id)
    opponent_id = game[team_id]
    result[opponent_id] = {wins:0,games_played:0} unless result[opponent_id]
    result[opponent_id][:games_played] +=1
    result[opponent_id][:wins] += 1 if game[:outcome].include?(home_or_away)
  end

  def biggest_difference_goals(team_id, team_1_id, team_2_id)
    team_id = team_id.to_i
    result = 0
    @game_stats.each do |game|
      if game[team_1_id] == team_id && game[:outcome].include?("home")
        difference = game[:home_goals] - game[:away_goals]
        result = difference if difference > result
      elsif game[team_2_id] == team_id && game[:outcome].include?("away")
        difference = game[:away_goals] - game[:home_goals]
        result = difference if difference > result
      end
    end
    result
  end

  def accumulate_games_and_wins_in_a_season_by_team(result,game_ids,which_won_won,post_or_regular_games)
    @game_teams_stats.each do |game|
      if game_ids.include? game[:game_id]
      result[game[:team_id]] = {reg_won: 0, reg_total_games: 0, post_won: 0, post_total_games: 0} unless result[game[:team_id]]
      result[game[:team_id]][which_won_won] += 1  if game[:won].include?("TRUE")
      result[game[:team_id]][post_or_regular_games] += 1
      end
    end
  end

  def difference_between_post_and_regular_season_wins(season_id, min_or_max_by)
    season_id = season_id.to_i
    result = {}
    reg_game_ids = []
    post_game_ids = []
    @game_stats.each do |game|
      reg_game_ids << game[:game_id] if game[:season] == season_id && game[:type] == "R"
      post_game_ids << game[:game_id] if game[:season] == season_id && game[:type] == "P"
    end
    accumulate_games_and_wins_in_a_season_by_team(result,reg_game_ids,:reg_won, :reg_total_games)
    accumulate_games_and_wins_in_a_season_by_team(result,post_game_ids,:post_won, :post_total_games)
    team_id = result.send(min_or_max_by) do |team, stats|
      possible_diff = ((stats[:reg_won] + stats[:post_won]).to_f / (stats[:reg_total_games] + stats[:post_total_games]).to_f)
      (stats[:reg_won] / stats[:reg_total_games].to_f) - possible_diff
    end.first
    find_team_name(team_id)
  end

  def difference_between_coach_wins(season_id, min_or_max_by)
    season_id = season_id.to_i
    result = {}
    game_ids = []

    @game_stats.each do |game|
      game_ids << game[:game_id] if game[:season] == season_id
    end

    @game_teams_stats.each do |game|
      if game_ids.include? game[:game_id]
      result[game[:head_coach]] = {won: 0, total_games: 0} unless result[game[:head_coach]]
      result[game[:head_coach]][:won] += 1  if game[:won].include?("TRUE")
      result[game[:head_coach]][:total_games] += 1
      end
    end

    result.send(min_or_max_by) do |coach, stats|
      stats[:won]/stats[:total_games].to_f
    end.first
  end
end
