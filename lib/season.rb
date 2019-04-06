class Season

  def initialize(game_stats, game_teams_stats, team_stats)
    @game_stats= game_stats
    @game_teams_stats = game_teams_stats
    @team_stats = team_stats
  end

  def biggest_bust
    # Name of the team with the biggest decrease
    # between regular season and postseason win
    # percentage.	String
  end

  def biggest_surprise
    # Name of the team with the biggest increase
    # between regular season and postseason win
    # percentage.	String
  end

  def winningest_coach
    # Name of the Coach with the best win percentage
    # for the season	String
  end

  def worst_coach
    # Name of the Coach with the worst win percentage
    # for the season	String
  end

  def most_accurate_team
    # Name of the Team with the best ratio of shots
    # to goals for the season	String
  end

  def least_accurate_team
    # Name of the Team with the worst ratio of shots
    # to goals for the season	String
  end

  def most_hits
    # Name of the Team with the most hits in the season	String
  end

  def fewest_hits
    # Name of the Team with the fewest hits in the season	String
  end

  def power_play_goal_percentage
    # Percentage of goals that were power play goals for the
    # season (rounded to the nearest 100th)	Float
  end

end
