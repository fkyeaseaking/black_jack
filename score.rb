class Score
  def card_score(card)
    case card
    when 2..10
      card.to_i
    else
      10
    end
  end

  private

  

  def bust?(score)
    score > 21
  end
end
