class Tag < ApplicationRecord
  belongs_to :local, optional: true
  belongs_to :article, optional: true
  TAG_FIELDS = %i[sea mountain river field hotspring north south
                  easy_to_go small_city car train
                  low_price moving_support entrepreneur_support child_care_support job_change_support
                  park education food architecture history event tourism].freeze

  def true_tags
    ret = []
    TAG_FIELDS.each do |tag_name|
      ret << tag_name if self[tag_name]
    end
    ret
  end

  def i18n_true_tags
    true_tags.map { |tag_name| Tag.human_attribute_name(tag_name) }
  end
end
