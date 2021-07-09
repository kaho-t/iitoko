class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def difference_rate(account)
    u_score = account.score.attributes.except('id', 'created_at', 'updated_at', 'user_id', 'local_id')
    # l_score = Score.where.not(local_id: nil)
    l_score = score.attributes.except('id', 'created_at', 'updated_at', 'user_id', 'local_id')
    diffs = []

    l_score.each do |key, value|
      dif = u_score[key] - value
      if dif.zero?
        diffs << 100
      elsif [1, -1].include?(dif)
        diffs << 80
      elsif [2, -2].include?(dif)
        diffs << 60
      elsif [3, -3].include?(dif)
        diffs << 40
      elsif [4, -4].include?(dif)
        diffs << 20
      elsif [5, -5].include?(dif)
        diffs << 0
      end
    end
    sum = 0
    diffs.each do |n|
      sum += n
    end
    sum / 6
  end
end
