class AllergiesForm
  include ActiveModel::Model

  attr_accessor :allergy_item_ids

  validates :allergy_item_ids, presence: true

  private

  def allergy_items_present
    errors.add(:allergy_item_ids, :blank) if allergy_item_ids.blank? || allergy_item_ids.reject(&:blank?).empty?
  end
end
