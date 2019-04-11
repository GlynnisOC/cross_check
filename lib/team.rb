module Team

  def team_info(team_id)
    default = { "team_id"=>nil, "franchise_id"=>nil, "short_name"=>nil,
               "team_name"=>nil, "abbreviation"=>nil,"link"=>nil}

    @team_stats.inject({}) do |result, team|
      values_as_strings = team.to_h.values.map { |val| val.to_s }
      result = Hash[default.keys.zip(values_as_strings)] if team[:team_id].to_s == team_id
      result
    end
  end

  def best_season(team_id)
    best_or_worst_season(team_id, :max_by)
  end

  def worst_season(team_id)
    best_or_worst_season(team_id, :min_by)
  end

  def average_win_percentage(team_id)
    team_id = team_id.to_i
    num_games_played = 0
    num_games_won = 0
    @game_teams_stats.each do |game|
      if game[:team_id] == team_id
        num_games_played += 1
        num_games_won += 1  if game[:won].include? "TRUE"
      end
    end
    (num_games_won/num_games_played.to_f).round(2)
  end

  def most_goals_scored(team_id)
    team_id = team_id.to_i
    @game_teams_stats.max_by do |game|
      (game[:team_id] == team_id) ? game[:goals] : 0
    end[:goals]
  end

  def fewest_goals_scored(team_id)
    team_id = team_id.to_i
    @game_teams_stats.min_by do |game|
      (game[:team_id] == team_id) ? game[:goals] : 1000000
    end[:goals]
  end

  def favorite_opponent(team_id)
    team_id = team_id.to_i
    opponents = {}

    @game_stats.each do |game|
      opponent_hash("home", :home_team_id, :away_team_id, game, team_id, opponents)
      opponent_hash("away", :away_team_id, :home_team_id, game, team_id, opponents)
    end
    fav_opp = opponents.max_by { |team, stats|  stats[:games_lost]/stats[:games_played].to_f }.shift
    @team_stats.find { |team| team[:team_id] == fav_opp }[:teamname]
  end

  def rival(team_id)
    team_id = team_id.to_i
    opponents = {}

    @game_stats.each do |game|
      opponent_hash("away", :away_team_id, :home_team_id, game, team_id, opponents)
      opponent_hash("home", :home_team_id, :away_team_id, game, team_id, opponents)
    end
    fav_opp = opponents.min_by { |team, stats|  stats[:games_lost]/stats[:games_played].to_f }.shift
    @team_stats.find { |team| team[:team_id] == fav_opp }[:teamname]
  end

  def biggest_team_blowout(team_id)
    biggest_difference_goals(team_id,:home_team_id,:away_team_id)
  end

  def worst_loss(team_id)
      biggest_difference_goals(team_id,:away_team_id,:home_team_id)
  end

  def head_to_head(team_id)
    team_id = team_id.to_i
    result = {}
    @game_stats.each do |game|
      if game[:home_team_id] == team_id
        accumulate_games_and_wins(game,result,"home", :away_team_id)
      elsif game[:away_team_id] == team_id
        accumulate_games_and_wins(game, result, "away", :home_team_id)
      end
    end

    teams_as_hash = {}
    result.each do |id, stats|
      team_name = find_team_name(id)
      teams_as_hash[team_name] = (stats[:wins]/stats[:games_played].to_f).round(2)
    end
    teams_as_hash
  end

  def seasonal_summary(team_id)
    team_id = team_id.to_i
    result = {}
    tally = {}

    @game_stats.each do |game|
      season = game[:season]
      result[season] = {} unless result[season]
      tally[season] = {post:0,regular:0} unless tally[season]
      if game[:type] == "R"
        season_results(:regular_season, result[season])
        if game[:home_team_id] == team_id
          accumulate_goals_in_regular_season!(tally[season], result[season], game, "home")
        elsif game[:away_team_id] == team_id
          accumulate_goals_in_regular_season!(tally[season], result[season], game, "away")
        end
      else
        season_results(:postseason, result[season])
        if game[:home_team_id] == team_id
          accumulate_goals_in_postseason!(tally[season], result[season], game, "home")
        elsif game[:away_team_id] == team_id
          accumulate_goals_in_postseason!(tally[season], result[season], game, "away")
        end
      end
    end
    output = result.clone
    result.each do |season_id, stats|
      games = tally[season_id][:regular].to_f
      pgames = tally[season_id][:post].to_f
      output[season_id][:regular_season][:win_percentage] = (stats[:regular_season][:win_percentage]/games).round(2)
      output[season_id][:regular_season][:average_goals_scored] = (stats[:regular_season][:total_goals_scored]/games).round(2)
      output[season_id][:regular_season][:average_goals_against] = (stats[:regular_season][:total_goals_against]/games).round(2)
      win_percentage =  (stats[:postseason][:win_percentage]/pgames).round(2)
      average_goals_scored = (stats[:postseason][:total_goals_scored]/pgames).round(2)
      average_goals_against =  (stats[:postseason][:total_goals_against]/pgames).round(2)
      output[season_id][:postseason][:win_percentage] = (win_percentage.nan?) ? 0 : win_percentage
      output[season_id][:postseason][:average_goals_scored] =  (average_goals_scored.nan?) ? 0 : average_goals_scored
      output[season_id][:postseason][:average_goals_against] = (average_goals_against.nan?) ? 0 : average_goals_against
    end
    output.inject({}) do |acc, (k,v)|
      acc[k.to_s] = v
      acc
    end
  end
end
