require 'CSV'

module CsvLoader

  def add_game_team_stats_to_array_of_hashes(games)
    game_stats = CSV.read('./data/game_teams_stats.csv')
    keys = game_stats.shift

    game_stats.map.with_index do |game_info|
      if game_info.include?("home")
        index = games.find_index { |game| game[:game_id] == game_info.first.to_i }
        games[index][:home_team] = {:id => games[index].delete(:home_team_id),
                                    :win=> game_info[3] == "TRUE",
                                    :settled_in=> game_info[4] == "OT" ? "OT" : "REG",
                                    :coach=> game_info[5],
                                    :goals=> game_info[6].to_i,
                                    :shots=> game_info[7].to_i,
                                    :hits=> game_info[8].to_i,
                                    :pim=> game_info[9].to_i,
                                    :power_play_opportunies=> game_info[10].to_i,
                                    :power_play_goals=> game_info[11].to_i,
                                    :face_off_win_percentage=> game_info[12].to_f,
                                    :giveaways=> game_info[13].to_i,
                                    :takeaways=> game_info[14].to_i
                                   }
        games[index]
      else
         index = games.find_index { |game| game[:game_id] == game_info.first.to_i }
        games[index][:away_team] = {:id => games[index].delete(:away_team_id),
                                    :win=> game_info[3] == "TRUE",
                                    :settled_in=> game_info[4] == "OT" ? "OT" : "REG",
                                    :coach=> game_info[5],
                                    :goals=> game_info[6].to_i,
                                    :shots=> game_info[7].to_i,
                                    :hits=> game_info[8].to_i,
                                    :pim=> game_info[9].to_i,
                                    :power_play_opportunies=> game_info[10].to_i,
                                    :power_play_goals=> game_info[11].to_i,
                                    :face_off_win_percentage=> game_info[12].to_f,
                                    :giveaways=> game_info[13].to_i,
                                    :takeaways=> game_info[14].to_i
                                   }
        games[index]
      end
     
    end

  end

  def self.create_array_of_game_hashes
    game = CSV.read('./data/game.csv')
    keys = game.shift
    game.reduce({}) do |hash, team|
 
      team.each.with_index do |ele, index|
        hash[keys[index].to_sym] = Integer(ele) rescue false ? Integer(ele): ele
      end
      hash
    end

  end

end
