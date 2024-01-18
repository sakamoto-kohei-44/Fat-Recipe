class UserAllergy < ApplicationRecord
  belongs_to :user
  belongs_to :allergy_item
end
