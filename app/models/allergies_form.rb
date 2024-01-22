class AllergiesForm
  include ActiveModel::Model

  attr_accessor :allergy_item_ids

  validate :validate_allergy_item_ids

  private

  def validate_allergy_item_ids
    if allergy_item_ids.blank? || allergy_item_ids.reject(&:blank?).empty?
      errors.add(:allergy_item_ids, :blank)
    end
  end
end
