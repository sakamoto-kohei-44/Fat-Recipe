class AllergiesForm
  include ActiveModel::Model

  attr_accessor :allergy_item_ids

  validates :allergy_item_ids, presence: true
end
