module Season

  def biggest_bust(season_id)
    difference_between_post_and_regular_season_wins(season_id, :max_by)
  end

  def biggest_surprise(season_id)
    difference_between_post_and_regular_season_wins(season_id, :min_by)
  end

  def winningest_coach(season_id)
    difference_between_coach_wins(season_id, :max_by)
  end

  def worst_coach(season_id)
    difference_between_coach_wins(season_id, :min_by)
  end

  def most_accurate_team(season_id)
    season_id = season_id.to_i
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

    team_id = result.max_by do |id, stats|
      stats[:goals]/stats[:shots].to_f
    end

  @team_stats.each do |game|
      if game[:team_id] == team_id.first
        return game[:teamname]
      end
    end
  end

  def least_accurate_team(season_id)
    season_id = season_id.to_i
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

    team_id = result.min_by do |id, stats|
      stats[:goals]/stats[:shots].to_f
    end

    @team_stats.each do |game|
      if game[:team_id] == team_id.first
        return game[:teamname]
      end
    end
  end

  def most_hits(season)
    season = season.to_i
    game_ids = {}
    teams_with_hits = {}
    @game_stats.each do |game|
      if game[:season] == season
        game_id = game[:game_id]
        game_ids[game_id] = {}
      end
    end
    @game_teams_stats.each do |game|
      game_id = game[:game_id]
      team_id = game[:team_id]
      if game_ids[game_id]
        teams_with_hits[team_id] = 0 unless teams_with_hits[team_id]
        teams_with_hits[team_id] += game[:hits]
      end
    end
    team_hits = teams_with_hits.max_by do |team, hits|
      hits
    end
      @team_stats.find do |team|
      team[:team_id] == team_hits.first
    end[:teamname]
  end

  def fewest_hits(season)
    season = season.to_i
    game_ids = {}
    teams_with_hits = {}
    @game_stats.each do |game|
      if game[:season] == season
        game_id = game[:game_id]
        game_ids[game_id] = {}
      end
    end
    @game_teams_stats.each do |game|
      game_id = game[:game_id]
      team_id = game[:team_id]
      if game_ids[game_id]
        teams_with_hits[team_id] = 0 unless teams_with_hits[team_id]
        teams_with_hits[team_id] += game[:hits]
      end
    end
    team_id = teams_with_hits.min_by do |team, hits|
      hits
    end.first
    find_team_name(team_id)
  end

  def power_play_goal_percentage(season_id)
    season_id = season_id.to_i
    result = {}
    game_ids = []

    @game_stats.each do |game|
      game_ids << game[:game_id] if game[:season] == season_id
    end

    @game_teams_stats.each do |game|
      if game_ids.include? game[:game_id]
      result[:total] = {powerplay_goals: 0, goals: 0} unless result[:total]
      result[:total][:powerplay_goals] += game[:powerplaygoals]
      result[:total][:goals] += game[:goals]
      end
    end
    (result[:total][:powerplay_goals] / result[:total][:goals].to_f).round(2)
  end
end
