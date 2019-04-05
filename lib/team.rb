class Team

  def initialize(game_stats, game_teams_stats, team_stats)
    @game_stats= game_stats
    @game_teams_stats = game_teams_stats
    @team_stats = team_stats
  end

  def team_info(team_id)
    default = { "team_id"=>nil, "franchise_id"=>nil, "short_name"=>nil,
               "team_name"=>nil, "abbreviation"=>nil,"link"=>nil}

    @team_stats.inject({}) do |result, team|
      values_as_strings = team.to_h.values.map { |val| val.to_s }

      result = Hash[default.keys.zip(values_as_strings)] if team[:team_id] == team_id
      result
    end

  end

  def best_season(team_id)
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
    summary.max_by do |season, stats|
      (stats[:games_won].to_f / stats[:games_played]) * 100
      end.first
  end

  def worst_season(team_id)
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
    summary.min_by do |season, stats|
      (stats[:games_won].to_f / stats[:games_played]) * 100
    end.first
  end

  def average_win_percentage(team_id)
    num_games_played = 0
    num_games_won = 0
    @game_teams_stats.each do |game|
      if game[:team_id] == team_id
        num_games_played += 1
        if game[:won].include? "TRUE"
          num_games_won += 1
        end
      end
    end
    ((num_games_won/num_games_played.to_f) * 100).round(2)
  end

  def most_goals_scored(team_id)
    @game_teams_stats.max_by do |game|
      if game[:team_id] == team_id
        game[:goals]
      else
        0
      end
    end[:goals]
  end

  def fewest_goals_scored(team_id)
    @game_teams_stats.min do |game|
      (game[:team_id] == team_id) ? game[:goals] : Float::INFINITY
    end[:goals]
  end

  def favorite_opponent(team_id)
    opponents = {}

    @game_stats.each do |game|
      if game[:away_team_id] == team_id
        opponent_id = game[:home_team_id]
        opponents[opponent_id] = {games_played:0, games_lost:0} if !opponents[opponent_id]
        opponents[opponent_id][:games_played] += 1
        if game[:outcome].include?("away")
          opponents[opponent_id][:games_lost] +=1
        end
      end

      if game[:home_team_id] == team_id
        opponent_id = game[:away_team_id]
        opponents[opponent_id] = {games_played:0, games_lost:0} if !opponents[opponent_id]
        opponents[opponent_id][:games_played] += 1
        if game[:outcome].include?("home")
          opponents[opponent_id][:games_lost] +=1
        end
      end

    end
    fav_opp = opponents.max_by { |team, stats|  stats[:games_lost]/stats[:games_played]}.shift
    @team_stats.find { |team| team[:team_id] == fav_opp }[:teamname]
  end

  def rival(team_id)
    opponents = {}

    @game_stats.each do |game|
      if game[:away_team_id] == team_id
        opponent_id = game[:home_team_id]

        opponents[opponent_id] = {games_played:0, games_lost:0} if !opponents[opponent_id]
        opponents[opponent_id][:games_played] += 1
        if game[:outcome].include?("away")
          opponents[opponent_id][:games_lost] +=1
        end
      end

      if game[:home_team_id] == team_id
        opponent_id = game[:away_team_id]
        opponents[opponent_id] = {games_played:0, games_lost:0} if !opponents[opponent_id]
        opponents[opponent_id][:games_played] += 1
        if game[:outcome].include?("home")
          opponents[opponent_id][:games_lost] +=1
        end
      end

    end
    fav_opp = opponents.min_by { |team, stats|  stats[:games_lost]/stats[:games_played]}.shift
    @team_stats.find { |team| team[:team_id] == fav_opp }[:teamname]
  end

  def biggest_team_blowout(team_id)
    result = 0
    @game_stats.each do |game|
      if game[:home_team_id] == team_id && game[:outcome].include?("home")
        difference = game[:home_goals] - game[:away_goals]
        result = difference if difference > result
      elsif game[:away_team_id] == team_id && game[:outcome].include?("away")
        difference = game[:away_goals] - game[:home_goals]
        result = difference if difference > result
      end
    end
    result
  end

  def worst_loss(team_id)
    result = 0
    @game_stats.each do |game|
      if game[:home_team_id] == team_id && game[:outcome].include?("away")
        difference = game[:away_goals] - game[:home_goals]
        result = difference if difference > result
      elsif game[:away_team_id] == team_id && game[:outcome].include?("home")
        difference = game[:home_goals] - game[:away_goals]
        result = difference if difference > result
      end
    end
    result
  end

  def head_to_head(team_id)
    result = {}
    @game_stats.each do |game|
      if game[:home_team_id] == team_id
        opponent_id = game[:away_team_id]
        result[opponent_id] = {wins:0,games_played:0} unless result[opponent_id]
        result[opponent_id][:games_played] +=1
        result[opponent_id][:wins] += 1 if game[:outcome].include?("home")
      elsif game[:away_team_id] == team_id
        opponent_id = game[:home_team_id]
        result[opponent_id]= {wins:0, games_played:0} unless result[opponent_id]
        result[opponent_id][:games_played] += 1
        result[opponent_id][:wins] += 1 if game[:outcome].include?("away")
      end
    end

    result2 = {}
    result.each do |team|
      result2[team.first] = (team.last[:wins]/team.last[:games_played].to_f).round(2)
    end
    result3 = {}
    @team_stats.each do |team|
      result3[team[:teamname]] = result2[team[:team_id]] if result2[team[:team_id]]
    end
    result3
  end
end
 
