class Season

  def initialize(game_stats, game_teams_stats, team_stats)
    @game_stats= game_stats
    @game_teams_stats = game_teams_stats
    @team_stats = team_stats
  end




  def most_hits(season)
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
    team_hits = teams_with_hits.min_by do |team, hits|
      hits
    end
      @team_stats.find do |team|
      team[:team_id] == team_hits.first
    end[:teamname]
  end
end
