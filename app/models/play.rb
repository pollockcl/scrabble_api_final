class Play < ApplicationRecord
  belongs_to :user
  belongs_to :game

  after_create :update_user

  def letter_scores
    {
      "A"=>1, "B"=>3, "C"=>3, "D"=>2, "E"=>1, "F"=>4, "G"=>2, "H"=>4, "I"=>1, "J"=>8,
      "K"=>5, "L"=>1, "M"=>3, "N"=>1, "O"=>1, "P"=>3, "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
      "U"=>1, "V"=>4, "W"=>4, "X"=>8, "Y"=>4, "Z"=>10
    }
  end

  def score
    update(score: score_word) unless self[:score]
    self[:score]
  end

  private

    def update_user
      user.score += score
      user.save
    end

    def score_word
      letters.map(&rate).sum
    end

    def rate 
      ->(element) { letter_scores["#{element.upcase}"] }
    end

    def letters
      word.chars
    end
end
