class Season

  def initialize(game_stats, game_teams_stats, team_stats)
    @game_stats= game_stats
    @game_teams_stats = game_teams_stats
    @team_stats = team_stats
  end

  def biggest_bust(season_id)
    #get team wins & games played for regular season
    #get team wins & games played for postseason
    #find percentages and find biggest decrease

    # Name of the team with the biggest decrease
    # between regular season and postseason win
    # percentage.	String
  end

  def biggest_surprise(season_id)
    #get team wins & games played for regular season
    #get team wins & games played for postseason
    #find percentages and find biggest increase
    # Name of the team with the biggest increase
    # between regular season and postseason win
    # percentage.	String
  end

  def winningest_coach(season_id)
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
      result.max_by do |coach, stats|
      stats[:won]/stats[:total_games].to_f
    end.first
  end

  def worst_coach(season_id)
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
      result.min_by do |coach, stats|
      stats[:won]/stats[:total_games].to_f
    end.first
  end

  def most_accurate_team(season_id)
    result = {}
    game_ids = []

    @game_stats.each do |game|
      game_ids << game[:game_id] if game[:season] == season_id
    end

      @game_teams_stats.each do |game|
        if game_ids.include? game[:game_id]
        result[game[:team_id]] = {shots: 0, goals: 0} unless result[game[:team_id]]
        result[game[:team_id]][:shots] += game[:shots]
        result[game[:team_id]][:goals] += game[:goals]
        end
      end
      team_id = result.max_by do |team_id, stats|
        stats[:goals]/stats[:shots].to_f
    end
      team_name = @team_stats.each do |game|
        if game[:team_id] == team_id.first
          return game[:teamname]
        end
      end
  end

  def least_accurate_team(season_id)
    result = {}
    game_ids = []

    @game_stats.each do |game|
      game_ids << game[:game_id] if game[:season] == season_id
    end

      @game_teams_stats.each do |game|
        if game_ids.include? game[:game_id]
        result[game[:team_id]] = {shots: 0, goals: 0} unless result[game[:team_id]]
        result[game[:team_id]][:shots] += game[:shots]
        result[game[:team_id]][:goals] += game[:goals]
        end
      end
      team_id = result.min_by do |team_id, stats|
        stats[:goals]/stats[:shots].to_f
    end
      team_name = @team_stats.each do |game|
        if game[:team_id] == team_id.first
          return game[:teamname]
        end
      end
  end

  def most_hits(season_id)
    # Name of the Team with the most hits in the season	String
  end

  def fewest_hits(season_id)
    # Name of the Team with the fewest hits in the season	String
  end

  def power_play_goal_percentage(season_id)
    result = {}
    game_ids = []

    @game_stats.each do |game|
      game_ids << game[:game_id] if game[:season] == season_id
    end

      @game_teams_stats.each do |game|
        if game_ids.include? game[:game_id]
          # binding.pry
        result[:total] = {powerplay_goals: 0, goals: 0} unless result[:total]
        result[:total][:powerplay_goals] += game[:powerplaygoals]
        result[:total][:goals] += game[:goals]
        end
      end
      (result[:total][:powerplay_goals] / result[:total][:goals].to_f).round(2)
  end


end
