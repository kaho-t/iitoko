class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def difference_rate(account)
    u_score = account.score.attributes.except("id", "created_at", "updated_at", "user_id", "local_id")
    # l_score = Score.where.not(local_id: nil)
    l_score = self.score.attributes.except("id", "created_at", "updated_at", "user_id", "local_id")
    diffs = []

    l_score.each do |key, value|
      dif = u_score[key] - value
      if dif == 0
        diffs << 100
      elsif dif == 1 || dif == -1
        diffs << 80
      elsif dif == 2 || dif == -2
        diffs << 60
      elsif dif == 3 || dif == -3
        diffs << 40
      elsif dif == 4 || dif == -4
        diffs << 20
      elsif dif == 5 || dif == -5
        diffs << 0
      end
    end
    sum = 0
    diffs.each do |n|
      sum += n
    end
    return sum / 6
  end



end
