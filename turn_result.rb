class TurnResult
  def self.call(player_score, dealer_score)
    if player_score > 21
      :player_loss
    elsif player_score < 22 && player_score > dealer_score && dealer_score < 22
      :player_won
    elsif player_score == dealer_score
      :tie
    else
      :player_loss
    end
  end
end
