class AllergiesForm
  include ActiveModel::Model

  attr_accessor :allergy_item_ids

  validates :allergy_item_ids, presence: true
  validate :validate_allergy_item_ids

  private

  def allergy_items_present
    errors.add(:allergy_item_ids, :blank) if allergy_item_ids.blank? || allergy_item_ids.reject(&:blank?).empty?
  end

  def validate_allergy_item_ids
    # アレルギー項目IDがすべてAllergyItemテーブルに存在するか確認
    allergy_item_ids.reject(&:blank?).each do |id|
      unless AllergyItem.exists?(id: id)
        errors.add(:allergy_item_ids, :invalid, message: "contains invalid item id #{id}")
      end
    end
  end
end
